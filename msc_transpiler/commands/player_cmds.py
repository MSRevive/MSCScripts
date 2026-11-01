"""Player-specific commands: giveitem, offer, menu, store, etc."""

from __future__ import annotations

from .registry import register, CommandTranslator


class SetMovedestTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            target = ctx.translate_expr(cmd.args[0])
            w.line(f"SetMoveDest({target});")
        return True


class MenuItemRegisterTranslator(CommandTranslator):
    """menuitem.register EVENT_NAME DISPLAY_TEXT."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            event = ctx.translate_expr(cmd.args[0])
            text = " ".join(ctx.expr_raw(a) for a in cmd.args[1:])
            w.line(f'RegisterMenuItem({event}, "{text}");')
        elif cmd.args:
            w.line(f"RegisterMenuItem({ctx.translate_expr(cmd.args[0])});")
        return True


class MenuItemRemoveTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"RemoveMenuItem({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("RemoveAllMenuItems();")
        return True


class MenuOpenTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"OpenMenu({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("OpenMenu();")
        return True


class MenuAutoOpenTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetMenuAutoOpen({ctx.translate_expr(cmd.args[0])});")
        return True


class AddStoreItemTranslator(CommandTranslator):
    """addstoreitem ITEM_SCRIPT [PRICE] [FLAGS]."""
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"AddStoreItem({args});")
        return True


class CatchSpeechTranslator(CommandTranslator):
    """catchspeech EVENT KEYWORD."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            event = ctx.translate_expr(cmd.args[0])
            keyword = ctx.translate_expr(cmd.args[1])
            w.line(f"CatchSpeech({event}, {keyword});")
        return True


class SayTranslator(CommandTranslator):
    """say TEXT — NPC speech."""
    def translate(self, cmd, ctx, w):
        if cmd.args:
            text = " ".join(ctx.expr_raw(a) for a in cmd.args)
            w.line(f'Say("{text}");')
        return True


class LookTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"LookAt({ctx.translate_expr(cmd.args[0])});")
        else:
            w.line("LookAt(GetOwner());")
        return True


class SeeTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"CanSee({ctx.translate_expr(cmd.args[0])});")
        return True


class SetHudSpriteTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"SetHUDSprite({args});")
        return True


class ValueTranslator(CommandTranslator):
    """value AMOUNT — set item value."""
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetValue({ctx.translate_expr(cmd.args[0])});")
        return True


class SizeTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetSize({ctx.translate_expr(cmd.args[0])});")
        return True


class PlayViewAnimTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            anim_type = ctx.expr_raw(cmd.args[0])
            anim_name = ctx.translate_expr(cmd.args[1])
            w.line(f'PlayViewAnim("{anim_type}", {anim_name});')
        elif cmd.args:
            w.line(f"PlayViewAnim({ctx.translate_expr(cmd.args[0])});")
        return True


class TossProjectileTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"TossProjectile({args});")
        return True


class PlayOwnerAnimTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            anim_type = ctx.expr_raw(cmd.args[0])
            anim_name = ctx.translate_expr(cmd.args[1])
            w.line(f'PlayOwnerAnim("{anim_type}", {anim_name});')
        elif cmd.args:
            w.line(f"PlayOwnerAnim({ctx.translate_expr(cmd.args[0])});")
        return True


class SetDmgTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetDamage({ctx.translate_expr(cmd.args[0])});")
        return True


class SetHandTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetHand({ctx.translate_expr(cmd.args[0])});")
        return True


class SetViewModelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetViewModel({ctx.translate_expr(cmd.args[0])});")
        return True


class SetWorldModelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetWorldModel({ctx.translate_expr(cmd.args[0])});")
        return True


class SetAnimMoveSpeedTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAnimMoveSpeed({ctx.translate_expr(cmd.args[0])});")
        return True


class RecvOfferTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"ReceiveOffer({ctx.translate_expr(cmd.args[0])});")
        return True


class RegisterAttackTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"RegisterAttack({args});")
        return True


class SetActionAnimTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetActionAnim({ctx.translate_expr(cmd.args[0])});")
        return True


class WearableTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetWearable({ctx.translate_expr(cmd.args[0])});")
        return True


class GroupableTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetGroupable({ctx.translate_expr(cmd.args[0])});")
        return True


class SetMonsterClipTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetMonsterClip({ctx.translate_expr(cmd.args[0])});")
        return True


class FovTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetFOV({ctx.translate_expr(cmd.args[0])});")
        return True


class GiveItemTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            target = ctx.translate_expr(cmd.args[0])
            item = ctx.translate_expr(cmd.args[1])
            w.line(f"GiveItem({target}, {item});")
        elif cmd.args:
            w.line(f"GiveItem(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class SetAnimExtTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAnimExt({ctx.translate_expr(cmd.args[0])});")
        return True


class SetAnimLegsTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetAnimLegs(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class GaitFramerateTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetGaitFrameRate(GetOwner(), {ctx.translate_expr(cmd.args[0])});")
        return True


class ReturnDataTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"ReturnData({args});")
        return True


class RegisterDrinkTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"RegisterDrink({args});")
        return True


class StoreEntityTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"StoreEntity({ctx.translate_expr(cmd.args[0])});")
        return True


class ClearFxTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("ClearFX();")
        return True


class CancelAttackTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        w.line("CancelAttack();")
        return True


class ExpireTimeTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetExpireTime({ctx.translate_expr(cmd.args[0])});")
        return True


class UseableTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetUseable({ctx.translate_expr(cmd.args[0])});")
        return True


class CallOwnerEventTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            event = ctx.expr_raw(cmd.args[0])
            params = [ctx.translate_expr(a) for a in cmd.args[1:]]
            if params:
                w.line(f'CallOwnerEvent("{event}", {", ".join(params)});')
            else:
                w.line(f'CallOwnerEvent("{event}");')
        return True


class SetPModelTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetPlayerModel({ctx.translate_expr(cmd.args[0])});")
        return True


class FloatTranslator(CommandTranslator):
    """float VAR — convert var to float."""
    def translate(self, cmd, ctx, w):
        if cmd.args:
            var = ctx.expr_raw(cmd.args[0])
            w.line(f"{var} = float({var});")
        return True


class SetTurnRateTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetTurnRate({ctx.translate_expr(cmd.args[0])});")
        return True


class RegisterProjectileTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"RegisterProjectile({args});")
        return True


class ExpAdjTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"AdjustExp({ctx.translate_expr(cmd.args[0])});")
        return True


class RemoveItemTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"RemoveItem({ctx.translate_expr(cmd.args[0])});")
        return True


class NpcStoreTranslator(CommandTranslator):
    def __init__(self, action: str):
        self.action = action

    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"NpcStore{self.action}({args});")
        return True


class StorageTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        args = ", ".join(ctx.translate_expr(a) for a in cmd.args)
        w.line(f"Storage({args});")
        return True


class QualityTranslator(CommandTranslator):
    def translate(self, cmd, ctx, w):
        if cmd.args:
            w.line(f"SetQuality({ctx.translate_expr(cmd.args[0])});")
        return True


class VarTranslator(CommandTranslator):
    """var NAME VALUE — alias for setvar."""
    def translate(self, cmd, ctx, w):
        if len(cmd.args) >= 2:
            name = ctx.expr_raw(cmd.args[0])
            val = ctx.translate_expr(cmd.args[1])
            w.line(f"{name} = {val};")
        return True


def register_commands():
    register("setmovedest", SetMovedestTranslator())
    register("menuitem.register", MenuItemRegisterTranslator())
    register("menuitem.remove", MenuItemRemoveTranslator())
    register("menu.open", MenuOpenTranslator())
    register("menu.autoopen", MenuAutoOpenTranslator())
    register("addstoreitem", AddStoreItemTranslator())
    register("catchspeech", CatchSpeechTranslator())
    register("say", SayTranslator())
    register("look", LookTranslator())
    register("see", SeeTranslator())
    register("sethudsprite", SetHudSpriteTranslator())
    register("value", ValueTranslator())
    register("size", SizeTranslator())
    register("playviewanim", PlayViewAnimTranslator())
    register("tossprojectile", TossProjectileTranslator())
    register("playowneranim", PlayOwnerAnimTranslator())
    register("setdmg", SetDmgTranslator())
    register("sethand", SetHandTranslator())
    register("setviewmodel", SetViewModelTranslator())
    register("setworldmodel", SetWorldModelTranslator())
    register("setanim.movespeed", SetAnimMoveSpeedTranslator())
    register("recvoffer", RecvOfferTranslator())
    register("registerattack", RegisterAttackTranslator())
    register("setactionanim", SetActionAnimTranslator())
    register("wearable", WearableTranslator())
    register("groupable", GroupableTranslator())
    register("setmonsterclip", SetMonsterClipTranslator())
    register("fov", FovTranslator())
    register("giveitem", GiveItemTranslator())
    register("setanimext", SetAnimExtTranslator())
    register("setanimlegs", SetAnimLegsTranslator())
    register("gaitframerate", GaitFramerateTranslator())
    register("returndata", ReturnDataTranslator())
    register("registerdrink", RegisterDrinkTranslator())
    register("storeentity", StoreEntityTranslator())
    register("clearfx", ClearFxTranslator())
    register("cancelattack", CancelAttackTranslator())
    register("expiretime", ExpireTimeTranslator())
    register("useable", UseableTranslator())
    register("callownerevent", CallOwnerEventTranslator())
    register("setpmodel", SetPModelTranslator())
    register("float", FloatTranslator())
    register("setturnrate", SetTurnRateTranslator())
    register("registerprojectile", RegisterProjectileTranslator())
    register("expadj", ExpAdjTranslator())
    register("removeitem", RemoveItemTranslator())
    register("npcstore.create", NpcStoreTranslator("Create"))
    register("npcstore.offer", NpcStoreTranslator("Offer"))
    register("npcstore.remove", NpcStoreTranslator("Remove"))
    register("storage", StorageTranslator())
    register("quality", QualityTranslator())
    register("var", VarTranslator())
