#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade4 : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;

	SwordsSkullblade4()
	{
		BASE_LEVEL_REQ = 10;
		MELEE_ENERGY = 10;
		MELEE_DMG = 350;
		MELEE_DMG_RANGE = 10;
		MELEE_ACCURACY = 0.65;
	}

	void weapon_spawn()
	{
		SetName("Perfect Skullblade");
		SetDescription("This sword relies more on its weight than its sharp edge.");
		SetWeight(80);
		SetValue(610);
	}

}

}
