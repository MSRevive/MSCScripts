#pragma context server

#include "items/smallarms_huggerdagger.as"

namespace MS
{

class SmallarmsHuggerdagger4 : CGameScript
{
	SmallarmsHuggerdagger4()
	{
		const int BASE_LEVEL_REQ = 15;
		const int MELEE_DMG = 240;
		const int MELEE_DMG_RANGE = 90;
		const int MELEE_RANGE = 22;
		const float MELEE_ACCURACY = 0.85;
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
