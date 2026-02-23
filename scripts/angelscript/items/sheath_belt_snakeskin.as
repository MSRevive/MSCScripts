#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBeltSnakeskin : CGameScript
{
	SheathBeltSnakeskin()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 30;
		const int CONTAINER_MAXITEMS = 6;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "swords";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 1;
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
