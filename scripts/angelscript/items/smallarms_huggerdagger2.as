#pragma context server

#include "items/smallarms_huggerdagger.as"

namespace MS
{

class SmallarmsHuggerdagger2 : CGameScript
{
	SmallarmsHuggerdagger2()
	{
		const int BASE_LEVEL_REQ = 6;
		const int MELEE_DMG = 180;
		const int MELEE_DMG_RANGE = 90;
		const int MELEE_RANGE = 35;
		const float MELEE_ACCURACY = 0.8;
	}

	void weapon_spawn()
	{
		SetName("Dull Hugger Dagger");
		SetDescription("A dagger only useful if you re close enough to give the enemy a big warm hug");
		SetWeight(1);
		SetSize(1);
		SetValue(20);
	}

}

}
