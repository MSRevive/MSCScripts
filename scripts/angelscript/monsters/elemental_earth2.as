#pragma context server

#include "monsters/elemental_earth1.as"

namespace MS
{

class ElementalEarth2 : CGameScript
{
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	int IS_UNHOLY;

	ElementalEarth2()
	{
		const int ELEMENTAL_LEVEL = 2;
		const int NUM_LONGS = 3;
		const int ELEMENTAL_EXP = 1000;
		const int HITCHANCE_SWIPE = 90;
		const string DMG_SWIPE = RandomInt(200, 400);
		const string DMG_ROCK = RandomInt(250, 800);
		const string DMG_FISSURE = RandomInt(200, 400);
		const string DMG_STORM = RandomInt(400, 800);
		const int DOT_EARTHQUAKE = 100;
		const float SHIELD_DURATION = 20.0;
		const int ELEMENTAL_MOVERANGE = 256;
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
