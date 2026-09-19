"""Movement commands: setorigin, setvelocity, addvelocity, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class SetOriginTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            origin = ctx.translate_expr(cmd.args[1])
            w.line(f"SetEntityOrigin({target}, {origin});")
        elif cmd.args:
            w.line(f"SetOrigin({ctx.translate_expr(cmd.args[0])});")
        return True


class AddOriginTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            offset = ctx.translate_expr(cmd.args[1])
            w.line(f"TeleportEntity({target}, GetEntityOrigin({target}) + {offset});")
        elif cmd.args:
            w.line(f"SetOrigin(GetOrigin() + {ctx.translate_expr(cmd.args[0])});")
        return True


class SetVelocityTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            vel = ctx.translate_expr(cmd.args[1])
            w.line(f"SetVelocity({target}, {vel});")
        elif cmd.args:
            w.line(f"SetVelocity(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class AddVelocityTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            vel = ctx.translate_expr(cmd.args[1])
            w.line(f"AddVelocity({target}, {vel});")
        elif cmd.args:
            w.line(f"AddVelocity(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class DropToFloorTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("DropToFloor();")
        return True


class NpcMoveTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"NpcMove({args});")
        return True


class SetFollowTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetFollow({ctx.translate_expr(cmd.args[0])});")
        return True


class SetAngleTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAngles({ctx.translate_expr(cmd.args[0])});")
        return True


def register_commands():
    register("setorigin", SetOriginTranslator())
    register("addorigin", AddOriginTranslator())
    register("setvelocity", SetVelocityTranslator())
    register("addvelocity", AddVelocityTranslator())
    register("drop_to_floor", DropToFloorTranslator())
    register("npcmove", NpcMoveTranslator())
    register("setfollow", SetFollowTranslator())
    register("setangle", SetAngleTranslator())
    register("setgaitspeed", CommandTranslator())
    register("tospawn", CommandTranslator())
    register("torandomspawn", CommandTranslator())
    register("teleportdest", CommandTranslator())
    register("movetype", CommandTranslator())
