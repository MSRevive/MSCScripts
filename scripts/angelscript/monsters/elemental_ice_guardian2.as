#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian2 : CGameScript
{
	string NPC_EXP_REDUCT;
	string NPC_IS_BOSS;

	ElementalIceGuardian2()
	{
		const string ICE_GUARD_NAME = "Ice Guardian";
		const int ICE_GUARD_HP = 6000;
		const int ICE_GUARD_LEVEL = 2;
		const string ICE_GUARD_MODEL = "monsters/ice_guardian.mdl";
		const int ICE_GUARD_WIDTH = 32;
		const int ICE_GUARD_HEIGHT = 96;
		const int NPC_BASE_EXP = 3000;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		const int DMG_BURST = 200;
		const int DMG_LUNGE = 250;
		const int DMG_STAFF = 150;
		const int DOT_FROST = 75;
		const int ATTACK_MOVERANGE_DEF = 200;
		const float FREQ_PROJECTILE = 3.0;
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
	}

}

}
