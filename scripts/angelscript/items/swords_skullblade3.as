#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade3 : CGameScript
{
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;

	SwordsSkullblade3()
	{
		MELEE_ENERGY = 2;
		MELEE_DMG = 225;
		MELEE_DMG_RANGE = 10;
		MELEE_ACCURACY = 0.55;
	}

	void weapon_spawn()
	{
		SetName("Sharp Skullblade");
		SetDescription("This sword relies more on its weight than its sharp edge.");
		SetValue(330);
	}

}

}
