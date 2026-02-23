#pragma context server

#include "shender_east/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian2 : CGameScript
{
	int BE_AGRESSIVE;
	string NPC_EXP_REDUCT;
	string NPC_IS_BOSS;

	ElementalIceGuardian2()
	{
		const string ICE_GUARD_NAME = "Nightmare of Ice";
		const int ICE_GUARD_HP = 3000;
		const float ICE_GUARD_FIRE_VULN = 0.5;
		const int ICE_GUARD_LEVEL = 2;
		const string ICE_GUARD_MODEL = "monsters/ice_guardian.mdl";
		const int ICE_GUARD_WIDTH = 32;
		const int ICE_GUARD_HEIGHT = 96;
		const int NPC_BASE_EXP = 1500;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		const int DMG_BURST = 100;
		const int DMG_LUNGE = 125;
		const int DMG_STAFF = 75;
		const int DOT_FROST = 35;
		const int ATTACK_MOVERANGE_DEF = 200;
		const float FREQ_PROJECTILE = 3.0;
		if (StringToLower(GetMapName()) == "shender_east")
		{
		}
		BE_AGRESSIVE = 1;
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
	}

}

}
