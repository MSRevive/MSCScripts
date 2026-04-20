#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBeltSnakeskin : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;

	SheathBeltSnakeskin()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 30;
		CONTAINER_MAXITEMS = 6;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "swords";
		CONTAINER_ITEM_REJECT = "item_tk_";
		MODEL_BODY_OFS = 1;
	}

	void sheath_spawn()
	{
		SetName("Snakeskin Sword Sheath");
		SetDescription("A bundle of strong snakeskin tubes , easily affixed to a belt");
		SetWeight(1);
		SetSize(60);
		SetValue(50);
		SetWearable(1);
		SetHUDSprite("trade", "sheath1");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void sheath_wear()
	{
		SendPlayerMessage("You", "fasten some snakeskin tubes to your belt.");
	}

}

}
