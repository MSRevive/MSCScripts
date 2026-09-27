"""Parser: builds AST from lexed lines.

MSCScript structure:
  - Event blocks: { eventname NAME [scope] ... statements ... }
  - Init blocks: { ... const/setvar/setvard statements ... } (no eventname)
  - Statements: commands, if/else, comments
  - If blocks: bare guards and parenthesized blocks with braces
"""

from __future__ import annotations

from ..ast_nodes import (
    Command, Comment, Condition, DollarFunc, EventBlock, Expression,
    IfBlock, Literal, RawLine, ScriptFile, Statement, VariableRef,
    VectorLiteral, Concatenation,
)
from ..errors import ErrorCollector
from .lexer import LexedFile, LexedLine, Token, TokenType
from .preprocessor import PreprocessedFile


class Parser:
    """Parses lexed MSCScript into an AST."""

    def __init__(self, lexed: LexedFile, preprocessed: PreprocessedFile, errors: ErrorCollector):
        self.lexed = lexed
        self.preprocessed = preprocessed
        self.errors = errors
        self.filename = lexed.filename
        self.pos = 0  # Current line index

    def parse(self) -> ScriptFile:
        script = ScriptFile(filename=self.filename)
        script.scope_directive = self.preprocessed.scope_directive
        script.includes = list(self.preprocessed.includes)

        while self.pos < len(self.lexed.lines):
            line = self.current_line()

            # Look for opening brace
            if self._line_starts_with(line, TokenType.OPEN_BRACE):
                event = self._parse_event_block()
                if event:
                    script.events.append(event)
            else:
                # Top-level line outside any block — skip with warning
                self.errors.warning(
                    f"Line outside event block: {line.raw}",
                    self.filename, line.line_number,
                )
                self.pos += 1

        return script

    def current_line(self) -> LexedLine:
        return self.lexed.lines[self.pos]

    def _line_starts_with(self, line: LexedLine, tt: TokenType) -> bool:
        for t in line.tokens:
            if t.type == TokenType.NEWLINE:
                return False
            if t.type == tt:
                return True
            return False
        return False

    def _non_newline_tokens(self, line: LexedLine) -> list[Token]:
        return [t for t in line.tokens if t.type != TokenType.NEWLINE]

    def _parse_event_block(self) -> EventBlock | None:
        """Parse { eventname NAME [scope] ... } block."""
        line = self.current_line()
        tokens = self._non_newline_tokens(line)

        if not tokens or tokens[0].type != TokenType.OPEN_BRACE:
            self.pos += 1
            return None

        block_line = line.line_number
        event_name = ""
        scope = ""
        is_init = True

        # Check if event name / scope tag is on the same line as {
        rest = tokens[1:]
        if rest:
            event_name, scope, rest = self._extract_event_header(rest)
            if event_name:
                is_init = False

        self.pos += 1

        body_statements: list[Statement] = []
        found_close = False

        while self.pos < len(self.lexed.lines):
            line = self.current_line()
            tokens = self._non_newline_tokens(line)

            if not tokens:
                self.pos += 1
                continue

            # Closing brace for the event block
            if tokens[0].type == TokenType.CLOSE_BRACE:
                self.pos += 1
                found_close = True
                break

            # Check for eventname keyword
            if tokens[0].type == TokenType.EVENTNAME_KW:
                if len(tokens) > 1:
                    event_name = tokens[1].value
                    is_init = False
                    if len(tokens) > 2 and tokens[2].type == TokenType.SCOPE_TAG:
                        scope = tokens[2].value
                self.pos += 1
                continue

            # Check for repeatdelay
            if tokens[0].type == TokenType.REPEATDELAY_KW:
                stmt = self._parse_command(tokens, line)
                if stmt:
                    body_statements.append(stmt)
                self.pos += 1
                continue

            # Scope tag on its own line
            if tokens[0].type == TokenType.SCOPE_TAG and len(tokens) == 1:
                scope = tokens[0].value
                self.pos += 1
                continue

            # Parse statement — this may advance self.pos for multi-line constructs
            stmts = self._parse_statements_at_current()
            body_statements.extend(stmts)

        if not found_close:
            self.errors.warning(
                f"Unclosed event block starting at line {block_line}",
                self.filename, block_line,
            )

        # Determine event name from first identifier if still unnamed
        if is_init and event_name == "" and rest:
            for t in rest:
                if t.type == TokenType.IDENTIFIER and t.value.lower() not in _INIT_COMMANDS:
                    event_name = t.value
                    is_init = False
                    break

        return EventBlock(
            name=event_name,
            scope=scope,
            body=body_statements,
            line=block_line,
            is_init=is_init,
        )

    def _extract_event_header(self, tokens: list[Token]) -> tuple[str, str, list[Token]]:
        """Extract event name and scope from tokens after {."""
        name = ""
        scope = ""
        rest = list(tokens)

        if rest and rest[0].type == TokenType.SCOPE_TAG:
            scope = rest[0].value
            rest = rest[1:]

        if rest and rest[0].type == TokenType.IDENTIFIER:
            candidate = rest[0].value
            if candidate.lower() not in _INIT_COMMANDS:
                name = candidate
                rest = rest[1:]

        if rest and rest[0].type == TokenType.SCOPE_TAG:
            scope = rest[0].value
            rest = rest[1:]

        return name, scope, rest

    def _parse_statements_at_current(self) -> list[Statement]:
        """Parse one or more statements starting at self.pos.

        Advances self.pos past all consumed lines.
        Returns list of statements parsed.
        """
        line = self.current_line()
        tokens = self._non_newline_tokens(line)

        if not tokens:
            self.pos += 1
            return []

        first = tokens[0]

        # If statement — may consume multiple lines
        if first.type == TokenType.IF_KW:
            result = self._parse_if_statement()
            return [result] if result else []

        # Else — stray else (should have been consumed by if parsing)
        if first.type == TokenType.ELSE_KW:
            self.pos += 1
            return []

        # Open brace on its own — could be a stray brace block (skip it)
        if first.type == TokenType.OPEN_BRACE:
            # Parse as a nested brace block and return the contents
            stmts = self._consume_brace_block()
            return stmts

        # Regular command
        stmt = self._parse_command(tokens, line)
        self.pos += 1
        return [stmt] if stmt else []

    def _parse_if_statement(self) -> IfBlock | None:
        """Parse an if statement starting at self.pos.

        Handles:
          - Guard style: if COND (bare, no braces)
          - Inline: if ( COND ) command
          - Block: if ( COND ) { ... } else { ... }
          - if(...) { ... } else { ... }

        Advances self.pos past all consumed lines.
        """
        line = self.current_line()
        tokens = self._non_newline_tokens(line)
        # tokens[0] is IF_KW
        rest = tokens[1:]

        # Determine if parenthesized
        is_paren = rest and rest[0].type == TokenType.OPEN_PAREN

        if is_paren:
            cond_tokens, after_cond = self._extract_paren_group(rest)
            condition = self._parse_condition(cond_tokens)
            inline_tokens = self._tokens_after_condition(after_cond)

            if inline_tokens:
                # Inline: if ( cond ) command — on same line
                body_stmt = self._parse_command(inline_tokens, line)
                body = [body_stmt] if body_stmt else []
                self.pos += 1  # consume the if line

                # Check for else
                else_body = self._try_parse_else()

                return IfBlock(
                    condition=condition,
                    body=body,
                    else_body=else_body,
                    guard_style=False,
                    line=line.line_number,
                )

            self.pos += 1  # consume the if line

            # Check if next line starts with {
            if self.pos < len(self.lexed.lines):
                next_tokens = self._non_newline_tokens(self.lexed.lines[self.pos])
                if next_tokens and next_tokens[0].type == TokenType.OPEN_BRACE:
                    body = self._consume_brace_block()
                    else_body = self._try_parse_else()
                    return IfBlock(
                        condition=condition,
                        body=body,
                        else_body=else_body,
                        guard_style=False,
                        line=line.line_number,
                    )

            # No braces and no inline — guard style
            return IfBlock(
                condition=condition,
                body=[],
                guard_style=True,
                line=line.line_number,
            )
        else:
            # Bare if: if VAR equals VALUE or if !VAR
            condition = self._parse_condition(rest)
            self.pos += 1  # consume the if line

            # Guard-style
            return IfBlock(
                condition=condition,
                body=[],
                guard_style=True,
                line=line.line_number,
            )

    def _try_parse_else(self) -> list[Statement]:
        """Try to parse an else clause. Advances self.pos if else found."""
        if self.pos >= len(self.lexed.lines):
            return []

        line = self.current_line()
        tokens = self._non_newline_tokens(line)

        if not tokens or tokens[0].type != TokenType.ELSE_KW:
            return []

        rest = tokens[1:]

        # else if (...)
        if rest and rest[0].type == TokenType.IF_KW:
            # Don't consume this line — _parse_if_statement will consume it
            # But we need to adjust: the "else" is on this line, "if" is too
            # Synthesize: consume this line, re-parse as if
            self.pos += 1  # consume "else"
            # But wait, the if is on the same line as else
            # We need to create a synthetic if from the rest tokens
            # Actually, let's back up: the entire "else if (...)" is on one line
            # We need to parse the if part
            inner_cond_tokens = rest[1:]  # skip the IF_KW
            is_paren = inner_cond_tokens and inner_cond_tokens[0].type == TokenType.OPEN_PAREN
            if is_paren:
                cond_tokens, after_cond = self._extract_paren_group(inner_cond_tokens)
                condition = self._parse_condition(cond_tokens)
                inline = self._tokens_after_condition(after_cond)

                if inline:
                    body_stmt = self._parse_command(inline, line)
                    body = [body_stmt] if body_stmt else []
                    else_body = self._try_parse_else()
                    return [IfBlock(condition=condition, body=body, else_body=else_body, line=line.line_number)]

                # Check for { on next line
                if self.pos < len(self.lexed.lines):
                    next_tokens = self._non_newline_tokens(self.lexed.lines[self.pos])
                    if next_tokens and next_tokens[0].type == TokenType.OPEN_BRACE:
                        body = self._consume_brace_block()
                        else_body = self._try_parse_else()
                        return [IfBlock(condition=condition, body=body, else_body=else_body, line=line.line_number)]

                return [IfBlock(condition=condition, body=[], guard_style=True, line=line.line_number)]
            else:
                condition = self._parse_condition(inner_cond_tokens)
                return [IfBlock(condition=condition, body=[], guard_style=True, line=line.line_number)]

        # else { ... }
        if not rest:
            self.pos += 1  # consume "else" line
            if self.pos < len(self.lexed.lines):
                next_tokens = self._non_newline_tokens(self.lexed.lines[self.pos])
                if next_tokens and next_tokens[0].type == TokenType.OPEN_BRACE:
                    return self._consume_brace_block()
            return []

        # else command (inline)
        self.pos += 1
        cmd = self._parse_command(rest, line)
        return [cmd] if cmd else []

    def _consume_brace_block(self) -> list[Statement]:
        """Consume a { ... } block, returning the statements inside.

        Expects self.pos to point at the line containing {.
        Advances self.pos past the closing }.
        """
        if self.pos >= len(self.lexed.lines):
            return []

        line = self.current_line()
        tokens = self._non_newline_tokens(line)
        if not tokens or tokens[0].type != TokenType.OPEN_BRACE:
            return []

        self.pos += 1  # skip {
        stmts: list[Statement] = []

        while self.pos < len(self.lexed.lines):
            line = self.current_line()
            tokens = self._non_newline_tokens(line)

            if not tokens:
                self.pos += 1
                continue

            # Closing brace
            if tokens[0].type == TokenType.CLOSE_BRACE:
                self.pos += 1
                break

            # Parse statements (may be multi-line if/else)
            new_stmts = self._parse_statements_at_current()
            stmts.extend(new_stmts)

        return stmts

    def _parse_condition(self, tokens: list[Token]) -> Condition:
        """Parse condition from tokens."""
        if not tokens:
            return Condition(left=Literal("true"), operator="equals", right=Literal("true"))

        # Handle negation: !VAR
        negated = False
        if tokens[0].type == TokenType.BANG:
            negated = True
            tokens = tokens[1:]

        if not tokens:
            return Condition(left=Literal("true"), operator="equals", right=Literal("true"), negated=negated)

        # Single token: if VAR or if !VAR
        if len(tokens) == 1:
            left = self._token_to_expression(tokens[0])
            return Condition(left=left, operator="truthy", right=Literal(""), negated=negated)

        # Find operator token
        op_idx = -1
        for i, t in enumerate(tokens):
            if t.type == TokenType.OPERATOR:
                op_idx = i
                break
            if t.type == TokenType.IDENTIFIER and t.value.lower() in CONDITION_KEYWORDS:
                op_idx = i
                break

        if op_idx == -1:
            left = self._tokens_to_expression(tokens)
            return Condition(left=left, operator="truthy", right=Literal(""), negated=negated)

        left_tokens = tokens[:op_idx]
        op_token = tokens[op_idx]
        right_tokens = tokens[op_idx + 1:]

        left = self._tokens_to_expression(left_tokens)
        right = self._tokens_to_expression(right_tokens) if right_tokens else Literal("")
        op = op_token.value.lower() if op_token.type == TokenType.IDENTIFIER else op_token.value

        return Condition(left=left, operator=op, right=right, negated=negated, line=tokens[0].line if tokens else 0)

    def _parse_command(self, tokens: list[Token], line: LexedLine) -> Command:
        """Parse a command from tokens."""
        first = tokens[0]
        cmd_name = first.value
        args: list[Expression] = []

        i = 1
        while i < len(tokens):
            t = tokens[i]
            if t.type == TokenType.NEWLINE:
                break
            expr, new_i = self._parse_expression_at(tokens, i)
            if expr:
                args.append(expr)
            i = new_i if new_i > i else i + 1

        return Command(name=cmd_name, args=args, line=line.line_number, raw_line=line.raw)

    def _parse_expression_at(self, tokens: list[Token], i: int) -> tuple[Expression | None, int]:
        """Parse an expression starting at token index i."""
        if i >= len(tokens):
            return None, i

        t = tokens[i]

        if t.type == TokenType.NEWLINE:
            return None, i

        if t.type == TokenType.DOLLAR_FUNC:
            return self._parse_dollar_func(tokens, i)

        if t.type == TokenType.DOLLAR_REF:
            return VariableRef(f"${t.value}", line=t.line), i + 1

        if t.type == TokenType.OPEN_PAREN:
            return self._parse_paren_expr(tokens, i)

        if t.type in (TokenType.NUMBER, TokenType.HP_LITERAL, TokenType.PERCENTAGE):
            return Literal(t.value, line=t.line), i + 1

        if t.type == TokenType.STRING:
            return Literal(f'"{t.value}"', line=t.line), i + 1

        if t.type == TokenType.BACKTICK_STRING:
            return Literal(f"`{t.value}`", line=t.line), i + 1

        if t.type == TokenType.IDENTIFIER:
            return VariableRef(t.value, line=t.line), i + 1

        if t.type == TokenType.BANG:
            expr, ni = self._parse_expression_at(tokens, i + 1)
            if expr:
                return VariableRef(f"!{_expr_text(expr)}", line=t.line), ni
            return None, i + 1

        if t.type == TokenType.SCOPE_TAG:
            return Literal(f"[{t.value}]", line=t.line), i + 1

        return Literal(t.value, line=t.line), i + 1

    def _parse_dollar_func(self, tokens: list[Token], i: int) -> tuple[DollarFunc, int]:
        """Parse $func(...) starting at the DOLLAR_FUNC token."""
        func_name = tokens[i].value
        line = tokens[i].line
        i += 1
        if i >= len(tokens) or tokens[i].type != TokenType.OPEN_PAREN:
            return DollarFunc(func_name, [], line=line), i

        i += 1  # skip (
        args: list[Expression] = []
        depth = 1

        while i < len(tokens) and depth > 0:
            t = tokens[i]
            if t.type == TokenType.NEWLINE:
                break
            if t.type == TokenType.OPEN_PAREN:
                depth += 1
                i += 1
                continue
            if t.type == TokenType.CLOSE_PAREN:
                depth -= 1
                if depth == 0:
                    i += 1
                    break
                i += 1
                continue
            if t.type == TokenType.COMMA and depth == 1:
                i += 1
                continue

            expr, ni = self._parse_expression_at(tokens, i)
            if expr:
                args.append(expr)
            i = ni if ni > i else i + 1

        return DollarFunc(func_name, args, line=line), i

    def _parse_paren_expr(self, tokens: list[Token], i: int) -> tuple[Expression, int]:
        """Parse (x,y,z) vector or parenthesized expression."""
        start = i
        i += 1  # skip (
        inner_tokens: list[Token] = []
        depth = 1

        while i < len(tokens) and depth > 0:
            t = tokens[i]
            if t.type == TokenType.NEWLINE:
                break
            if t.type == TokenType.OPEN_PAREN:
                depth += 1
            elif t.type == TokenType.CLOSE_PAREN:
                depth -= 1
                if depth == 0:
                    i += 1
                    break
            inner_tokens.append(t)
            i += 1

        # Check if it's a vector: (X, Y, Z)
        comma_count = sum(1 for t in inner_tokens if t.type == TokenType.COMMA)
        if comma_count == 2:
            parts: list[list[Token]] = []
            current: list[Token] = []
            for t in inner_tokens:
                if t.type == TokenType.COMMA:
                    parts.append(current)
                    current = []
                else:
                    current.append(t)
            parts.append(current)

            if len(parts) == 3:
                x = self._tokens_to_expression(parts[0]) if parts[0] else Literal("0")
                y = self._tokens_to_expression(parts[1]) if parts[1] else Literal("0")
                z = self._tokens_to_expression(parts[2]) if parts[2] else Literal("0")
                return VectorLiteral(
                    x=_expr_text(x), y=_expr_text(y), z=_expr_text(z),
                    line=tokens[start].line,
                ), i

        if inner_tokens:
            expr = self._tokens_to_expression(inner_tokens)
            return expr, i

        return Literal("()", line=tokens[start].line), i

    def _tokens_to_expression(self, tokens: list[Token]) -> Expression:
        """Convert a sequence of tokens to a single expression."""
        clean = [t for t in tokens if t.type != TokenType.NEWLINE]
        if not clean:
            return Literal("")

        if len(clean) == 1:
            expr, _ = self._parse_expression_at(clean, 0)
            return expr or Literal(clean[0].value)

        parts: list[Expression] = []
        i = 0
        while i < len(clean):
            expr, ni = self._parse_expression_at(clean, i)
            if expr:
                parts.append(expr)
            i = ni if ni > i else i + 1

        if len(parts) == 1:
            return parts[0]
        return Concatenation(parts=parts, line=clean[0].line)

    def _extract_paren_group(self, tokens: list[Token]) -> tuple[list[Token], list[Token]]:
        """Extract tokens inside balanced parens. Returns (inner, after)."""
        if not tokens or tokens[0].type != TokenType.OPEN_PAREN:
            return tokens, []

        depth = 0
        inner: list[Token] = []
        for i, t in enumerate(tokens):
            if t.type == TokenType.OPEN_PAREN:
                depth += 1
                if depth == 1:
                    continue
            elif t.type == TokenType.CLOSE_PAREN:
                depth -= 1
                if depth == 0:
                    return inner, tokens[i + 1:]
            if depth >= 1:
                inner.append(t)

        return inner, []

    def _tokens_after_condition(self, tokens: list[Token]) -> list[Token]:
        """Get non-newline tokens after condition close paren."""
        return [t for t in tokens if t.type != TokenType.NEWLINE]

    def _token_to_expression(self, t: Token) -> Expression:
        if t.type == TokenType.NUMBER:
            return Literal(t.value, line=t.line)
        if t.type == TokenType.STRING:
            return Literal(f'"{t.value}"', line=t.line)
        if t.type == TokenType.BACKTICK_STRING:
            return Literal(f"`{t.value}`", line=t.line)
        if t.type == TokenType.PERCENTAGE:
            return Literal(t.value, line=t.line)
        return VariableRef(t.value, line=t.line)


def _expr_text(expr: Expression) -> str:
    if isinstance(expr, Literal):
        return expr.value
    if isinstance(expr, VariableRef):
        return expr.name
    if isinstance(expr, DollarFunc):
        args = ", ".join(_expr_text(a) for a in expr.args)
        return f"${expr.name}({args})"
    if isinstance(expr, VectorLiteral):
        return f"({expr.x},{expr.y},{expr.z})"
    if isinstance(expr, Concatenation):
        return " ".join(_expr_text(p) for p in expr.parts)
    return str(expr)


from .lexer import CONDITION_KEYWORDS  # noqa: E402

# Commands that appear in init blocks (not event names)
_INIT_COMMANDS = {
    "const", "setvar", "setvard", "setvarg", "local",
    "precache", "setmodel", "setidleanim", "setmoveanim",
    "name", "hp", "gold", "race", "roam", "fly",
    "width", "height", "gravity", "invincible",
    "hearingsensitivity", "setmodelbody", "blood",
    "volume", "weight", "desc", "movespeed", "stepsize",
}


def parse_script(lexed: LexedFile, preprocessed: PreprocessedFile,
                 errors: ErrorCollector) -> ScriptFile:
    """Parse a lexed MSCScript file into an AST."""
    parser = Parser(lexed, preprocessed, errors)
    return parser.parse()
