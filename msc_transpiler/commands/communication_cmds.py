"""Communication commands: saytext, infomsg, messageall, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class PlayerMessageTranslator(CommandTranslator):
    """playermessage/rplayermessage/etc TARGET MESSAGE."""
    def __init__(self, func: str = "SendPlayerMessage"):
        self.func = func

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            msg_parts = [ctx.expr_raw(a) for a in cmd.args[1:]]
            msg = " ".join(msg_parts)
            w.line(f'{self.func}({target}, "{msg}");')
        elif cmd.args:
            msg_parts = [ctx.expr_raw(a) for a in cmd.args]
            msg = " ".join(msg_parts)
            w.line(f'{self.func}(GetOwner(), "{msg}");')
        return True


class InfoMsgTranslator(CommandTranslator):
    """infomsg TARGET MESSAGE."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            msg_parts = [ctx.expr_raw(a) for a in cmd.args[1:]]
            msg = " ".join(msg_parts)
            w.line(f'SendInfoMsg({target}, "{msg}");')
        elif cmd.args:
            msg_parts = [ctx.expr_raw(a) for a in cmd.args]
            msg = " ".join(msg_parts)
            w.line(f'SendInfoMsg(GetOwner(), "{msg}");')
        return True


class MessageAllTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg_parts = [ctx.expr_raw(a) for a in cmd.args]
        msg = " ".join(msg_parts)
        w.line(f'SendInfoMessageToAll("{msg}");')
        return True


class SayTextTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            msg_parts = [ctx.expr_raw(a) for a in cmd.args]
            msg = " ".join(msg_parts)
            w.line(f'SayText("{msg}");')
        return True


class ConsoleMsgTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg_parts = [ctx.expr_raw(a) for a in cmd.args]
        msg = " ".join(msg_parts)
        w.line(f'LogMessage("{msg}");')
        return True


class ErrorMessageTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg_parts = [ctx.expr_raw(a) for a in cmd.args]
        msg = " ".join(msg_parts)
        w.line(f'LogError("{msg}");')
        return True


class PopupTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ShowPopup({args});")
        return True


class HelpTipTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ShowHelpTip({args});")
        return True


def register_commands():
    register("playermessage", PlayerMessageTranslator())
    register("rplayermessage", PlayerMessageTranslator("SendColoredMessage"))
    register("gplayermessage", PlayerMessageTranslator("SendColoredMessage"))
    register("bplayermessage", PlayerMessageTranslator("SendColoredMessage"))
    register("yplayermessage", PlayerMessageTranslator("SendColoredMessage"))
    register("dplayermessage", PlayerMessageTranslator("SendColoredMessage"))
    register("infomsg", InfoMsgTranslator())
    register("messageall", MessageAllTranslator())
    register("saytext", SayTextTranslator())
    register("consolemsg", ConsoleMsgTranslator())
    register("errormessage", ErrorMessageTranslator())
    register("popup", PopupTranslator())
    register("helptip", HelpTipTranslator())
