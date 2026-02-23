#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBeltHolster : CGameScript
{
	SheathBeltHolster()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 30;
		const int CONTAINER_MAXITEMS = 2;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "axes;blunt";
		const int MODEL_BODY_OFS = 1;
		const string CONTAINER_ITEM_REJECT = "item_tk_";
	}

	void sheath_spawn()
	{
		SetName("Heavy Weapon Holster");
		SetDescription("A simple thick leather loop for axes and hammers.");
		SetWeight(1);
		SetSize(40);
		SetValue(2);
		SetWearable(1);
		SetHUDSprite("trade", "sheath1");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void sheath_wear()
	{
		SendPlayerMessage("You", "fasten a holster to your belt.");
	}

}

}
