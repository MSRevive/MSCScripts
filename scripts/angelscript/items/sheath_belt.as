#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBelt : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;

	SheathBelt()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 4;
		CONTAINER_MAXITEMS = 1;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "swords";
		MODEL_BODY_OFS = 1;
		CONTAINER_ITEM_REJECT = "item_tk_";
	}

	void sheath_spawn()
	{
		SetName("Belt Sword Sheath");
		SetDescription("A leather belt sheath");
		SetWeight(1);
		SetSize(60);
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
		SendPlayerMessage("You", "fasten a leather sheath to your belt.");
	}

}

}
