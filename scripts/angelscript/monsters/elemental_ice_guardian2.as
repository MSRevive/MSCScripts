#pragma context server

#include "monsters/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian2 : CGameScript
{
	int ATTACK_MOVERANGE_DEF;
	int DMG_BURST;
	int DMG_LUNGE;
	int DMG_STAFF;
	int DOT_FROST;
	float FREQ_PROJECTILE;
	int ICE_GUARD_HEIGHT;
	int ICE_GUARD_HP;
	int ICE_GUARD_LEVEL;
	string ICE_GUARD_MODEL;
	string ICE_GUARD_NAME;
	int ICE_GUARD_WIDTH;
	int NPC_BASE_EXP;
	string NPC_EXP_REDUCT;
	string NPC_IS_BOSS;

	ElementalIceGuardian2()
	{
		ICE_GUARD_NAME = "Ice Guardian";
		ICE_GUARD_HP = 6000;
		ICE_GUARD_LEVEL = 2;
		ICE_GUARD_MODEL = "monsters/ice_guardian.mdl";
		ICE_GUARD_WIDTH = 32;
		ICE_GUARD_HEIGHT = 96;
		NPC_BASE_EXP = 3000;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		DMG_BURST = 200;
		DMG_LUNGE = 250;
		DMG_STAFF = 150;
		DOT_FROST = 75;
		ATTACK_MOVERANGE_DEF = 200;
		FREQ_PROJECTILE = 3.0;
	}

	void game_precache()
	{
		Precache("effects/sfx_seal");
		Precache("firemagic_8bit.spr");
	}

}

}
