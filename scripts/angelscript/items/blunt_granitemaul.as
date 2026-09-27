#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntGranitemaul : CGameScript
{
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;

	BluntGranitemaul()
	{
		BASE_LEVEL_REQ = 12;
		MELEE_DMG = 320;
		MELEE_DMG_RANGE = 160;
		MELEE_ENERGY = 20;
	}

	void weapon_spawn()
	{
		SetName("Granite Maul");
		SetDescription("A heavy granite maul");
		SetWeight(150);
		SetSize(15);
		SetValue(1100);
	}

}

}
