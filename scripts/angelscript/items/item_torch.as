#pragma context server

#include "items/base_melee.as"

namespace MS
{

class ItemTorch : CGameScript
{
	string SCRIPT_ID;

	ItemTorch()
	{
		const int ANIM_IDLE1 = 0;
		const int ANIM_THRUST = 1;
		const string MODEL_VIEW = "misc/item_torch_rview.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string SOUND_HITWALL = "debris/wood2.wav";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string ITEM_NAME = "torch";
		const string SPRITE_FIRE = "fire1_fixed.spr";
		const string SPRITE_FIRE_FIXED = "fire1_fixed.spr";
		const int MODEL_BODY_OFS = 36;
		const string ANIM_PREFIX = "torch";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 60;
		const int MELEE_DMG_RANGE = 60;
		const string MELEE_DMG_TYPE = "fire";
		const int MELEE_ACCURACY = 30;
		const string MELEE_STAT = "bluntarms";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_THRUST;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const int MELEE_PARRY_CHANCE = 0;
		const string PLAYERANIM_AIM = "axe_onehand";
		const string PLAYERANIM_SWING = "axe_onehand_swing";
		const string TORCH_LIGHT_SCRIPT = "items/item_torch_light";
		const string LOOPSND_NAME = "items/torch1.wav";
		const int LOOPSND_LENGTH = 6;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(LOOPSND_LENGTH);
		if ((SCRIPT_ID))
		{
		}
		// svplaysound: svplaysound const.sound.item 5 LOOPSND_NAME
		EmitSound("const.sound.item", 5, LOOPSND_NAME);
	}

	void weapon_spawn()
	{
		SetName("Torch");
		SetDescription("A torch");
		SetWeight(1);
		SetSize(2);
		SetValue(1);
		SetHand("left");
		SetHUDSprite("hand", ITEM_NAME);
		SetHUDSprite("trade", ITEM_NAME);
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		SetModelBody(0, MODEL_BODY_OFS);
	}

	void OnDeploy() override
	{
		PlayViewAnim(ANIM_IDLE1);
		PlayAnim("once", "idle");
		weapon_deploy();
	}

	void melee_strike()
	{
		if (!(param1 == "npc")) return;
		if (!(param4)) return;
		int L_DMG = 30;
		L_DMG *= GetSkillLevel(GetOwner(), "bluntarms.ratio");
		ApplyEffect(param3, "effects/dot_fire", 3, GetEntityIndex(GetOwner()), L_DMG, "bluntarms");
	}

	void bweapon_effect_activate()
	{
		end_torch_fx();
		do_torch_fx("game_deploy");
	}

	void bweapon_effect_remove()
	{
		end_torch_fx();
	}

	void game_fall()
	{
		do_torch_fx("game_fall");
	}

	void game_putinpack()
	{
		end_torch_fx();
	}

	void do_torch_fx()
	{
		if ((SCRIPT_ID)) return;
		if (param1 == "game_deploy")
		{
			string L_BODY = "game.item.hand_index";
			L_BODY += 1;
			ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), L_BODY);
			SCRIPT_ID = "game.script.last_sent_id";
		}
		else
		{
			if (param1 == "game_fall")
			{
				ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), 1);
				SCRIPT_ID = "game.script.last_sent_id";
				PlayAnim("once", "torch_floor_idle");
			}
		}
	}

	void end_torch_fx()
	{
		if (!(SCRIPT_ID)) return;
		ClientEvent("update", "all", SCRIPT_ID, "remove_me");
		SCRIPT_ID = 0;
		// svplaysound: svplaysound const.sound.item 0 LOOPSND_NAME
		EmitSound("const.sound.item", 0, LOOPSND_NAME);
	}

}

}
