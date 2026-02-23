"""Math commands: add, subtract, multiply, divide, mod, inc, dec, capvar."""

from __future__ import annotations

from .registry import register, CommandTranslator


class BinaryMathTranslator(CommandTranslator):
    """Translates add/subtract/multiply/divide to +=, -=, *=, /=."""
    def __init__(self, operator: str):
        self.operator = operator

    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return False
        var = ctx.expr_raw(cmd.args[0])
        val = ctx.translate_expr(cmd.args[1])
        w.line(f"{var} {self.operator} {val};")
        return True


class IncDecTranslator(CommandTranslator):
    """Translates inc/dec to ++/--."""
    def __init__(self, operator: str):
        self.operator = operator

    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        var = ctx.expr_raw(cmd.args[0])
        w.line(f"{var}{self.operator};")
        return True


class CapVarTranslator(CommandTranslator):
    """capvar VAR MIN MAX → var = Math::Max(MIN, Math::Min(MAX, var))."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 3:
            return False
        var = ctx.expr_raw(cmd.args[0])
        lo = ctx.translate_expr(cmd.args[1])
        hi = ctx.translate_expr(cmd.args[2])
        w.line(f"{var} = max({lo}, min({hi}, {var}));")
        return True


class MathSetTranslator(CommandTranslator):
    """mathset VAR EXPR → var = expr."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return False
        var = ctx.expr_raw(cmd.args[0])
        val = ctx.translate_expr(cmd.args[1])
        w.line(f"{var} = {val};")
        return True


class VectorMathTranslator(CommandTranslator):
    """vectoradd/vectormultiply VAR VALUE."""
    def __init__(self, operator: str):
        self.operator = operator

    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return False
        var = ctx.expr_raw(cmd.args[0])
        val = ctx.translate_expr(cmd.args[1])
        w.line(f"{var} {self.operator} {val};")
        return True


def register_commands():
    register("add", BinaryMathTranslator("+="))
    register("subtract", BinaryMathTranslator("-="))
    register("multiply", BinaryMathTranslator("*="))
    register("divide", BinaryMathTranslator("/="))
    register("mod", BinaryMathTranslator("%="))
    register("inc", IncDecTranslator("++"))
    register("dec", IncDecTranslator("--"))
    register("incvar", BinaryMathTranslator("+="))
    register("decvar", BinaryMathTranslator("-="))
    register("capvar", CapVarTranslator())
    register("mathset", MathSetTranslator())
    register("vectoradd", VectorMathTranslator("+="))
    register("vectormultiply", VectorMathTranslator("*="))
    register("vectorscale", VectorMathTranslator("*="))
    register("vectorset", MathSetTranslator())
