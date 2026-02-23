#pragma context server

#include "items/smallarms_huggerdagger.as"

namespace MS
{

class SmallarmsHuggerdagger3 : CGameScript
{
	SmallarmsHuggerdagger3()
	{
		const int BASE_LEVEL_REQ = 9;
		const int MELEE_DMG = 220;
		const int MELEE_DMG_RANGE = 90;
		const int MELEE_RANGE = 35;
		const float MELEE_ACCURACY = 0.8;
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
