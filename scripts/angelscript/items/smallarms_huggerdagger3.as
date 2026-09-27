#pragma context server

#include "items/smallarms_huggerdagger.as"

namespace MS
{

class SmallarmsHuggerdagger3 : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_RANGE;

	SmallarmsHuggerdagger3()
	{
		BASE_LEVEL_REQ = 9;
		MELEE_DMG = 220;
		MELEE_DMG_RANGE = 90;
		MELEE_RANGE = 35;
		MELEE_ACCURACY = 0.8;
	}

	void weapon_spawn()
	{
		SetName("Sharp Hugger Dagger");
		SetDescription("A dagger only useful if you re close enough to give the enemy a big warm hug");
		SetWeight(1);
		SetSize(1);
		SetValue(60);
	}

}

}
