#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade4 : CGameScript
{
	SwordsSkullblade4()
	{
		const int BASE_LEVEL_REQ = 10;
		const int MELEE_ENERGY = 10;
		const int MELEE_DMG = 350;
		const int MELEE_DMG_RANGE = 10;
		const float MELEE_ACCURACY = 0.65;
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
