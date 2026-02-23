#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian3 : CGameScript
{
	string NPC_EXP_REDUCT;
	string NPC_IS_BOSS;

	ElementalIceGuardian3()
	{
		const string ICE_GUARD_NAME = "Greater Ice Guardian";
		const int ICE_GUARD_HP = 8000;
		const int ICE_GUARD_LEVEL = 3;
		const string ICE_GUARD_MODEL = "monsters/ice_guardian2.mdl";
		const int ICE_GUARD_WIDTH = 48;
		const int ICE_GUARD_HEIGHT = 120;
		const int NPC_BASE_EXP = 10000;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		SetDamageResistance("lightning", 0.0);
		const int DMG_BURST = 300;
		const int DMG_LUNGE = 300;
		const int DMG_STAFF = 200;
		const int DOT_FROST = 100;
		const int DOT_SHOCK = 200;
		const int ATTACK_MOVERANGE_DEF = 256;
		const int ATTACK_MOVERANGE_AGRO = 70;
		const int ATTACK_RANGE_DEF = 90;
		const int ATTACK_HITRANGE_DEF = 120;
		const int LUNGE_RANGE_MIN = 100;
		const int LUNGE_RANGE_MAX = 225;
		const int LUNGE_RANGE_MAX_HITRANGE = 175;
		const string FREQ_PROJECTILE = Random(8.0, 12.0);
		const Vector3 OFS_ICE_BALL = Vector3(0, 16, 80);
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
