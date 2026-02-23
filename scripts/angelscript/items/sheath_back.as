#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBack : CGameScript
{
	SheathBack()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 4;
		const int CONTAINER_MAXITEMS = 1;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "swords;polearms";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 3;
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
