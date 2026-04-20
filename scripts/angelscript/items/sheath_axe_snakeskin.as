#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathAxeSnakeskin : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;

	SheathAxeSnakeskin()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 50;
		CONTAINER_MAXITEMS = 6;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "axes";
		CONTAINER_ITEM_REJECT = "item_tk_";
		MODEL_BODY_OFS = 4;
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
