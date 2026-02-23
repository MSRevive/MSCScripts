#pragma context server

#include "items/smallarms_craftedknife.as"

namespace MS
{

class SmallarmsCraftedknife2 : CGameScript
{
	SmallarmsCraftedknife2()
	{
		const int BASE_LEVEL_REQ = 9;
		const int MELEE_DMG = 210;
		const int MELEE_DMG_RANGE = 90;
		const int MELEE_RANGE = 35;
		const float MELEE_ACCURACY = 0.8;
	}

	void weapon_spawn()
	{
		SetName("Finely Crafted Knife");
		SetDescription("A deadly looking dagger of high craftsmanship");
		SetWeight(3);
		SetSize(2);
		SetValue(20);
	}

}

}
