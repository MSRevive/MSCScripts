#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackBohLesser : CGameScript
{
	int CONTAINER_BOH;

	PackBohLesser()
	{
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "armor/packs/p_packs.mdl";
		const string MODEL_WEAR = "armor/packs/p_packs.mdl";
		CONTAINER_BOH = 1;
		const string CONTAINER_TYPE = "generic";
		const int CONTAINER_SPACE = 200;
		const int CONTAINER_MAXITEMS = 500;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_REJECT = "arrow;scroll2;bolt;pack";
		const int MODEL_BODY_OFS = 6;
		const string ANIM_PREFIX = "bigsack";
	}

	void pack_spawn()
	{
		SetName("Bag of Holding");
		SetDescription("A magical bag that eliminates the weight of all items held within");
		SetWeight(0);
		SetSize(40);
		SetValue(2000);
		SetWearable(1);
		SetHUDSprite("trade", "backsheath");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void pack_wear()
	{
		SendPlayerMessage("You", "sling a bag of holding over your shoulder.");
	}

}

}
