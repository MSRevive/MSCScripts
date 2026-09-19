#pragma context server

#include "items/axes_base_twohanded.as"
#include "items/base_vampire.as"

namespace MS
{

class AxesSs : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string NEXT_THROW_ATTEMPT;
	int RANGED_MP;
	string SHADOW_PROJ_ID;
	string SOUND_SWIPE;
	float THROW_ATTACK_DELAY;

	AxesSs()
	{
		BASE_LEVEL_REQ = 30;
		RANGED_MP = 30;
		THROW_ATTACK_DELAY = 0.5;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 7;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 74;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 120;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 2;
		MELEE_DMG = 450;
		MELEE_DMG_RANGE = 100;
		MELEE_DMG_TYPE = "dark";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Skull Scythe");
		SetDescription("A scythe imbued with magics of destruction");
		SetWeight(90);
		SetSize(25);
		SetValue(700);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 145);
		custom_register();
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string HEAL_AMT = GetEntityProperty(m_hLastStruckByMe, "scriptvar");
		HEAL_AMT /= 3;
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param2), HEAL_AMT);
	}

	void melee_start()
	{
		if ((true))
		{
			return_throw("melee_start");
		}
	}

	void special_01_start()
	{
		if ((true))
		{
			return_throw("special_01_start");
		}
	}

	void special_02_start()
	{
		if ((true))
		{
			return_throw("special_02_start");
		}
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_THROW_ATTEMPT)) return;
		NEXT_THROW_ATTEMPT = GetGameTime();
		NEXT_THROW_ATTEMPT += 1.0;
		if (GetEntityMP(GetOwner()) < RANGED_MP)
		{
			SendColoredMessage(GetOwner(), "Scull Scythe: Not enough mana to throw.");
			int EXIT_SUB = 1;
		}
		if (GetSkillLevel(GetOwner(), "axehandling") < 34)
		{
			SendColoredMessage(GetOwner(), "Scull Scythe: Insufficient Axehandling Proficiency to throw 34");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		// TODO: splayviewanim ent_me ANIM_ATTACK2
		THROW_ATTACK_DELAY("throw_weapon");
	}

	void throw_weapon()
	{
		// TODO: setviewmodelprop ent_me renderamt 1
		// TODO: setviewmodelprop ent_me rendermode 1
		if (((SHADOW_PROJ_ID !is null)))
		{
			return_throw("new_throw");
		}
		CallExternal(GetOwner(), "ext_tossprojectile", "proj_ss", "view", "none", 200, 100, 1, "axehandling");
		SHADOW_PROJ_ID = GetEntityProperty(GetOwner(), "scriptvar");
	}

	void ext_projectile_landed()
	{
		return_throw("ext_projectile_landed");
	}

	void return_throw()
	{
		if (param1 == "ext_projectile_landed")
		{
			// TODO: splayviewanim ent_me ANIM_IDLE1
		}
		else
		{
			if (((SHADOW_PROJ_ID !is null)))
			{
			}
			CallExternal(SHADOW_PROJ_ID, "remove_me", "remote");
		}
		if (!(param1 != "new_throw")) return;
		LogDebug("return_throw PARAM1 restore");
		// TODO: setviewmodelprop ent_me rendermode 1
		// TODO: setviewmodelprop ent_me renderamt 255
	}

	void bweapon_effect_remove()
	{
		LogDebug("bweapon_effect_remove");
		return_throw("bweapon_effect_remove");
		// TODO: setviewmodelprop ent_me rendermode 1
		// TODO: setviewmodelprop ent_me renderamt 255
	}

}

}
