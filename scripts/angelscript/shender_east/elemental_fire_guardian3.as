#pragma context server

#include "shender_east/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian3 : CGameScript
{
	int ATTACK_HITRANGE_DEF;
	int ATTACK_MOVERANGE_AGRO;
	int ATTACK_MOVERANGE_DEF;
	int ATTACK_RANGE_DEF;
	int BE_AGRESSIVE;
	string CL_FX_SCRIPT;
	int DMG_BURST;
	int DMG_LUNGE;
	int DMG_METEOR;
	int DMG_STAFF;
	int DOT_FROST;
	int DOT_METEOR;
	int DOT_SHOCK;
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;
	float FREQ_ICE_BALL;
	float FREQ_METEOR;
	float FREQ_PROJECTILE;
	float FREQ_SHOCK_STORM;
	string GUARD_ELEMENT;
	string ICE_GUARD_DOT_EFFECT;
	int ICE_GUARD_FIRE_VULN;
	int ICE_GUARD_HEIGHT;
	int ICE_GUARD_HP;
	float ICE_GUARD_ICE_VULN;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int LUNGE_RANGE_MAX;
	int LUNGE_RANGE_MAX_HITRANGE;
	int LUNGE_RANGE_MIN;
	int NPC_BASE_EXP;
	string NPC_IS_BOSS;
	string SOUND_SHOCK_HIT;
	string SOUND_SHOCK_LOOP;
	string SOUND_SHOCK_START;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string STAFF_ALT_EFFECT;
	string STAFF_BEAM_COLOR;

	ElementalFireGuardian3()
	{
		ICE_GUARD_NAME = "Fell Nightmare of Flame";
		ICE_GUARD_HP = 4000;
		ICE_GUARD_FIRE_VULN = 0;
		ICE_GUARD_LEVEL = 3;
		ICE_GUARD_MODEL = "monsters/fire_guardian2.mdl";
		ICE_GUARD_WIDTH = 48;
		ICE_GUARD_HEIGHT = 120;
		if (StringToLower(GetMapName()) == "phobia")
		{
			NPC_IS_BOSS = 1;
		}
		NPC_BASE_EXP = 3500;
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		DMG_BURST = 150;
		DMG_LUNGE = 150;
		DMG_STAFF = 100;
		DOT_FROST = 100;
		DOT_SHOCK = 100;
		FLAME_JET_DMG = 150;
		FLAME_JET_DOT = 50;
		GUARD_ELEMENT = "fire";
		ICE_GUARD_ICE_VULN = 0.0;
		ICE_GUARD_FIRE_VULN = 0.0;
		ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		ATTACK_MOVERANGE_DEF = 256;
		ATTACK_MOVERANGE_AGRO = 70;
		ATTACK_RANGE_DEF = 90;
		ATTACK_HITRANGE_DEF = 120;
		LUNGE_RANGE_MIN = 100;
		LUNGE_RANGE_MAX = 225;
		LUNGE_RANGE_MAX_HITRANGE = 175;
		FREQ_SHOCK_STORM = 20.0;
		FREQ_PROJECTILE = Random(5.0, 10.0);
		FREQ_ICE_BALL = Random(5.0, 10.0);
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		STAFF_ALT_EFFECT = "effects/dot_poison_blind";
		CL_FX_SCRIPT = "monsters/elemental_fire_guardian_cl";
		STAFF_BEAM_COLOR = Vector3(0, 255, 0);
		SOUND_SHOCK_LOOP = "magic/blackhole.wav";
		SOUND_SHOCK_START = "magic/spookie1.wav";
		SOUND_SHOCK_HIT = "bullchicken/bc_bite2.wav";
		FREQ_METEOR = 20.0;
		DMG_METEOR = 750;
		DOT_METEOR = 200;
		if (StringToLower(GetMapName()) == "shender_east")
		{
		}
		BE_AGRESSIVE = 1;
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
		Precache(SOUND_SHOCK_LOOP);
	}

	void OnPostSpawn() override
	{
		if (!(StringToLower(GetMapName()) == "phobia")) return;
		CallExternal("all", "bandit_ally_fire_spawn");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (StringToLower(GetMapName()) == "phobia")
		{
			CallExternal("all", "bandit_ally_boss_dead");
		}
		if (StringToLower(GetMapName()) == "shender_east")
		{
			CallExternal(GAME_MASTER, "map_shender_east_dream_win");
		}
	}

}

}
