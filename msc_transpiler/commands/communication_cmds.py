"""Communication commands: saytext, infomsg, messageall, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


def _build_message_expr(args, ctx) -> str:
    """Build a concatenated message expression that correctly handles variable
    references and $func calls as unquoted expressions rather than string literals.

    Examples:
      [VariableRef("OFFER_TEXT")]              → OFFER_TEXT
      [Lit("Lead"), Lit("on,"), VarRef("FOO")] → "Lead on, " + FOO
      [Lit("I"), Lit("have"), DFunc("int",...), Lit("hp")] → "I have " + int(HP) + " hp"
    """
    from ..ast_nodes import VariableRef, DollarFunc

    def _is_dynamic(arg) -> bool:
        if isinstance(arg, VariableRef):
            name = arg.name
            return name.isupper() or (name.upper() == name and "_" in name)
        return isinstance(arg, DollarFunc)

    result_parts: list[str] = []
    pending_strings: list[str] = []
    prev_was_dynamic = False

    for arg in args:
        if _is_dynamic(arg):
            if pending_strings:
                # Flush accumulated string tokens with trailing space separator
                text = " ".join(pending_strings) + " "
                result_parts.append(f'"{text}"')
                pending_strings = []
            result_parts.append(ctx.translate_expr(arg))
            prev_was_dynamic = True
        else:
            pending_strings.append(ctx.expr_raw(arg))
            prev_was_dynamic = False

    if pending_strings:
        text = " ".join(pending_strings)
        if result_parts:
            text = " " + text  # Leading space after a dynamic part
        result_parts.append(f'"{text}"')

    if not result_parts:
        return '""'
    return " + ".join(result_parts)


class PlayerMessageTranslator(CommandTranslator):
    """playermessage/rplayermessage/etc TARGET MESSAGE."""
    def __init__(self, func: str = "SendPlayerMessage"):
        self.func = func

    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            msg = _build_message_expr(cmd.args[1:], ctx)
            w.line(f'{self.func}({target}, {msg});')
        elif cmd.args:
            msg = _build_message_expr(cmd.args, ctx)
            w.line(f'{self.func}(GetOwner(), {msg});')
        return True


class InfoMsgTranslator(CommandTranslator):
    """infomsg TARGET MESSAGE."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            msg = _build_message_expr(cmd.args[1:], ctx)
            w.line(f'SendInfoMsg({target}, {msg});')
        elif cmd.args:
            msg = _build_message_expr(cmd.args, ctx)
            w.line(f'SendInfoMsg(GetOwner(), {msg});')
        return True


class MessageAllTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg = _build_message_expr(cmd.args, ctx)
        w.line(f'SendInfoMessageToAll({msg});')
        return True


class SayTextTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            msg = _build_message_expr(cmd.args, ctx)
            w.line(f'SayText({msg});')
        return True


class ConsoleMsgTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg = _build_message_expr(cmd.args, ctx)
        w.line(f'LogMessage({msg});')
        return True


class ErrorMessageTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        msg = _build_message_expr(cmd.args, ctx)
        w.line(f'LogError({msg});')
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
