#pragma context server

#include "items/health_apple.as"

namespace MS
{

class CrossbowLight : CGameScript
{
	int DRINK_AMOUNT;

	CrossbowLight()
	{
		DRINK_AMOUNT = 1;
	}

	void drink_spawn()
	{
		SetName("Cheater s Crossbow");
		SetDescription("Eat this , cheaters");
	}

}

}
