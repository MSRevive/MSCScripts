#pragma context server

#include "items/axes_golden_ref.as"

namespace MS
{

class AxesGolden : CGameScript
{
	int BREAK_CHANCE;
	int FINAL_VALUE;
	int THIS_NO_BREAK;

	AxesGolden()
	{
		THIS_NO_BREAK = 0;
		FINAL_VALUE = 4000;
		BREAK_CHANCE = 2;
	}

	void weapon_spawn()
	{
		SetName("Golden Axe");
		SetHUDSprite("trade", 111);
	}

}

}
