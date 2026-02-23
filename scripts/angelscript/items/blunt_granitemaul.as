#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntGranitemaul : CGameScript
{
	BluntGranitemaul()
	{
		const int BASE_LEVEL_REQ = 12;
		const int MELEE_DMG = 320;
		const int MELEE_DMG_RANGE = 160;
		const int MELEE_ENERGY = 20;
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
