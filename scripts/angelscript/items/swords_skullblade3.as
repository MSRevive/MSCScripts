#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade3 : CGameScript
{
	SwordsSkullblade3()
	{
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 225;
		const int MELEE_DMG_RANGE = 10;
		const float MELEE_ACCURACY = 0.55;
	}

	void weapon_spawn()
	{
		SetName("Sharp Skullblade");
		SetDescription("This sword relies more on its weight than its sharp edge.");
		SetValue(330);
	}

}

}
