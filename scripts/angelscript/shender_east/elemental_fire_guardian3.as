#pragma context server

#include "shender_east/elemental_ice_guardian.as"

namespace MS
{

class ElementalFireGuardian3 : CGameScript
{
	int BE_AGRESSIVE;
	int DMG_METEOR;
	int DOT_METEOR;
	int FLAME_JET_DMG;
	int FLAME_JET_DOT;
	string NPC_IS_BOSS;

	ElementalFireGuardian3()
	{
		const string ICE_GUARD_NAME = "Fell Nightmare of Flame";
		const int ICE_GUARD_HP = 4000;
		const int ICE_GUARD_FIRE_VULN = 0;
		const int ICE_GUARD_LEVEL = 3;
		const string ICE_GUARD_MODEL = "monsters/fire_guardian2.mdl";
		const int ICE_GUARD_WIDTH = 48;
		const int ICE_GUARD_HEIGHT = 120;
		if (StringToLower(GetMapName()) == "phobia")
		{
			NPC_IS_BOSS = 1;
		}
		const int NPC_BASE_EXP = 3500;
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		const int DMG_BURST = 150;
		const int DMG_LUNGE = 150;
		const int DMG_STAFF = 100;
		const int DOT_FROST = 100;
		const int DOT_SHOCK = 100;
		FLAME_JET_DMG = 150;
		FLAME_JET_DOT = 50;
		const string GUARD_ELEMENT = "fire";
		const float ICE_GUARD_ICE_VULN = 0.0;
		const float ICE_GUARD_FIRE_VULN = 0.0;
		const string ICE_GUARD_DOT_EFFECT = "effects/dot_fire";
		const int ATTACK_MOVERANGE_DEF = 256;
		const int ATTACK_MOVERANGE_AGRO = 70;
		const int ATTACK_RANGE_DEF = 90;
		const int ATTACK_HITRANGE_DEF = 120;
		const int LUNGE_RANGE_MIN = 100;
		const int LUNGE_RANGE_MAX = 225;
		const int LUNGE_RANGE_MAX_HITRANGE = 175;
		const float FREQ_SHOCK_STORM = 20.0;
		const string FREQ_PROJECTILE = Random(5.0, 10.0);
		const string FREQ_ICE_BALL = Random(5.0, 10.0);
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string STAFF_ALT_EFFECT = "effects/dot_poison_blind";
		const string CL_FX_SCRIPT = "monsters/elemental_fire_guardian_cl";
		const Vector3 STAFF_BEAM_COLOR = Vector3(0, 255, 0);
		const string SOUND_SHOCK_LOOP = "magic/blackhole.wav";
		const string SOUND_SHOCK_START = "magic/spookie1.wav";
		const string SOUND_SHOCK_HIT = "bullchicken/bc_bite2.wav";
		const float FREQ_METEOR = 20.0;
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
