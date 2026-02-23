#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackQuiver : CGameScript
{
	PackQuiver()
	{
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		const string MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		const string MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		const string CONTAINER_TYPE = "quiver";
		const int CONTAINER_SPACE = 200;
		const int CONTAINER_MAXITEMS = 8;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "arrow";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
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
