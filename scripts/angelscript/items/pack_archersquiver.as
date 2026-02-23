#pragma context server

#include "items/pack_quiver.as"

namespace MS
{

class PackArchersquiver : CGameScript
{
	PackArchersquiver()
	{
		const int ANIM_IDLE = 0;
		const string MODEL_VIEW = "weapons/bows/quiver_rview.mdl";
		const string MODEL_HANDS = "weapons/bows/quiver_hands.mdl";
		const string MODEL_WORLD = "weapons/bows/quiver_floor.mdl";
		const string MODEL_WEAR = "weapons/bows/quiver_spine3.mdl";
		const int CONTAINER_SPACE = 600;
		const int CONTAINER_MAXITEMS = 16;
		const string CONTAINER_ITEM_ACCEPT = "arrow;bolt;bows;crossbow";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
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
