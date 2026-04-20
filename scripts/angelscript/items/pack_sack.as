#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackSack : CGameScript
{
	string ANIM_PREFIX;
	int CONTAINER_CANCLOSE;
	string CONTAINER_ITEM_REJECT;
	int CONTAINER_LOCK_STRENGTH;
	int CONTAINER_MAXITEMS;
	int CONTAINER_SPACE;
	string CONTAINER_TYPE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;

	PackSack()
	{
		MODEL_VIEW = "none";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "armor/packs/p_packs.mdl";
		MODEL_WEAR = "armor/packs/p_packs.mdl";
		CONTAINER_TYPE = "generic";
		CONTAINER_SPACE = 10;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_MAXITEMS = 8;
		CONTAINER_ITEM_REJECT = "arrow;axes;blunt;bolts;swords;bows;armor;pack;polearms";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "sack";
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
