#pragma context server

#include "items/blunt_mithral.as"

namespace MS
{

class BluntDb : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	float DEMON_ATK_DURATION;
	int DEMON_CHARGES;
	int DEMON_DMG;
	float DEMON_DMG_DELAY;
	float DEMON_DURATION;
	int FIRE_WAVE_MP;
	string FIRE_WAVE_START_POS;
	string FIRE_WAVE_TARGS;
	string FIRE_WAVE_YAW;
	string GAME_PVP;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int M_ATTACK;

	BluntDb()
	{
		BASE_LEVEL_REQ = 30;
		FIRE_WAVE_MP = 40;
		DEMON_CHARGES = 6;
		DEMON_DURATION = 40.0;
		MELEE_RANGE = 90;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.1;
		DEMON_DMG_DELAY = 0.25;
		DEMON_ATK_DURATION = 0.7;
		MELEE_ENERGY = 2;
		MELEE_DMG = 450;
		DEMON_DMG = 800;
		MELEE_DMG_RANGE = 40;
		MELEE_ACCURACY = 0.8;
		MELEE_PARRY_AUGMENT = 0.2;
		MELEE_DMG_TYPE = "dark";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 7;
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 71;
		ANIM_PREFIX = "standard";
	}

	void weapon_spawn()
	{
		SetName("Demon Bludgeon Hammer");
		SetDescription("A massive Bludgeon Demon hammer powered by an infernal soul");
		SetWeight(80);
		SetSize(10);
		SetValue(6000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", 144);
		M_ATTACK = 1;
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
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DOT_BURN *= 0.5;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "bluntarms");
	}

	void special_02_strike()
	{
		if (!(true)) return;
		if (!(param1 == "world")) return;
		string ATTACK_END_POS = param2;
		if (!((ATTACK_END_POS).z == /* TODO: $get_ground_height */ $get_ground_height(ATTACK_END_POS))) return;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 25)) return;
		if (GetEntityMP(GetOwner()) < FIRE_WAVE_MP)
		{
			SendColoredMessage(GetOwner(), "Demon Bludgeon Hammer: Insufficient " + MP + " for Fire Wave");
		}
		if (!(GetEntityMP(GetOwner()) >= FIRE_WAVE_MP)) return;
		GiveMP(GetOwner());
		do_fire_wave(GetEntityOrigin(GetOwner()));
	}

	void do_fire_wave()
	{
		EmitSound(GetOwner(), 0, "magic/flame_loop_start.wav", 7);
		FIRE_WAVE_START_POS = param1;
		FIRE_WAVE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_fire_wave", FIRE_WAVE_START_POS, FIRE_WAVE_YAW);
		string FIRE_WAVE_SCAN_POS = FIRE_WAVE_START_POS;
		FIRE_WAVE_SCAN_POS += /* TODO: $relpos */ $relpos(Vector3(0, FIRE_WAVE_YAW, 0), Vector3(0, 128, 32));
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
		string OWNER_ORG = FIRE_WAVE_START_POS;
		Vector3 OWNER_ANG = Vector3(0, FIRE_WAVE_YAW, 0);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		LogDebug("fire_wave_affect_targs WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG) GetEntityName(CUR_TARG)");
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string TRACE_START = FIRE_WAVE_START_POS;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "bluntarms");
	}

}

}
