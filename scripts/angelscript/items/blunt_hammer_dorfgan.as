#pragma context server

#include "items/blunt_hammer1.as"

namespace MS
{

class BluntHammerDorfgan : CGameScript
{
	BluntHammerDorfgan()
	{
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 110;
		const int MELEE_DMG_RANGE = 90;
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
