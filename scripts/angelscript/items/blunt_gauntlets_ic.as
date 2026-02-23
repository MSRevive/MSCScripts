#pragma context server

#include "items/blunt_gauntlets_demon.as"

namespace MS
{

class BluntGauntletsIc : CGameScript
{
	int DEMON_MODE;
	string FIRE_WAVE_SCAN_POS;
	string FIRE_WAVE_START_POS;
	string FIRE_WAVE_TARGS;
	string FIRE_WAVE_YAW;
	string GAME_PVP;
	string OWNER_ANG;
	string OWNER_ORG;

	BluntGauntletsIc()
	{
		const int BASE_LEVEL_REQ = 25;
		const int CUSTOM_CLAWS = 1;
		const int FIRE_WAVE_MP = 20;
		const int MELEE_DMG = 200;
		const float DEMON_STRIKE_RATIO = 6.0;
		const string MODEL_VIEW = "viewmodels/v_martialarts_claws.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 69;
		const string ANIM_PREFIX = "standard";
	}

	void weapon_spawn()
	{
		SetName("Infernal Claws");
		SetDescription("Demonic claws imbued with flame");
		SetWeight(3);
		SetSize(1);
		SetValue(6000);
		SetHand("both");
		SetHUDSprite("hand", 143);
		SetHUDSprite("trade", 143);
		register_demon_toggle();
		DEMON_MODE = 0;
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void demon_strike()
	{
		if (!(true)) return;
		if (!(param1 == "world")) return;
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") < 25)
		{
			SendColoredMessage(GetOwner(), "Infernal Claws: Insufficient skill for Fire Wave.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityMP(GetOwner()) < FIRE_WAVE_MP)
		{
			SendColoredMessage(GetOwner(), "Infernal Claws: Insufficient mana for Fire Wave.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string ATTACK_END_POS = param2;
		do_fire_wave(ATTACK_END_POS);
	}

	void do_fire_wave()
	{
		EmitSound(GetOwner(), 0, "magic/flame_loop_start.wav", 7);
		FIRE_WAVE_START_POS = param1;
		FIRE_WAVE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_fire_wave", FIRE_WAVE_START_POS, FIRE_WAVE_YAW);
		OWNER_ORG = FIRE_WAVE_START_POS;
		OWNER_ANG = Vector3(0, FIRE_WAVE_YAW, 0);
		FIRE_WAVE_SCAN_POS = FIRE_WAVE_START_POS;
		FIRE_WAVE_SCAN_POS += /* TODO: $relpos */ $relpos(Vector3(0, FIRE_WAVE_YAW, 0), Vector3(0, 128, 32));
		ScheduleDelayedEvent(1.25, "fire_wave2");
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 768, FIRE_WAVE_SCAN_POS);
		FIRE_WAVE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FIRE_WAVE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FIRE_WAVE_TARGS, ";"); i++)
		{
			fire_wave_affect_targs();
		}
	}

	void fire_wave2()
	{
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 1024, FIRE_WAVE_SCAN_POS);
		FIRE_WAVE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FIRE_WAVE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FIRE_WAVE_TARGS, ";"); i++)
		{
			fire_wave_affect_targs();
		}
	}

	void fire_wave_affect_targs()
	{
		string CUR_TARG = GetToken(FIRE_WAVE_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		LogDebug("fire_wave_affect_targs WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG) GetEntityName(CUR_TARG)");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string TRACE_START = FIRE_WAVE_START_POS;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "martialarts");
	}

	void game_dodamage()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DOT_BURN *= 0.5;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "martialarts");
	}

}

}
