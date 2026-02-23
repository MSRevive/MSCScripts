#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesDf : CGameScript
{
	string FAURA_START;
	int FREEZE_COUNT;
	string FREEZE_TARGS;
	string GAME_PVP;
	string NEXT_FREEZE_ATTEMPT;
	string OLD_REPEAT_TARGET;
	string REPEAT_TARGET;

	AxesDf()
	{
		const int BASE_LEVEL_REQ = 30;
		const int FAURA_MP = 50;
		const int FAURA_RADIUS = 256;
		const int VANIM_WARCRY = 9;
		const float FREEZE_ATTACK_DELAY = 0.4;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 6;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 77;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 500;
		const int MELEE_DMG_RANGE = 50;
		const string MELEE_DMG_TYPE = "cold";
		const float MELEE_ACCURACY = 0.6;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
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
