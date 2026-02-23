#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBeltHolsterSnakeskin : CGameScript
{
	SheathBeltHolsterSnakeskin()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 30;
		const int CONTAINER_MAXITEMS = 6;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "axes;blunt";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 1;
	}

	void sheath_spawn()
	{
		SetName("Snakeskin Heavy Holster");
		SetDescription("A series of snakeskin loops for axes and hammers");
		SetWeight(1);
		SetSize(40);
		SetValue(25);
		SetWearable(1);
		SetHUDSprite("trade", "sheath1");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void sheath_wear()
	{
		SendPlayerMessage("You", "fasten some large snakeskin loops to your belt.");
	}

}

}
