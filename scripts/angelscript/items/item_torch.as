#pragma context server

#include "items/base_melee.as"

namespace MS
{

class ItemTorch : CGameScript
{
	int ANIM_IDLE1;
	string ANIM_PREFIX;
	int ANIM_THRUST;
	string ITEM_NAME;
	int LOOPSND_LENGTH;
	string LOOPSND_NAME;
	int MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SCRIPT_ID;
	string SOUND_HITWALL;
	string SOUND_SWIPE;
	string SPRITE_FIRE;
	string SPRITE_FIRE_FIXED;
	string TORCH_LIGHT_SCRIPT;

	ItemTorch()
	{
		ANIM_IDLE1 = 0;
		ANIM_THRUST = 1;
		MODEL_VIEW = "misc/item_torch_rview.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		SOUND_HITWALL = "debris/wood2.wav";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		ITEM_NAME = "torch";
		SPRITE_FIRE = "fire1_fixed.spr";
		SPRITE_FIRE_FIXED = "fire1_fixed.spr";
		MODEL_BODY_OFS = 36;
		ANIM_PREFIX = "torch";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.2;
		MELEE_ENERGY = 1;
		MELEE_DMG = 60;
		MELEE_DMG_RANGE = 60;
		MELEE_DMG_TYPE = "fire";
		MELEE_ACCURACY = 30;
		MELEE_STAT = "bluntarms";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_THRUST;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0;
		PLAYERANIM_AIM = "axe_onehand";
		PLAYERANIM_SWING = "axe_onehand_swing";
		TORCH_LIGHT_SCRIPT = "items/item_torch_light";
		LOOPSND_NAME = "items/torch1.wav";
		LOOPSND_LENGTH = 6;
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
