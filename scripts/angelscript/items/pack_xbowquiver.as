#pragma context server

#include "items/pack_quiver.as"

namespace MS
{

class PackXbowquiver : CGameScript
{
	int ANIM_IDLE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;

	PackXbowquiver()
	{
		ANIM_IDLE = 0;
		MODEL_VIEW = "weapons/bows/quiver_rview.mdl";
		MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		CONTAINER_MAXITEMS = 8;
		CONTAINER_SPACE = 200;
		CONTAINER_ITEM_ACCEPT = "bolt";
		CONTAINER_ITEM_REJECT = "item_tk_";
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
