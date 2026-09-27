"""Combat commands: dodamage, xdodamage, takedmg, applyeffect, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class DoDamageTranslator(CommandTranslator):
    """dodamage TARGET RANGE DAMAGE HITCHANCE [TYPE]."""
    def translate(self, cmd, ctx, w):
        args = [ctx.translate_expr(a) for a in cmd.args]
        if len(args) >= 4:
            target = args[0]
            range_val = args[1]
            damage = args[2]
            hitchance = args[3]
            dmg_type = args[4] if len(args) > 4 else '"slash"'
            w.line(f"DoDamage({target}, {range_val}, {damage}, {hitchance}, {dmg_type});")
        else:
            w.comment(f"WARN: dodamage with insufficient args: {cmd.raw_line}")
        return True


class XDoDamageTranslator(CommandTranslator):
    """xdodamage — extended damage with more params."""
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"XDoDamage({args});")
        return True


class TakeDmgTranslator(CommandTranslator):
    """takedmg TYPE MULTIPLIER."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            dmg_type = ctx.translate_expr(cmd.args[0])
            multi = ctx.translate_expr(cmd.args[1])
            w.line(f'SetDamageResistance({dmg_type}, {multi});')
        return True


class ApplyEffectTranslator(CommandTranslator):
    """applyeffect TARGET EFFECT DURATION."""
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ApplyEffect({args});")
        return True


class RemoveEffectTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"RemoveEffect({args});")
        return True


class HitMultiTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetHitMultiplier({ctx.translate_expr(cmd.args[0])});")
        return True


class DmgMultiTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetDamageMultiplier({ctx.translate_expr(cmd.args[0])});")
        return True


class GiveHpTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            amount = ctx.translate_expr(cmd.args[1])
            w.line(f"HealEntity({target}, {amount});")
        elif cmd.args:
            w.line(f"HealEntity(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class GiveMpTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"GiveMP({ctx.translate_expr(cmd.args[0])});")
        return True


class DrainHpTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            amount = ctx.translate_expr(cmd.args[1])
            w.line(f"DamageEntity({target}, {amount});")
        elif cmd.args:
            w.line(f"DamageEntity(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class DrainStaminaTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"DrainStamina({ctx.translate_expr(cmd.args[0])});")
        return True


class KillTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"KillEntity({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("KillEntity(GetOwner());")
        return True


class BleedTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"Bleed({args});")
        return True


class AttackPropTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            prop = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f'SetAttackProp("{prop}", {val});')
        return True


class SetStatTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            stat = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f'SetStat("{stat}", {val});')
        return True


def register_commands():
    register("dodamage", DoDamageTranslator())
    register("xdodamage", XDoDamageTranslator())
    register("takedmg", TakeDmgTranslator())
    register("applyeffect", ApplyEffectTranslator())
    register("removeeffect", RemoveEffectTranslator())
    register("hitmulti", HitMultiTranslator())
    register("dmgmulti", DmgMultiTranslator())
    register("givehp", GiveHpTranslator())
    register("givemp", GiveMpTranslator())
    register("drainhp", DrainHpTranslator())
    register("drainstamina", DrainStaminaTranslator())
    register("kill", KillTranslator())
    register("bleed", BleedTranslator())
    register("attackprop", AttackPropTranslator())
    register("setstat", SetStatTranslator())
    register("setexpstat", SetStatTranslator())
    register("markdmg", CommandTranslator())  # TODO
    register("clearplayerhits", CommandTranslator())  # TODO
    register("setatkspeed", CommandTranslator())  # TODO
