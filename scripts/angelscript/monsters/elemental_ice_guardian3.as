#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian3 : CGameScript
{
	int ATTACK_HITRANGE_DEF;
	int ATTACK_MOVERANGE_AGRO;
	int ATTACK_MOVERANGE_DEF;
	int ATTACK_RANGE_DEF;
	int DMG_BURST;
	int DMG_LUNGE;
	int DMG_STAFF;
	int DOT_FROST;
	int DOT_SHOCK;
	float FREQ_PROJECTILE;
	int ICE_GUARD_HEIGHT;
	int ICE_GUARD_HP;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int LUNGE_RANGE_MAX;
	int LUNGE_RANGE_MAX_HITRANGE;
	int LUNGE_RANGE_MIN;
	int NPC_BASE_EXP;
	string NPC_EXP_REDUCT;
	string NPC_IS_BOSS;
	string OFS_ICE_BALL;

	ElementalIceGuardian3()
	{
		ICE_GUARD_NAME = "Greater Ice Guardian";
		ICE_GUARD_HP = 8000;
		ICE_GUARD_LEVEL = 3;
		ICE_GUARD_MODEL = "monsters/ice_guardian2.mdl";
		ICE_GUARD_WIDTH = 48;
		ICE_GUARD_HEIGHT = 120;
		NPC_BASE_EXP = 10000;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		SetDamageResistance("lightning", 0.0);
		DMG_BURST = 300;
		DMG_LUNGE = 300;
		DMG_STAFF = 200;
		DOT_FROST = 100;
		DOT_SHOCK = 200;
		ATTACK_MOVERANGE_DEF = 256;
		ATTACK_MOVERANGE_AGRO = 70;
		ATTACK_RANGE_DEF = 90;
		ATTACK_HITRANGE_DEF = 120;
		LUNGE_RANGE_MIN = 100;
		LUNGE_RANGE_MAX = 225;
		LUNGE_RANGE_MAX_HITRANGE = 175;
		FREQ_PROJECTILE = Random(8.0, 12.0);
		OFS_ICE_BALL = Vector3(0, 16, 80);
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(StringToLower(GetMapName()) == "shender_east")) return;
		if (!("game.players.totalhp" < 3000)) return;
		CallExternal(GAME_MASTER, "map_shender_east_dream_win");
	}

}

}
