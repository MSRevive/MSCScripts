#pragma context server

#include "monsters/elemental_earth1.as"

namespace MS
{

class ElementalEarth2 : CGameScript
{
	int DMG_FISSURE;
	int DMG_ROCK;
	int DMG_STORM;
	int DMG_SWIPE;
	int DOT_EARTHQUAKE;
	int ELEMENTAL_EXP;
	int ELEMENTAL_LEVEL;
	int ELEMENTAL_MOVERANGE;
	int HITCHANCE_SWIPE;
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	int IS_UNHOLY;
	int NUM_LONGS;
	float SHIELD_DURATION;

	ElementalEarth2()
	{
		ELEMENTAL_LEVEL = 2;
		NUM_LONGS = 3;
		ELEMENTAL_EXP = 1000;
		HITCHANCE_SWIPE = 90;
		DMG_SWIPE = RandomInt(200, 400);
		DMG_ROCK = RandomInt(250, 800);
		DMG_FISSURE = RandomInt(200, 400);
		DMG_STORM = RandomInt(400, 800);
		DOT_EARTHQUAKE = 100;
		SHIELD_DURATION = 20.0;
		ELEMENTAL_MOVERANGE = 256;
	}

	void elemental_spawn()
	{
		SetName("Greater Earth Elemental");
		SetModel("monsters/elementals_greater.mdl");
		SetHealth(2500);
		SetWidth(32);
		SetHeight(48);
		SetRace("demon");
		SetBloodType("none");
		IS_BLOODLESS = 1;
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
		SetDamageResistance("all", 0.25);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModelBody(0, 2);
	}

}

}
