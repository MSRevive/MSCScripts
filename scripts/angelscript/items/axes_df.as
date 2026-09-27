#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesDf : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	int FAURA_MP;
	int FAURA_RADIUS;
	string FAURA_START;
	float FREEZE_ATTACK_DELAY;
	int FREEZE_COUNT;
	string FREEZE_TARGS;
	string GAME_PVP;
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
	string NEXT_FREEZE_ATTEMPT;
	string OLD_REPEAT_TARGET;
	string REPEAT_TARGET;
	string SOUND_SWIPE;
	int VANIM_WARCRY;

	AxesDf()
	{
		BASE_LEVEL_REQ = 30;
		FAURA_MP = 50;
		FAURA_RADIUS = 256;
		VANIM_WARCRY = 9;
		FREEZE_ATTACK_DELAY = 0.4;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 6;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 77;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 2;
		MELEE_DMG = 500;
		MELEE_DMG_RANGE = 50;
		MELEE_DMG_TYPE = "cold";
		MELEE_ACCURACY = 0.6;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Wintercleaver");
		SetDescription("A gigantic axe of elemental ice");
		SetWeight(90);
		SetSize(25);
		SetValue(5000);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 146);
		FREEZE_COUNT = 0;
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		REPEAT_TARGET = param2;
		if (OLD_REPEAT_TARGET == REPEAT_TARGET)
		{
			FREEZE_COUNT += 1;
		}
		else
		{
			FREEZE_COUNT = 0;
		}
		OLD_REPEAT_TARGET = param2;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.ice");
		if (FREEZE_COUNT < 4)
		{
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "axehandling");
		}
		else
		{
			FREEZE_COUNT = 0;
			DOT_BURN *= 0.25;
			if (GetEntityHealth(param2) < 2000)
			{
			}
			ApplyEffect(param2, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "axehandling", 2000);
		}
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_FREEZE_ATTEMPT)) return;
		NEXT_FREEZE_ATTEMPT = GetGameTime();
		NEXT_FREEZE_ATTEMPT += 1.0;
		if (GetEntityMP(GetOwner()) < FAURA_MP)
		{
			SendColoredMessage(GetOwner(), "Wintercleaver: Insufficient mana for Freezing Burst.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetSkillLevel(GetOwner(), "spellcasting.ice") < 25)
		{
			SendColoredMessage(GetOwner(), "Wintercleaver: Insufficient ice skill for Freezing Burst.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// TODO: splayviewanim ent_me VANIM_WARCRY
		GiveMP(GetOwner());
		FREEZE_ATTACK_DELAY("do_faura");
		// svplaysound: svplaysound 0 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(0, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void do_faura()
	{
		FAURA_START = GetEntityOrigin(GetOwner());
		FAURA_START = "z";
		ClientEvent("new", "all", "effects/sfx_ice_burst", FAURA_START, FAURA_RADIUS, 1, Vector3(64, 64, 255));
		CallExternal(GetOwner(), "ext_sphere_token_x", "enemy", 256);
		FREEZE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		LogDebug("do_faura FREEZE_TARGS");
		if (!(FREEZE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FREEZE_TARGS, ";"); i++)
		{
			faura_affect_targets();
		}
	}

	void faura_affect_targets()
	{
		string CUR_TARG = GetToken(FREEZE_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityHealth(CUR_TARG) < 2000)) return;
		LogDebug("faura_affect_targets GetEntityName(CUR_TARG)");
		ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", Random(5.0, 8.0), GetEntityIndex(GetOwner()), 0, "none", 2000);
	}

}

}
