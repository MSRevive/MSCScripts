#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathBackHolster : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;

	SheathBackHolster()
	{
		CONTAINER_TYPE = "sheath";
		CONTAINER_SPACE = 30;
		CONTAINER_MAXITEMS = 16;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "blunt;axes;swords;smallarms;bows;crossbow;polearms;gauntlet_";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 3;
	}

	void sheath_spawn()
	{
		SetName("Weapons Strap");
		SetDescription("A leather back strap with loops to hang a large array of weapons.");
		SetWeight(0);
		SetSize(60);
		SetValue(25);
		SetWearable(1);
		SetHUDSprite("trade", "sheath2");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void sheath_wear()
	{
		SendPlayerMessage(GetOwner(), "You loop a large leather strap across your back.");
	}

}

}
