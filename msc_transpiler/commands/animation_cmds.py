"""Animation commands: playanim, setidleanim, setmoveanim, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class PlayAnimTranslator(CommandTranslator):
    """playanim TYPE ANIM_NAME."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            anim_type = ctx.expr_raw(cmd.args[0])
            anim_name = ctx.translate_expr(cmd.args[1])
            w.line(f'PlayAnim("{anim_type}", {anim_name});')
        elif cmd.args:
            anim_name = ctx.translate_expr(cmd.args[0])
            w.line(f'PlayAnim("once", {anim_name});')
        return True


class SetIdleAnimTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetIdleAnim({ctx.translate_expr(cmd.args[0])});")
        return True


class SetMoveAnimTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetMoveAnim({ctx.translate_expr(cmd.args[0])});")
        return True


class SetAnimFrameRateTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAnimFrameRate({ctx.translate_expr(cmd.args[0])});")
        return True


def register_commands():
    register("playanim", PlayAnimTranslator())
    register("setidleanim", SetIdleAnimTranslator())
    register("setmoveanim", SetMoveAnimTranslator())
    register("setanim.framerate", SetAnimFrameRateTranslator())
    register("splayviewanim", CommandTranslator())
