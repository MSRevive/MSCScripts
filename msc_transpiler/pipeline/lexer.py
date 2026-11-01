"""Line-oriented lexer for MSCScript.

MSCScript is fundamentally line-oriented: each line is either a structural
element ({, }, eventname, scope tag) or a command with arguments. The lexer
splits each line into tokens suitable for the parser.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from enum import Enum, auto

from .preprocessor import PreprocessedFile, PreprocessedLine


class TokenType(Enum):
    OPEN_BRACE = auto()        # {
    CLOSE_BRACE = auto()       # }
    OPEN_PAREN = auto()        # (
    CLOSE_PAREN = auto()       # )
    SCOPE_TAG = auto()         # [server], [client], [shared]
    EVENTNAME_KW = auto()      # 'eventname' keyword
    REPEATDELAY_KW = auto()    # 'repeatdelay' keyword
    IF_KW = auto()             # 'if' keyword
    ELSE_KW = auto()           # 'else' keyword
    IDENTIFIER = auto()        # command names, variable names
    NUMBER = auto()            # integer or float literal
    PERCENTAGE = auto()        # e.g. 60%
    STRING = auto()            # quoted string
    BACKTICK_STRING = auto()   # `backtick string`
    DOLLAR_FUNC = auto()       # $funcname
    DOLLAR_REF = auto()        # $variable (no parens follow)
    VECTOR = auto()            # (x,y,z) vector literal (detected in context)
    HP_LITERAL = auto()        # 50/50 style hp literal
    COMMA = auto()             # ,
    OPERATOR = auto()          # ==, !=, <, >, <=, >=
    BANG = auto()              # !
    NEWLINE = auto()           # end of logical line
    EOF = auto()


@dataclass
class Token:
    type: TokenType
    value: str
    line: int = 0
    col: int = 0

    def __repr__(self):
        return f"Token({self.type.name}, {self.value!r}, L{self.line})"


@dataclass
class LexedLine:
    """A single logical line broken into tokens."""
    tokens: list[Token]
    line_number: int
    raw: str  # Original text

    @property
    def is_empty(self) -> bool:
        return not self.tokens or all(t.type == TokenType.NEWLINE for t in self.tokens)


@dataclass
class LexedFile:
    """All lexed lines from a file."""
    filename: str
    lines: list[LexedLine] = field(default_factory=list)


# Scope tag pattern
_SCOPE_TAG_RE = re.compile(r"^\[(\w+)\]$")

# $function pattern
_DOLLAR_FUNC_RE = re.compile(r"^\$(\w[\w.]*)\(")

# HP literal pattern (e.g., 50/50, 200/200)
_HP_LITERAL_RE = re.compile(r"^\d+/\d+$")

# Percentage pattern
_PERCENTAGE_RE = re.compile(r"^\d+(?:\.\d+)?%$")

# Number pattern
_NUMBER_RE = re.compile(r"^-?\d+(?:\.\d+)?$")

# Comparison operators
_OPERATORS = {"==", "!=", "<", ">", "<=", ">="}

# MSCScript condition keywords (treated as operators in conditions)
CONDITION_KEYWORDS = {
    "equals", "isnot", "contains", "startswith", "endswith",
    "less", "greater",
}


def lex_file(preprocessed: PreprocessedFile) -> LexedFile:
    """Lex all preprocessed lines into token streams."""
    result = LexedFile(filename=preprocessed.filename)
    for pline in preprocessed.lines:
        lexed = lex_line(pline)
        if not lexed.is_empty:
            result.lines.append(lexed)
    return result


def lex_line(pline: PreprocessedLine) -> LexedLine:
    """Tokenize a single preprocessed line."""
    tokens: list[Token] = []
    text = pline.text
    i = 0
    line_num = pline.line_number

    while i < len(text):
        ch = text[i]

        # Skip whitespace
        if ch in (' ', '\t'):
            i += 1
            continue

        # Single character tokens
        if ch == '{':
            tokens.append(Token(TokenType.OPEN_BRACE, "{", line_num, i))
            i += 1
            continue
        if ch == '}':
            tokens.append(Token(TokenType.CLOSE_BRACE, "}", line_num, i))
            i += 1
            continue
        if ch == ',':
            tokens.append(Token(TokenType.COMMA, ",", line_num, i))
            i += 1
            continue

        # Scope tags: [server], [client], [shared]
        if ch == '[':
            end = text.find(']', i)
            if end != -1:
                tag = text[i:end + 1]
                m = _SCOPE_TAG_RE.match(tag)
                if m:
                    tokens.append(Token(TokenType.SCOPE_TAG, m.group(1).lower(), line_num, i))
                    i = end + 1
                    continue
            # Not a scope tag, treat [ as part of identifier
            pass

        # Operators: ==, !=, <=, >=, <, >
        if ch in '<>':
            if i + 1 < len(text) and text[i + 1] == '=':
                tokens.append(Token(TokenType.OPERATOR, text[i:i + 2], line_num, i))
                i += 2
                continue
            tokens.append(Token(TokenType.OPERATOR, ch, line_num, i))
            i += 1
            continue
        if ch == '=' and i + 1 < len(text) and text[i + 1] == '=':
            tokens.append(Token(TokenType.OPERATOR, "==", line_num, i))
            i += 2
            continue
        if ch == '!' and i + 1 < len(text) and text[i + 1] == '=':
            tokens.append(Token(TokenType.OPERATOR, "!=", line_num, i))
            i += 2
            continue
        if ch == '!':
            tokens.append(Token(TokenType.BANG, "!", line_num, i))
            i += 1
            continue

        # Quoted strings
        if ch == '"' or ch == "'":
            end = text.find(ch, i + 1)
            if end == -1:
                end = len(text)
            val = text[i + 1:end]
            tokens.append(Token(TokenType.STRING, val, line_num, i))
            i = end + 1
            continue

        # Backtick strings
        if ch == '`':
            end = text.find('`', i + 1)
            if end == -1:
                end = len(text)
            val = text[i + 1:end]
            tokens.append(Token(TokenType.BACKTICK_STRING, val, line_num, i))
            i = end + 1
            continue

        # $function or $variable
        if ch == '$':
            # Collect the $name
            j = i + 1
            while j < len(text) and (text[j].isalnum() or text[j] in ('_', '.')):
                j += 1
            name = text[i + 1:j]
            if j < len(text) and text[j] == '(':
                # $func(...) — collect the full balanced parens
                tokens.append(Token(TokenType.DOLLAR_FUNC, name, line_num, i))
                tokens.append(Token(TokenType.OPEN_PAREN, "(", line_num, j))
                i = j + 1
                continue
            else:
                # $variable reference
                tokens.append(Token(TokenType.DOLLAR_REF, name, line_num, i))
                i = j
                continue

        # Parenthesized expression — could be vector or grouping
        if ch == '(':
            tokens.append(Token(TokenType.OPEN_PAREN, "(", line_num, i))
            i += 1
            continue
        if ch == ')':
            tokens.append(Token(TokenType.CLOSE_PAREN, ")", line_num, i))
            i += 1
            continue

        # Words/identifiers/numbers — collect until whitespace or special char
        j = i
        while j < len(text) and text[j] not in (' ', '\t', '{', '}', '(', ')', ',', '"', "'", '`'):
            # Allow $ inside words only if it's at the start
            if text[j] == '$' and j > i:
                break
            j += 1
        word = text[i:j]

        if not word:
            i += 1
            continue

        # Classify the word
        if _HP_LITERAL_RE.match(word):
            tokens.append(Token(TokenType.HP_LITERAL, word, line_num, i))
        elif _PERCENTAGE_RE.match(word):
            tokens.append(Token(TokenType.PERCENTAGE, word, line_num, i))
        elif _NUMBER_RE.match(word):
            tokens.append(Token(TokenType.NUMBER, word, line_num, i))
        elif word.lower() == "eventname":
            tokens.append(Token(TokenType.EVENTNAME_KW, word, line_num, i))
        elif word.lower() == "repeatdelay":
            tokens.append(Token(TokenType.REPEATDELAY_KW, word, line_num, i))
        elif word.lower() == "if":
            tokens.append(Token(TokenType.IF_KW, word, line_num, i))
        elif word.lower() == "else":
            tokens.append(Token(TokenType.ELSE_KW, word, line_num, i))
        else:
            tokens.append(Token(TokenType.IDENTIFIER, word, line_num, i))

        i = j

    tokens.append(Token(TokenType.NEWLINE, "\n", line_num, len(text)))
    return LexedLine(tokens=tokens, line_number=line_num, raw=pline.text)
