#pragma context server

#include "items/axes_base_twohanded.as"
#include "items/base_vampire.as"

namespace MS
{

class AxesSs : CGameScript
{
	string NEXT_THROW_ATTEMPT;
	string SHADOW_PROJ_ID;

	AxesSs()
	{
		const int BASE_LEVEL_REQ = 30;
		const int RANGED_MP = 30;
		const float THROW_ATTACK_DELAY = 0.5;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 7;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 74;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 120;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 450;
		const int MELEE_DMG_RANGE = 100;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
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
