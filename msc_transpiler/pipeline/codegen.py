"""Code generator: emits AngelScript from the AST."""

from __future__ import annotations

from ..ast_nodes import (
    Command, Comment, Concatenation, Condition, DollarFunc, EventBlock,
    Expression, IfBlock, Literal, RawLine, ScriptFile, Statement,
    VariableRef, VectorLiteral,
)
from ..commands.registry import get_translator, register_all as register_commands
from ..errors import ErrorCollector
from ..expressions.conditions import translate_condition_op
from ..expressions.dollar_funcs import translate_dollar_func
from ..expressions.game_properties import translate_game_property
from ..output.code_writer import CodeWriter


# ── Event name → AngelScript callback mapping ────────────────

EVENT_CALLBACK_MAP = {
    "spawn": ("void OnSpawn()", True),  # eventname spawn
    "game_spawn": ("void OnSpawn()", True),
    "npc_spawn": ("void OnSpawn()", True),
    "game_death": ("void OnDeath(CBaseEntity@ attacker)", True),
    "npc_death": ("void OnDeath(CBaseEntity@ attacker)", True),
    "game_damaged": ("void OnDamage(int damage)", True),
    "game_takedamage": ("void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType)", True),
    "game_touch": ("void OnTouch(CBaseEntity@ other)", True),
    "game_playerused": ("void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType)", True),
    "game_struck": ("void OnHitByAttack(CBaseEntity@ attacker, int damage)", True),
    "game_deploy": ("void OnDeploy()", True),
    "game_pickup": ("void OnPickup(CBaseEntity@ player)", True),
    "game_drop": ("void OnDrop()", True),
    "game_playerspeak": ("void OnScriptSay(const string &in text)", True),
    "game_heardsound": ("void OnHeardSound(CBaseEntity@ source, Vector3 origin)", True),
    "game_damaged_other": ("void OnDamagedOther(CBaseEntity@ victim, int damage)", True),
    "game_parry": ("void OnParry(CBaseEntity@ attacker)", True),
    "npc_post_spawn": ("void OnPostSpawn()", True),
    "npcatk_target": ("void OnAttackTarget(CBaseEntity@ target)", False),
    "npcatk_hunt": ("void OnHuntTarget(CBaseEntity@ target)", False),
    "npcatk_flee": ("void OnFlee()", False),
    "npcatk_dodamage": ("void OnAttackDoDamage(CBaseEntity@ target)", False),
    "npc_struck": ("void OnStruck(CBaseEntity@ attacker, int damage)", False),
    "npc_flinch": ("void OnFlinch()", False),
    "npcatk_targetvalidate": ("void OnTargetValidate(CBaseEntity@ target)", False),
    "npc_aiding_ally": ("void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)", False),
    "npcatk_suspend_ai": ("void OnSuspendAI()", False),
}

# Entity reference mapping
ENTITY_REF_MAP = {
    "ent_me": "GetOwner()",
    "ent_owner": "GetOwner()",
    "ent_target": "m_hTarget",
    "ent_lastcreated": "m_hLastCreated",
    "ent_lastused": "m_hLastUsed",
    "ent_laststruck": "m_hLastStruck",
    "ent_laststruckbyme": "m_hLastStruckByMe",
    "ent_lastseen": "m_hLastSeen",
    "npcatk_target": "m_hAttackTarget",
}

# Parameter mapping
PARAM_MAP = {f"PARAM{i}": f"param{i}" for i in range(1, 21)}
PARAM_MAP["GET_COUNT"] = "getCount"
for i in range(1, 10):
    PARAM_MAP[f"GET_ENT{i}"] = f"getEnt{i}"


class CodeGenContext:
    """Context for code generation, tracking variables and state."""

    def __init__(self, errors: ErrorCollector, filename: str = ""):
        self.errors = errors
        self.filename = filename
        self.member_vars: dict[str, str] = {}  # name → type
        self.local_vars: set[str] = set()
        self.current_event: str = ""

    def register_member(self, name: str, type_str: str = "string"):
        if name not in self.member_vars:
            self.member_vars[name] = type_str

    def register_local(self, name: str, type_str: str = "string"):
        self.local_vars.add(name)

    def translate_expr(self, expr: Expression) -> str:
        """Translate an AST expression to AngelScript code."""
        if isinstance(expr, Literal):
            return self._translate_literal(expr)
        if isinstance(expr, VariableRef):
            return self._translate_var_ref(expr)
        if isinstance(expr, DollarFunc):
            return self._translate_dollar_func(expr)
        if isinstance(expr, VectorLiteral):
            return f"Vector3({expr.x}, {expr.y}, {expr.z})"
        if isinstance(expr, Concatenation):
            parts = [self.translate_expr(p) for p in expr.parts]
            # If all parts are string-like, join with +
            return " + ".join(parts) if len(parts) > 1 else parts[0]
        return str(expr)

    def expr_raw(self, expr: Expression) -> str:
        """Get raw text of an expression (for variable names, etc.)."""
        if isinstance(expr, Literal):
            val = expr.value
            # Strip quotes for raw usage
            if val.startswith('"') and val.endswith('"'):
                return val[1:-1]
            if val.startswith('`') and val.endswith('`'):
                return val[1:-1]
            return val
        if isinstance(expr, VariableRef):
            return expr.name
        if isinstance(expr, DollarFunc):
            return self._translate_dollar_func(expr)
        if isinstance(expr, VectorLiteral):
            return f"({expr.x},{expr.y},{expr.z})"
        if isinstance(expr, Concatenation):
            return " ".join(self.expr_raw(p) for p in expr.parts)
        return str(expr)

    def _translate_literal(self, lit: Literal) -> str:
        val = lit.value

        # HP literal: "50/50" → just use first number
        if "/" in val and not val.startswith('"'):
            parts = val.split("/")
            try:
                int(parts[0])
                int(parts[1])
                return parts[0]  # Return hp value
            except ValueError:
                pass

        # Percentage: "60%" → 0.6
        if val.endswith("%"):
            try:
                num = float(val[:-1]) / 100.0
                return str(num)
            except ValueError:
                pass

        # Quoted string — keep as-is
        if val.startswith('"') and val.endswith('"'):
            return val

        # Backtick string → regular string
        if val.startswith('`') and val.endswith('`'):
            return f'"{val[1:-1]}"'

        # Number
        try:
            int(val)
            return val
        except ValueError:
            pass
        try:
            float(val)
            return val
        except ValueError:
            pass

        # Unquoted string that looks like a path
        if "/" in val or val.endswith(".mdl") or val.endswith(".wav") or val.endswith(".spr"):
            return f'"{val}"'

        # Could be a variable name or a string literal — keep as-is
        # (will be resolved by var ref translation if it's a VariableRef)
        return f'"{val}"'

    def _translate_var_ref(self, ref: VariableRef) -> str:
        name = ref.name

        # Negation
        if name.startswith("!"):
            inner = name[1:]
            return f"!{self._resolve_var_name(inner)}"

        # $ prefix reference
        if name.startswith("$"):
            # Game properties
            gp = translate_game_property(name[1:])
            if gp:
                return gp
            return name[1:]  # Strip $ for simple references

        return self._resolve_var_name(name)

    def _resolve_var_name(self, name: str) -> str:
        """Resolve a variable name to its AngelScript equivalent."""
        # Game properties
        gp = translate_game_property(name)
        if gp:
            return gp

        # Entity references
        lower = name.lower()
        if lower in ENTITY_REF_MAP:
            return ENTITY_REF_MAP[lower]

        # Parameters
        if name in PARAM_MAP:
            return PARAM_MAP[name]

        # Known member/local variables
        if name in self.member_vars or name in self.local_vars:
            return name

        # ALL_CAPS identifiers are likely variable names (MSCScript convention)
        if name.isupper() or (name.upper() == name and "_" in name):
            return name

        # Mixed case or lowercase identifiers that aren't known — likely string literals
        # Quote them
        return f'"{name}"'

    def _translate_dollar_func(self, func: DollarFunc) -> str:
        args = [self.translate_expr(a) for a in func.args]
        return translate_dollar_func(func.name, args)


def generate(script: ScriptFile, errors: ErrorCollector) -> str:
    """Generate AngelScript source from a parsed script AST."""
    # Ensure commands are registered
    _ensure_registered()

    ctx = CodeGenContext(errors, script.filename)
    w = CodeWriter()

    # File header
    scope = "server"
    if script.scope_directive:
        scope = script.scope_directive.scope
    w.raw_line(f"#pragma context {scope}")
    w.blank()

    # Includes
    for inc in script.includes:
        inc_path = inc.path
        if not inc_path.endswith(".as"):
            inc_path += ".as"
        w.raw_line(f'#include "{inc_path}"')
    if script.includes:
        w.blank()

    # Namespace
    w.raw_line("namespace MS")
    w.raw_line("{")
    w.blank()

    # Script class name from filename
    class_name = _class_name_from_file(script.filename)

    # First pass: collect member variables from init blocks
    for event in script.init_blocks:
        _collect_members(event, ctx)

    # Also collect from named events (setvard commands)
    for event in script.named_events:
        _collect_members(event, ctx)

    # Class declaration
    w.raw_line(f"class {class_name} : CGameScript")
    w.raw_line("{")
    w.indent()

    # Member variable declarations
    if ctx.member_vars:
        for var_name, var_type in sorted(ctx.member_vars.items()):
            w.line(f"{var_type} {var_name};")
        w.blank()

    # Separate true init blocks from unnamed timer blocks
    true_init_blocks = []
    timer_blocks = []
    for event in script.init_blocks:
        if _is_timer_block(event):
            timer_blocks.append(event)
        else:
            true_init_blocks.append(event)

    # Constructor — emit init block contents
    if true_init_blocks:
        w.line(f"{class_name}()")
        w.line("{")
        w.indent()
        for event in true_init_blocks:
            for stmt in event.body:
                _emit_statement(stmt, ctx, w)
        w.dedent()
        w.line("}")
        w.blank()

    # Timer blocks — emit as OnRepeatTimer methods
    for i, timer in enumerate(timer_blocks):
        suffix = f"_{i}" if i > 0 else ""
        w.line(f"void OnRepeatTimer{suffix}()")
        w.line("{")
        w.indent()
        for stmt in timer.body:
            _emit_statement(stmt, ctx, w)
        w.dedent()
        w.line("}")
        w.blank()

    # Event methods
    for event in script.named_events:
        _emit_event(event, ctx, w)
        w.blank()

    # Close class and namespace
    w.dedent()
    w.raw_line("}")  # class
    w.blank()
    w.raw_line("}")  # namespace

    return w.build()


def _emit_event(event: EventBlock, ctx: CodeGenContext, w: CodeWriter):
    """Emit an event block as an AngelScript method."""
    ctx.current_event = event.name
    ctx.local_vars.clear()

    # Determine signature
    callback = EVENT_CALLBACK_MAP.get(event.name.lower())
    if callback:
        signature, is_override = callback
        override = " override" if is_override else ""
        w.line(f"{signature}{override}")
    else:
        # Custom event — private method
        w.line(f"void {_sanitize_name(event.name)}()")

    w.line("{")
    w.indent()

    # Emit body with guard-style if handling
    _emit_body_with_guards(event.body, ctx, w)

    w.dedent()
    w.line("}")


def _emit_body_with_guards(stmts: list[Statement], ctx: CodeGenContext, w: CodeWriter):
    """Emit a list of statements, handling guard-style if blocks.

    A guard-style if affects all subsequent statements until the end
    of the block or the next guard-style if.
    """
    i = 0
    while i < len(stmts):
        stmt = stmts[i]

        if isinstance(stmt, IfBlock) and stmt.guard_style:
            # Guard: if condition, the rest executes only if condition is met
            # In AngelScript: if (!condition) return;
            cond_str = _translate_condition(stmt.condition, ctx, negate=True)
            w.line(f"if ({cond_str}) return;")

            # If the guard has a body (inline command after the guard),
            # those execute as normal after the guard
            if stmt.body:
                for s in stmt.body:
                    _emit_statement(s, ctx, w)
        else:
            _emit_statement(stmt, ctx, w)

        i += 1


def _emit_statement(stmt: Statement, ctx: CodeGenContext, w: CodeWriter):
    """Emit a single statement."""
    if isinstance(stmt, Command):
        _emit_command(stmt, ctx, w)
    elif isinstance(stmt, IfBlock):
        _emit_if(stmt, ctx, w)
    elif isinstance(stmt, Comment):
        w.comment(stmt.text)
    elif isinstance(stmt, RawLine):
        w.comment(f"UNCONVERTED: {stmt.text}")
    else:
        w.comment(f"Unknown statement: {stmt}")


def _emit_command(cmd: Command, ctx: CodeGenContext, w: CodeWriter):
    """Emit a command statement."""
    translator = get_translator(cmd.name)
    if translator:
        try:
            result = translator.translate(cmd, ctx, w)
            if not result:
                # Translator returned False — couldn't handle it
                w.comment(f"TODO: UNCONVERTED: {cmd.raw_line.strip()}")
                ctx.errors.warning(
                    f"Command '{cmd.name}' translator returned False",
                    ctx.filename, cmd.line,
                )
        except Exception as e:
            w.comment(f"TODO: UNCONVERTED (error): {cmd.raw_line.strip()}")
            ctx.errors.error(
                f"Error translating '{cmd.name}': {e}",
                ctx.filename, cmd.line,
            )
    else:
        # No translator found
        w.comment(f"TODO: UNCONVERTED: {cmd.raw_line.strip()}")
        ctx.errors.warning(
            f"No translator for command '{cmd.name}'",
            ctx.filename, cmd.line,
        )


def _emit_if(ifb: IfBlock, ctx: CodeGenContext, w: CodeWriter):
    """Emit an if/else block."""
    cond_str = _translate_condition(ifb.condition, ctx)
    w.line(f"if ({cond_str})")
    w.line("{")
    w.indent()
    for stmt in ifb.body:
        _emit_statement(stmt, ctx, w)
    w.dedent()
    w.line("}")

    if ifb.else_body:
        w.line("else")
        w.line("{")
        w.indent()
        for stmt in ifb.else_body:
            _emit_statement(stmt, ctx, w)
        w.dedent()
        w.line("}")


def _translate_condition(cond: Condition, ctx: CodeGenContext, negate: bool = False) -> str:
    """Translate a condition to AngelScript."""
    left = ctx.translate_expr(cond.left)
    right = ctx.translate_expr(cond.right) if cond.right else ""
    negated = cond.negated ^ negate  # XOR with external negation
    return translate_condition_op(cond.operator, left, right, negated)


def _collect_members(event: EventBlock, ctx: CodeGenContext):
    """Pre-scan event body to collect member variable declarations."""
    for stmt in event.body:
        if isinstance(stmt, Command):
            name_lower = stmt.name.lower()
            if name_lower in ("setvard", "setvar"):
                if stmt.args:
                    var_name = ctx.expr_raw(stmt.args[0])
                    # Try to infer type from value
                    if len(stmt.args) >= 2:
                        val = ctx.expr_raw(stmt.args[1])
                        type_str = _infer_member_type(val)
                    else:
                        type_str = "string"
                    ctx.register_member(var_name, type_str)
        elif isinstance(stmt, IfBlock):
            # Recurse into if bodies
            for s in stmt.body:
                if isinstance(s, Command) and s.name.lower() in ("setvard", "setvar"):
                    if s.args:
                        var_name = ctx.expr_raw(s.args[0])
                        ctx.register_member(var_name)
            for s in stmt.else_body:
                if isinstance(s, Command) and s.name.lower() in ("setvard", "setvar"):
                    if s.args:
                        var_name = ctx.expr_raw(s.args[0])
                        ctx.register_member(var_name)


def _infer_member_type(value: str) -> str:
    """Infer type from a raw value string."""
    if value.startswith("$rand(") or value.startswith("$randf("):
        return "float" if "randf" in value else "int"

    try:
        int(value)
        return "int"
    except ValueError:
        pass
    try:
        float(value)
        return "float"
    except ValueError:
        pass

    if value.endswith("%"):
        return "float"

    return "string"


def _is_timer_block(event: EventBlock) -> bool:
    """Check if an unnamed block is a timer/repeat block (contains repeatdelay)."""
    for stmt in event.body:
        if isinstance(stmt, Command) and stmt.name.lower() == "repeatdelay":
            return True
    return False


def _class_name_from_file(filename: str) -> str:
    """Generate class name from filename."""
    import os
    base = os.path.splitext(os.path.basename(filename))[0]
    # Convert to PascalCase
    parts = base.replace("-", "_").replace(".", "_").split("_")
    return "".join(p.capitalize() for p in parts if p)


def _sanitize_name(name: str) -> str:
    """Make a name a valid AngelScript identifier."""
    return name.replace(".", "_").replace("-", "_").replace(" ", "_")


_registered = False


def _ensure_registered():
    global _registered
    if not _registered:
        register_commands()
        _registered = True
