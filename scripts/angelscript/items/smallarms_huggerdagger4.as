#pragma context server

#include "items/smallarms_huggerdagger.as"

namespace MS
{

class SmallarmsHuggerdagger4 : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	int MELEE_RANGE;

	SmallarmsHuggerdagger4()
	{
		BASE_LEVEL_REQ = 15;
		MELEE_DMG = 240;
		MELEE_DMG_RANGE = 90;
		MELEE_RANGE = 22;
		MELEE_ACCURACY = 0.85;
	}

	void weapon_spawn()
	{
		SetName("Perfect Hugger Dagger");
		SetDescription("A dagger only useful if you re close enough to give the enemy a big warm hug");
		SetWeight(1);
		SetSize(1);
		SetValue(500);
	}

}

}
