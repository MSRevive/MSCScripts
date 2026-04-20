#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackQuiver : CGameScript
{
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_ACCEPT;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;

	PackQuiver()
	{
		MODEL_VIEW = "none";
		MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		CONTAINER_TYPE = "quiver";
		CONTAINER_SPACE = 200;
		CONTAINER_MAXITEMS = 8;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_ACCEPT = "arrow";
		CONTAINER_ITEM_REJECT = "item_tk_";
	}

	void pack_spawn()
	{
		SetName("Quiver for Arrows");
		SetDescription("A large quiver for arrows");
		SetWeight(1);
		SetSize(70);
		SetValue(4);
		SetWearable(1);
		SetHUDSprite("hand", "quiver");
		SetHUDSprite("trade", "quiver");
		SetHand("left");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void pack_wear()
	{
		SendPlayerMessage("You", "sling your quiver over your shoulder.");
	}

	void game_fall()
	{
		PlayAnim("once", "idle");
		pack_fall();
	}

}

}
