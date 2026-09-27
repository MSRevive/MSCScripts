"""Miscellaneous commands that don't fit other categories."""

from __future__ import annotations

from .registry import register, CommandTranslator


class PrecacheTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"Precache({ctx.translate_expr(cmd.args[0])});")
        return True


class ChangeLevelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"ServerCommand(\"changelevel \" + {ctx.translate_expr(cmd.args[0])});")
        return True


class UseTriggerTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"UseTrigger({ctx.translate_expr(cmd.args[0])});")
        return True


class SetPropTranslator(CommandTranslator):
    """setprop TARGET PROPERTY VALUE."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            target = ctx.translate_expr(cmd.args[0])
            prop = ctx.expr_raw(cmd.args[1])
            val = ctx.translate_expr(cmd.args[2])
            w.line(f'SetProp({target}, "{prop}", {val});')
        return True


class SetSolidTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetSolid({ctx.translate_expr(cmd.args[0])});")
        return True


class SetBBoxTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            mins = ctx.translate_expr(cmd.args[0])
            maxs = ctx.translate_expr(cmd.args[1])
            w.line(f"SetBBox({mins}, {maxs});")
        return True


class BloodTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            val = ctx.expr_raw(cmd.args[0])
            if val.lower() == "none":
                w.line('SetBloodType("none");')
            else:
                w.line(f'SetBloodType({ctx.translate_expr(cmd.args[0])});')
        return True


class SetCallbackTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"SetCallback({args});")
        return True


class ScriptFlagsTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"SetScriptFlags({args});")
        return True


class DebugPrintTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = [ctx.expr_raw(a) for a in cmd.args]
        w.line(f'LogDebug("{" ".join(args)}");')
        return True


class QuestTranslator(CommandTranslator):
    """quest set/get NAME VALUE."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 3:
            action = ctx.expr_raw(cmd.args[0]).lower()
            name = ctx.translate_expr(cmd.args[1])
            val = ctx.translate_expr(cmd.args[2])
            if action == "set":
                w.line(f"SetPlayerQuestData({name}, {val});")
            else:
                w.line(f"// quest {action} {name} {val}")
        return True


class GiveExpTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"GiveExp({args});")
        return True


class SkillLevelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetSkillLevel({ctx.translate_expr(cmd.args[0])});")
        return True


class ClientCmdTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            command = ctx.translate_expr(cmd.args[1])
            w.line(f"ClientCommand({target}, {command});")
        elif cmd.args:
            w.line(f"ClientCommand(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class ServerCmdTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = " ".join(ctx.expr_raw(a) for a in cmd.args)
        w.line(f'ServerCommand("{args}");')
        return True


class SetCvarTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            name = ctx.translate_expr(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f"SetCvar({name}, {val});")
        return True


class ClientEventTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ClientEvent({args});")
        return True


class EffectTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"Effect({args});")
        return True


class ClEffectTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ClientEffect({args});")
        return True


class SetTransTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"SetTransition({args});")
        return True


class SetPvPTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetPvP({ctx.translate_expr(cmd.args[0])});")
        return True


class GetPlayersTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"GetAllPlayers({args});")
        return True


class RemoveScriptTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"RemoveScript({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("RemoveScript();")
        return True


class GagPlayerTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"GagPlayer({ctx.translate_expr(cmd.args[0])});")
        return True


class SetEnvTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"SetEnvironment({args});")
        return True


class SetLightsTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetLights({ctx.translate_expr(cmd.args[0])});")
        return True


class NopTranslator(CommandTranslator):
    """Commands that have no AngelScript equivalent — emit nothing."""
    def translate(self, cmd, ctx, w):
        return True  # Silently consumed


class SetLockTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            strength = ctx.translate_expr(cmd.args[1])
            w.line(f"SetItemLockStrength({target}, {strength});")
        elif cmd.args:
            w.line(f"SetItemLockStrength(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        else:
            return False
        return True


class SolidifyProjectileTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SolidifyProjectile({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("SolidifyProjectile(GetOwner());")
        return True


class LightGammaTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if not cmd.args:
            return False
        w.line(f"SetWorldLightGamma({ctx.translate_expr(cmd.args[0])});")
        return True


def register_commands():
    register("precache", PrecacheTranslator())
    register("precachefile", PrecacheTranslator())
    register("changelevel", ChangeLevelTranslator())
    register("usetrigger", UseTriggerTranslator())
    register("setprop", SetPropTranslator())
    register("setsolid", SetSolidTranslator())
    register("setbbox", SetBBoxTranslator())
    register("blood", BloodTranslator())
    register("setcallback", SetCallbackTranslator())
    register("scriptflags", ScriptFlagsTranslator())
    register("dbg", DebugPrintTranslator())
    register("debugprint", DebugPrintTranslator())
    register("quest", QuestTranslator())
    register("giveexp", GiveExpTranslator())
    register("skilllevel", SkillLevelTranslator())
    register("clientcmd", ClientCmdTranslator())
    register("servercmd", ServerCmdTranslator())
    register("setcvar", SetCvarTranslator())
    register("clientevent", ClientEventTranslator())
    register("effect", EffectTranslator())
    register("cleffect", ClEffectTranslator())
    register("settrans", SetTransTranslator())
    register("setpvp", SetPvPTranslator())
    register("getplayers", GetPlayersTranslator())
    register("getplayersarray", GetPlayersTranslator())
    register("getplayersnb", GetPlayersTranslator())
    register("getplayer", GetPlayersTranslator())
    register("removescript", RemoveScriptTranslator())
    register("gagplayer", GagPlayerTranslator())
    register("setenv", SetEnvTranslator())
    register("setlights", SetLightsTranslator())
    register("setlock", SetLockTranslator())
    register("solidifyprojectile", SolidifyProjectileTranslator())
    register("lightgamma", LightGammaTranslator())
    register("companion", CommandTranslator())
    register("endgame", CommandTranslator())
    register("resetglobals", CommandTranslator())
    register("conflictcheck", NopTranslator())
    register("forcesend", NopTranslator())
    register("nosend", NopTranslator())

    # Register commands
    register("registerrace", CommandTranslator())
    register("registertitle", CommandTranslator())
    register("registerdefaults", CommandTranslator())
    register("registereffect", CommandTranslator())
    register("registertexture", CommandTranslator())

    # Debug commands — map to LogDebug
    for dbg_cmd in [
        "dbg_all", "dbg_npcs", "dbg_target", "dbg_items",
        "dbg_hand_active", "dbg_hand_off", "dbg_players",
        "dbg_world", "dbg_gm", "dbg_index", "dbg_scriptname",
    ]:
        register(dbg_cmd, DebugPrintTranslator())

    # HUD commands
    register("hud.addstatusicon", CommandTranslator())
    register("hud.addimgicon", CommandTranslator())
    register("hud.killicons", CommandTranslator())
    register("hud.killstatusicon", CommandTranslator())
    register("hud.killimgicon", CommandTranslator())
    register("hud.setfnconnection", CommandTranslator())

    # Local menu commands
    for menu_cmd in [
        "localmenu.reset", "localmenu.open", "localmenu.close",
        "registerlocal.menu", "registerlocal.button",
        "registerlocal.paragraph", "registerlocal.image",
    ]:
        register(menu_cmd, CommandTranslator())

    # Item commands
    register("projectilesize", CommandTranslator())
    register("itemrestrict", CommandTranslator())
    register("syncitem", CommandTranslator())
    register("displaydesc", CommandTranslator())
    register("setquality", CommandTranslator())
    register("setquantity", CommandTranslator())
    register("setwearpos", CommandTranslator())
    register("setviewmodelprop", CommandTranslator())
    register("overwritespell", CommandTranslator())
    register("wipespell", CommandTranslator())

    # File I/O
    register("erasefile", CommandTranslator())
    register("writeline", CommandTranslator())
    register("chatlog", CommandTranslator())

    # Store commands
    register("createstore", CommandTranslator())
    register("offerstore", CommandTranslator())
    register("addstoreitem", CommandTranslator())
    register("offer", CommandTranslator())

    # Effects
    register("darkenbloom", CommandTranslator())
    register("getents", CommandTranslator())
    register("getitemarray", CommandTranslator())

    register("kick", CommandTranslator())
    register("playername", CommandTranslator())
    register("playertitle", CommandTranslator())

    # Registration/definition commands — emit as TODO comments
    register("reg", CommandTranslator())
    register("registerarmor", CommandTranslator())
    register("registercontainer", CommandTranslator())
    register("registerspell", CommandTranslator())

    # Movement/AI commands
    register("movetype", CommandTranslator())
    register("setgaitspeed", CommandTranslator())
    register("maxslope", CommandTranslator())
    register("roamdelay", CommandTranslator())
    register("tospawn", CommandTranslator())

    # Player/entity state
    register("setstatus", CommandTranslator())
    register("setrender", CommandTranslator())
    register("removesetvar", CommandTranslator())
    register("setrvard", CommandTranslator())

    # Item/projectile
    register("projectiletouch", CommandTranslator())

    # Sound
    register("playmp3", CommandTranslator())
    register("splayviewanim", CommandTranslator())
    register("playermessagecl", CommandTranslator())

    # DLLFunc
    register("dllfunc", CommandTranslator())

    # Menu
    register("menu.autopen", CommandTranslator())
