#pragma context server

#include "shender_east/elemental_ice_guardian.as"

namespace MS
{

class ElementalIceGuardian2 : CGameScript
{
	int ATTACK_MOVERANGE_DEF;
	int BE_AGRESSIVE;
	int DMG_BURST;
	int DMG_LUNGE;
	int DMG_STAFF;
	int DOT_FROST;
	float FREQ_PROJECTILE;
	float ICE_GUARD_FIRE_VULN;
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
		ICE_GUARD_NAME = "Nightmare of Ice";
		ICE_GUARD_HP = 3000;
		ICE_GUARD_FIRE_VULN = 0.5;
		ICE_GUARD_LEVEL = 2;
		ICE_GUARD_MODEL = "monsters/ice_guardian.mdl";
		ICE_GUARD_WIDTH = 32;
		ICE_GUARD_HEIGHT = 96;
		NPC_BASE_EXP = 1500;
		if (StringToLower(GetMapName()) == "tundra")
		{
			NPC_IS_BOSS = 1;
			NPC_EXP_REDUCT = 1.5;
		}
		DMG_BURST = 100;
		DMG_LUNGE = 125;
		DMG_STAFF = 75;
		DOT_FROST = 35;
		ATTACK_MOVERANGE_DEF = 200;
		FREQ_PROJECTILE = 3.0;
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
