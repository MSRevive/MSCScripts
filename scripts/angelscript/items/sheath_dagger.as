#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathDagger : CGameScript
{
	SheathDagger()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 50;
		const int CONTAINER_MAXITEMS = 1;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "smallarms";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const int MODEL_BODY_OFS = 4;
	}

	void sheath_spawn()
	{
		SetName("Dagger Sheath");
		SetDescription("A dagger sheath made out of leather");
		SetWeight(1);
		SetSize(60);
		SetValue(2);
		SetWearable(1);
		SetHUDSprite("trade", "sheath1");
	}

	void sheath_wear()
	{
		SendPlayerMessage("You", "fasten a dagger sheath to your belt.");
	}

}

}
