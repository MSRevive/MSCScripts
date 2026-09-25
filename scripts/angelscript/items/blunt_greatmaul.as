#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntGreatmaul : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;

	BluntGreatmaul()
	{
		BASE_LEVEL_REQ = 12;
		MELEE_DMG = 290;
		MELEE_DMG_RANGE = 150;
		MELEE_ENERGY = 11;
		MELEE_ATK_DURATION = 1.5;
	}

	void weapon_spawn()
	{
		SetName("Great Maul");
		SetDescription("An even heavier maul");
		SetWeight(125);
		SetSize(13);
		SetValue(530);
	}

}

}
