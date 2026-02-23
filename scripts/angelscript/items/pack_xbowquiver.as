#pragma context server

#include "items/pack_quiver.as"

namespace MS
{

class PackXbowquiver : CGameScript
{
	PackXbowquiver()
	{
		const int ANIM_IDLE = 0;
		const string MODEL_VIEW = "weapons/bows/quiver_rview.mdl";
		const string MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		const string MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		const string MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		const int CONTAINER_MAXITEMS = 8;
		const int CONTAINER_SPACE = 200;
		const string CONTAINER_ITEM_ACCEPT = "bolt";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
	}

	void pack_spawn()
	{
		SetName("Quiver of Bolts");
		SetDescription("This quiver holds only crossbow bolts");
		SetWeight(1);
		SetSize(70);
		SetValue(80);
		SetWearable(1);
		SetHUDSprite("hand", "quiver");
		SetHUDSprite("trade", "quiver");
	}

}

}
