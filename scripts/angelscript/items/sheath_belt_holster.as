#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBeltHolster : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;

	SheathBeltHolster()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 30;
		CONTAINER_MAXITEMS = 2;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "axes;blunt";
		MODEL_BODY_OFS = 1;
		CONTAINER_ITEM_REJECT = "item_tk_";
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
