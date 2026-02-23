"""Central command registry mapping MSCScript commands to translators."""

from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from ..ast_nodes import Command, Expression
    from ..output.code_writer import CodeWriter
    from ..pipeline.codegen import CodeGenContext


class CommandTranslator:
    """Base class for command translators.

    Default implementation emits a TODO comment. Subclasses override for real translation.
    """

    def translate(self, cmd: "Command", ctx: "CodeGenContext", w: "CodeWriter") -> bool:
        """Translate command, writing to CodeWriter. Return True if handled."""
        args = " ".join(ctx.expr_raw(a) for a in cmd.args) if cmd.args else ""
        w.comment(f"TODO: {cmd.name} {args}".strip())
        return True


class SimplePropertyTranslator(CommandTranslator):
    """Translates a simple property-setting command like 'hp 50'."""

    def __init__(self, as_func: str, arg_count: int = 1):
        self.as_func = as_func
        self.arg_count = arg_count

    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args[:self.arg_count])
        w.line(f"{self.as_func}({args});")
        return True


class SimpleMethodTranslator(CommandTranslator):
    """Translates to a method call on an entity."""

    def __init__(self, target: str, method: str, arg_count: int = -1):
        self.target = target
        self.method = method
        self.arg_count = arg_count  # -1 = all args

    def translate(self, cmd, ctx, w):
        args_list = cmd.args if self.arg_count == -1 else cmd.args[:self.arg_count]
        args = ", ".join(ctx.translate_expr(a) for a in args_list)
        if self.target:
            w.line(f"{self.target}.{self.method}({args});")
        else:
            w.line(f"{self.method}({args});")
        return True


class SetVarTranslator(CommandTranslator):
    """Handles setvard/setvar/setvarg/local/const."""
    def __init__(self, var_type: str):
        self.var_type = var_type  # "setvard", "setvar", "setvarg", "local", "const"

    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 1:
            w.comment(f"WARN: {self.var_type} with no args")
            return True

        var_name = ctx.expr_raw(cmd.args[0])

        if len(cmd.args) >= 2:
            value = ctx.translate_expr(cmd.args[1])
        else:
            value = '""'

        if self.var_type == "const":
            # Try to infer type from value
            type_str = _infer_type_from_value(value)
            w.line(f"const {type_str} {var_name} = {value};")
        elif self.var_type == "local":
            type_str = _infer_type_from_value(value)
            ctx.register_local(var_name, type_str)
            w.line(f"{type_str} {var_name} = {value};")
        elif self.var_type == "setvarg":
            w.line(f'SetGlobalVar("{var_name}", {value});')
        elif self.var_type == "setvard":
            ctx.register_member(var_name)
            w.line(f"{var_name} = {value};")
        else:  # setvar
            ctx.register_member(var_name)
            w.line(f"{var_name} = {value};")

        return True


def _infer_type_from_value(value: str) -> str:
    """Infer AngelScript type from a literal value string."""
    stripped = value.strip()

    # Check for Vector3
    if stripped.startswith("Vector3("):
        return "Vector3"

    # Check for quoted string
    if stripped.startswith('"') or stripped.startswith("'"):
        return "string"

    # Check for float (has decimal point)
    if "." in stripped:
        try:
            float(stripped)
            return "float"
        except ValueError:
            pass

    # Check for percentage (convert to float)
    if stripped.endswith("%"):
        return "float"

    # Check for int
    try:
        int(stripped)
        return "int"
    except ValueError:
        pass

    # Default to auto/string
    return "string"


# ── Registry ─────────────────────────────────────────────────

_REGISTRY: dict[str, CommandTranslator] = {}


def register(name: str, translator: CommandTranslator):
    """Register a command translator."""
    _REGISTRY[name.lower()] = translator


def get_translator(name: str) -> CommandTranslator | None:
    """Look up translator for a command name."""
    return _REGISTRY.get(name.lower())


def register_all():
    """Register all built-in command translators."""
    from . import property_cmds, combat_cmds, movement_cmds, sound_cmds
    from . import creation_cmds, communication_cmds, variable_cmds, math_cmds
    from . import event_cmds, animation_cmds, misc_cmds
    from . import string_cmds, array_cmds, hashmap_cmds, player_cmds

    property_cmds.register_commands()
    combat_cmds.register_commands()
    movement_cmds.register_commands()
    sound_cmds.register_commands()
    creation_cmds.register_commands()
    communication_cmds.register_commands()
    variable_cmds.register_commands()
    math_cmds.register_commands()
    event_cmds.register_commands()
    animation_cmds.register_commands()
    misc_cmds.register_commands()
    string_cmds.register_commands()
    array_cmds.register_commands()
    hashmap_cmds.register_commands()
    player_cmds.register_commands()
