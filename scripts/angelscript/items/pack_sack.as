#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackSack : CGameScript
{
	PackSack()
	{
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "armor/packs/p_packs.mdl";
		const string MODEL_WEAR = "armor/packs/p_packs.mdl";
		const string CONTAINER_TYPE = "generic";
		const int CONTAINER_SPACE = 10;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const int CONTAINER_MAXITEMS = 8;
		const string CONTAINER_ITEM_REJECT = "arrow;axes;blunt;bolts;swords;bows;armor;pack;polearms";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "sack";
	}

	void pack_spawn()
	{
		SetName("Small Sack");
		SetDescription("A small sack, worn on the belt.");
		SetWeight(1);
		SetSize(20);
		SetValue(2);
		SetWearable(1);
		SetHUDSprite("hand", "sheath");
		SetHUDSprite("trade", "backsheath");
	}

	void pack_wear()
	{
		// TODO: playermessagecl You attach your sack to your belt.
	}

}

}
