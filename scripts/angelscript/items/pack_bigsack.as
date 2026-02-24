#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackBigsack : CGameScript
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

	PackBigsack()
	{
		MODEL_VIEW = "none";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "armor/packs/p_packs.mdl";
		MODEL_WEAR = "armor/packs/p_packs.mdl";
		CONTAINER_TYPE = "generic";
		CONTAINER_SPACE = 200;
		CONTAINER_MAXITEMS = 32;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_REJECT = "polearms;arrow;scroll2;axes;swords;blunt;bows;shields;smallarms;bolt;pack";
		MODEL_BODY_OFS = 6;
		ANIM_PREFIX = "bigsack";
	}

	void pack_spawn()
	{
		SetName("Big Sack");
		SetDescription("A big sack , worn over the shoulder");
		SetWeight(1);
		SetSize(25);
		SetValue(4);
		SetWearable(1);
		SetHUDSprite("trade", "backsheath");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void pack_wear()
	{
		SendPlayerMessage("You", "sling a big sack over your shoulder.");
	}

}

}
