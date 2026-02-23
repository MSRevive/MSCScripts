#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade2 : CGameScript
{
	SwordsSkullblade2()
	{
		const int BASE_LEVEL_REQ = 6;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 10;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.5;
	}

	void weapon_spawn()
	{
		SetName("Dull Skullblade");
		SetDescription("This heavy broad sword has seen one too many battles.");
		SetWeight(80);
		SetValue(100);
	}

}

}
