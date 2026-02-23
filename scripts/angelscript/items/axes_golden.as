#pragma context server

#include "items/axes_golden_ref.as"

namespace MS
{

class AxesGolden : CGameScript
{
	AxesGolden()
	{
		const int THIS_NO_BREAK = 0;
		const int FINAL_VALUE = 4000;
		const int BREAK_CHANCE = 2;
	}

	void weapon_spawn()
	{
		SetName("Golden Axe");
		SetHUDSprite("trade", 111);
	}

}

}
