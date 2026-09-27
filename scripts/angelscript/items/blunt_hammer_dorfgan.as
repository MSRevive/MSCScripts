#pragma context server

#include "items/blunt_hammer1.as"

namespace MS
{

class BluntHammerDorfgan : CGameScript
{
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;

	BluntHammerDorfgan()
	{
		MELEE_ENERGY = 2;
		MELEE_DMG = 110;
		MELEE_DMG_RANGE = 90;
	}

	void weapon_spawn()
	{
		SetName("Dorfgan s Hammer");
		SetDescription("Dorfgan s lost hammer");
		SetWeight(25);
		SetSize(6);
		SetValue(35);
	}

}

}
