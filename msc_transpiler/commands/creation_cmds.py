"""Entity creation/deletion commands: createnpc, createitem, deleteent, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class CreateNpcTranslator(CommandTranslator):
    """createnpc SCRIPT ORIGIN [PARAMS]."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return True
        script = ctx.translate_expr(cmd.args[0])
        origin = ctx.translate_expr(cmd.args[1]) if len(cmd.args) > 1 else "GetOrigin()"
        params = ", ".join(ctx.translate_expr(a) for a in cmd.args[2:]) if len(cmd.args) > 2 else ""
        if params:
            w.line(f"SpawnNPC({script}, {origin}, ScriptMode::Legacy); // params: {params}")
        else:
            w.line(f"SpawnNPC({script}, {origin}, ScriptMode::Legacy);")
        return True


class CreateItemTranslator(CommandTranslator):
    """createitem SCRIPT ORIGIN."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return True
        script = ctx.translate_expr(cmd.args[0])
        origin = ctx.translate_expr(cmd.args[1]) if len(cmd.args) > 1 else "GetOrigin()"
        w.line(f"SpawnItem({script}, {origin});")
        return True


class DeleteEntTranslator(CommandTranslator):
    """deleteent TARGET [fade]."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return True
        target = ctx.translate_expr(cmd.args[0])
        fade = len(cmd.args) > 1 and ctx.expr_raw(cmd.args[1]).lower() == "fade"
        if fade:
            w.line(f"DeleteEntity({target}, true); // fade out")
        else:
            w.line(f"DeleteEntity({target});")
        return True


class DeleteMeTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        fade = cmd.args and ctx.expr_raw(cmd.args[0]).lower() == "fade"
        if fade:
            w.line("DeleteEntity(GetOwner(), true); // fade out")
        else:
            w.line("DeleteEntity(GetOwner());")
        return True


class RespawnTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("Respawn();")
        return True


class SetAliveTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAlive({ctx.translate_expr(cmd.args[0])});")
        return True


def register_commands():
    register("createnpc", CreateNpcTranslator())
    register("createitem", CreateItemTranslator())
    register("deleteent", DeleteEntTranslator())
    register("deleteme", DeleteMeTranslator())
    register("respawn", RespawnTranslator())
    register("setalive", SetAliveTranslator())
