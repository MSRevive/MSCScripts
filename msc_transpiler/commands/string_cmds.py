"""String commands: stradd, strconc, token operations."""

from __future__ import annotations

from .registry import register, CommandTranslator


class StrAddTranslator(CommandTranslator):
    """stradd VAR VALUE — append to string."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            var = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f"{var} += {val};")
        return True


class StrConcTranslator(CommandTranslator):
    """strconc VAR VAL1 VAL2 ... — concatenate multiple values."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            var = ctx.expr_raw(cmd.args[0])
            parts = [ctx.translate_expr(a) for a in cmd.args[1:]]
            w.line(f'{var} = {" + ".join(parts)};')
        return True


class TokenAddTranslator(CommandTranslator):
    """token.add VAR VALUE — add token to delimited string."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            var = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f'if ({var}.length() > 0) {var} += ";";')
            w.line(f"{var} += {val};")
        return True


class TokenDelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            var = ctx.expr_raw(cmd.args[0])
            idx = ctx.translate_expr(cmd.args[1])
            w.line(f'RemoveToken({var}, {idx}, ";");')
        return True


class TokenSetTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            var = ctx.expr_raw(cmd.args[0])
            idx = ctx.translate_expr(cmd.args[1])
            val = ctx.translate_expr(cmd.args[2])
            w.line(f'SetToken({var}, {idx}, {val}, ";");')
        return True


class TokenScrambleTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            var = ctx.expr_raw(cmd.args[0])
            w.line(f'ScrambleTokens({var}, ";");')
        return True


def register_commands():
    register("stradd", StrAddTranslator())
    register("strconc", StrConcTranslator())
    register("token.add", TokenAddTranslator())
    register("token.del", TokenDelTranslator())
    register("token.set", TokenSetTranslator())
    register("token.scramble", TokenScrambleTranslator())
