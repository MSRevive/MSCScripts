#pragma context server

#include "items/swords_skullblade.as"

namespace MS
{

class SwordsSkullblade2 : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;

	SwordsSkullblade2()
	{
		BASE_LEVEL_REQ = 6;
		MELEE_ENERGY = 2;
		MELEE_DMG = 100;
		MELEE_DMG_RANGE = 10;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.5;
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
