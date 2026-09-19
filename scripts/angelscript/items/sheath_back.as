#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBack : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;

	SheathBack()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 4;
		CONTAINER_MAXITEMS = 1;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "swords;polearms";
		CONTAINER_ITEM_REJECT = "item_tk_";
		MODEL_BODY_OFS = 3;
	}

	void sheath_spawn()
	{
		SetName("Back Sword Sheath");
		SetDescription("A leather sheath, designed to be worn across the back.");
		SetWeight(1);
		SetSize(60);
		SetValue(4);
		SetWearable(1);
		SetHUDSprite("trade", "sheath2");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void sheath_wear()
	{
		SendPlayerMessage(GetOwner(), "You strap a leather sheath across your back.");
	}

}

}
