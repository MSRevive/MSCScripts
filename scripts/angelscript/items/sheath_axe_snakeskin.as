#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathAxeSnakeskin : CGameScript
{
	SheathAxeSnakeskin()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 50;
		const int CONTAINER_MAXITEMS = 6;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "axes";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 4;
	}

	void sheath_spawn()
	{
		SetName("Snakeskin Axe Holster");
		SetDescription("A series of snakeskin loops designed to hold axes on a belt");
		SetWeight(1);
		SetSize(60);
		SetValue(50);
		SetWearable(1);
		SetHUDSprite("trade", "sheath1");
	}

	void sheath_wear()
	{
		SendPlayerMessage("You", "fasten some large snakeskin loops to your belt.");
	}

}

}
