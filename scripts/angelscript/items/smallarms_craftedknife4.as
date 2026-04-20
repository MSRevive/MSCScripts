#pragma context server

#include "items/smallarms_craftedknife.as"

namespace MS
{

class SmallarmsCraftedknife4 : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_RANGE;

	SmallarmsCraftedknife4()
	{
		BASE_LEVEL_REQ = 12;
		MELEE_DMG = 250;
		MELEE_DMG_RANGE = 90;
		MELEE_RANGE = 35;
		MELEE_ACCURACY = 0.8;
	}

	void weapon_spawn()
	{
		SetName("Perfect Finely Crafted Knife");
		SetDescription("A deadly looking dagger of high craftsmanship");
		SetWeight(3);
		SetSize(2);
		SetValue(500);
	}

}

}
