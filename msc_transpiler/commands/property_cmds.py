"""Property-setting commands: hp, gold, name, race, model, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class HpTranslator(CommandTranslator):
    """hp VALUE or hp VALUE/VALUE."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        val = ctx.expr_raw(cmd.args[0])
        # Handle hp literal like "50/50"
        if "/" in val and not val.startswith("$") and not val.startswith('"'):
            parts = val.split("/")
            w.line(f"SetHealth({parts[0]});")
            w.line(f"SetMaxHealth({parts[1]});")
        else:
            expr = ctx.translate_expr(cmd.args[0])
            w.line(f"SetHealth({expr});")
        return True


class NameTranslator(CommandTranslator):
    """name VALUE [VALUE...] — set entity name, may be multi-word."""
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        # Join all args as the name
        parts = [ctx.translate_expr(a) for a in cmd.args]
        if len(parts) == 1:
            w.line(f'SetName({parts[0]});')
        else:
            # Multi-word name — join with spaces
            name_parts = [ctx.expr_raw(a) for a in cmd.args]
            w.line(f'SetName("{" ".join(name_parts)}");')
        return True


class RaceTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        val = ctx.translate_expr(cmd.args[0])
        w.line(f'SetRace({val});')
        return True


class SetModelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        val = ctx.translate_expr(cmd.args[0])
        w.line(f'SetModel({val});')
        return True


class SetModelBodyTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) < 2:
            return False
        group = ctx.translate_expr(cmd.args[0])
        body = ctx.translate_expr(cmd.args[1])
        w.line(f'SetModelBody({group}, {body});')
        return True


class DescTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        parts = [ctx.expr_raw(a) for a in cmd.args]
        w.line(f'SetDescription("{" ".join(parts)}");')
        return True


class BoolPropertyTranslator(CommandTranslator):
    """Translates boolean property commands like invincible, invisible, etc."""
    def __init__(self, func_name: str):
        self.func_name = func_name

    def translate(self, cmd, ctx, w):
        if cmd.args:
            val = ctx.expr_raw(cmd.args[0])
            if val in ("1", "true"):
                w.line(f'{self.func_name}(true);')
            elif val in ("0", "false"):
                w.line(f'{self.func_name}(false);')
            else:
                w.line(f'{self.func_name}({ctx.translate_expr(cmd.args[0])});')
        else:
            w.line(f'{self.func_name}(true);')
        return True


class NumericPropertyTranslator(CommandTranslator):
    """Translates numeric property commands like width, height, gravity."""
    def __init__(self, func_name: str):
        self.func_name = func_name

    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        val = ctx.translate_expr(cmd.args[0])
        w.line(f'{self.func_name}({val});')
        return True


def register_commands():
    register("hp", HpTranslator())
    register("gold", NumericPropertyTranslator("SetGold"))
    register("name", NameTranslator())
    register("name_prefix", NameTranslator())  # TODO: proper prefix handling
    register("name_unique", NameTranslator())
    register("race", RaceTranslator())
    register("setmodel", SetModelTranslator())
    register("setmodelbody", SetModelBodyTranslator())
    register("desc", DescTranslator())
    register("width", NumericPropertyTranslator("SetWidth"))
    register("height", NumericPropertyTranslator("SetHeight"))
    register("gravity", NumericPropertyTranslator("SetGravity"))
    register("weight", NumericPropertyTranslator("SetWeight"))
    register("volume", NumericPropertyTranslator("SetVolume"))
    register("movespeed", NumericPropertyTranslator("SetMoveSpeed"))
    register("stepsize", NumericPropertyTranslator("SetStepSize"))
    register("saytextrange", NumericPropertyTranslator("SetSayTextRange"))
    register("hearingsensitivity", NumericPropertyTranslator("SetHearingSensitivity"))

    # Boolean properties
    register("roam", BoolPropertyTranslator("SetRoam"))
    register("fly", BoolPropertyTranslator("SetFly"))
    register("invincible", BoolPropertyTranslator("SetInvincible"))
    register("invisible", BoolPropertyTranslator("SetInvisible"))
    register("blind", BoolPropertyTranslator("SetBlind"))
    register("nopush", BoolPropertyTranslator("SetNoPush"))
