#pragma context server

#include "items/pack_quiver.as"

namespace MS
{

class PackArchersquiver : CGameScript
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

	PackArchersquiver()
	{
		ANIM_IDLE = 0;
		MODEL_VIEW = "weapons/bows/quiver_rview.mdl";
		MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		CONTAINER_SPACE = 600;
		CONTAINER_MAXITEMS = 16;
		CONTAINER_ITEM_ACCEPT = "arrow;bolt;bows;crossbow";
		CONTAINER_ITEM_REJECT = "item_tk_";
	}

	void pack_spawn()
	{
		SetName("Quiver of the Archer");
		SetDescription("A large quiver for all sorts of projectiles");
		SetWeight(4);
		SetSize(70);
		SetValue(25);
		SetWearable(1);
		SetHUDSprite("trade", "quiver");
	}

}

}
