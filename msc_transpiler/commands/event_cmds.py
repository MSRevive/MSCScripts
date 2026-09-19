"""Event commands: callevent, callexternal, calleventloop, repeatdelay, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class CallEventTranslator(CommandTranslator):
    """callevent [DELAY] EVENT_NAME [PARAMS...]."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return True

        # Check if first arg is a delay (number or float)
        first_raw = ctx.expr_raw(cmd.args[0])
        is_delay = False
        try:
            float(first_raw)
            is_delay = True
        except ValueError:
            pass

        if is_delay and len(cmd.args) >= 2:
            delay = ctx.translate_expr(cmd.args[0])
            event_name = ctx.expr_raw(cmd.args[1])
            params = [ctx.translate_expr(a) for a in cmd.args[2:]]
            safe_name = _sanitize_event_name(event_name)
            if params:
                w.line(f'ScheduleDelayedEvent({delay}, "{safe_name}", {", ".join(params)});')
            else:
                w.line(f'ScheduleDelayedEvent({delay}, "{safe_name}");')
        else:
            event_name = ctx.expr_raw(cmd.args[0])
            params = [ctx.translate_expr(a) for a in cmd.args[1:]]
            safe_name = _sanitize_event_name(event_name)
            if params:
                w.line(f'{safe_name}({", ".join(params)});')
            else:
                w.line(f'{safe_name}();')

        return True


class CallExternalTranslator(CommandTranslator):
    """callexternal TARGET EVENT_NAME [PARAMS...]."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return True
        target = ctx.translate_expr(cmd.args[0])
        event_name = ctx.expr_raw(cmd.args[1])
        params = [ctx.translate_expr(a) for a in cmd.args[2:]]
        safe_name = _sanitize_event_name(event_name)
        if params:
            w.line(f'CallExternal({target}, "{safe_name}", {", ".join(params)});')
        else:
            w.line(f'CallExternal({target}, "{safe_name}");')
        return True


class CallEventLoopTranslator(CommandTranslator):
    """calleventloop COUNT EVENT_NAME [PARAMS...]."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return True
        count = ctx.translate_expr(cmd.args[0])
        event_name = ctx.expr_raw(cmd.args[1])
        params = [ctx.translate_expr(a) for a in cmd.args[2:]]
        safe_name = _sanitize_event_name(event_name)
        w.line(f"for (int i = 0; i < {count}; i++)")
        w.line("{")
        w.indent()
        if params:
            w.line(f'{safe_name}({", ".join(params)});')
        else:
            w.line(f'{safe_name}();')
        w.dedent()
        w.line("}")
        return True


class CallEventTimedTranslator(CommandTranslator):
    """calleventtimed DELAY EVENT_NAME [PARAMS...]."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return True
        delay = ctx.translate_expr(cmd.args[0])
        event_name = ctx.expr_raw(cmd.args[1])
        params = [ctx.translate_expr(a) for a in cmd.args[2:]]
        safe_name = _sanitize_event_name(event_name)
        if params:
            w.line(f'ScheduleDelayedEvent({delay}, "{safe_name}", {", ".join(params)});')
        else:
            w.line(f'ScheduleDelayedEvent({delay}, "{safe_name}");')
        return True


class RepeatDelayTranslator(CommandTranslator):
    """repeatdelay SECONDS — re-calls this event periodically."""
    def translate(self, cmd, ctx, w):
        if cmd.args:
            delay = ctx.translate_expr(cmd.args[0])
            w.line(f"SetRepeatDelay({delay});")
        return True


class ExitEventTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("return;")
        return True


class BreakLoopTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("break;")
        return True


class CallClItemEventTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"CallClientItemEvent({args});")
        return True


def _sanitize_event_name(name: str) -> str:
    """Make event name a valid AngelScript identifier."""
    return name.replace(".", "_").replace("-", "_")


def register_commands():
    register("callevent", CallEventTranslator())
    register("callexternal", CallExternalTranslator())
    register("calleventloop", CallEventLoopTranslator())
    register("calleventtimed", CallEventTimedTranslator())
    register("repeatdelay", RepeatDelayTranslator())
    register("exitevent", ExitEventTranslator())
    register("return", ExitEventTranslator())
    register("breakloop", BreakLoopTranslator())
    register("resetloop", CommandTranslator())
    register("callclitemevent", CallClItemEventTranslator())
