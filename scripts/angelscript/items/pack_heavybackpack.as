#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackHeavybackpack : CGameScript
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

	PackHeavybackpack()
	{
		MODEL_VIEW = "none";
		MODEL_HANDS = "armor/packs/p_packs.mdl";
		MODEL_WORLD = "armor/packs/p_packs.mdl";
		MODEL_WEAR = "armor/packs/p_packs.mdl";
		CONTAINER_TYPE = "generic";
		CONTAINER_SPACE = 200;
		CONTAINER_MAXITEMS = 32;
		CONTAINER_CANCLOSE = 0;
		CONTAINER_LOCK_STRENGTH = 0;
		CONTAINER_ITEM_REJECT = "scroll2;shields;pack";
		MODEL_BODY_OFS = 2;
		ANIM_PREFIX = "backpack";
	}

	void pack_spawn()
	{
		SetName("Heavy Backpack");
		SetDescription("A heavy backpack , suited for wear and tear");
		SetWeight(3);
		SetSize(80);
		SetValue(50);
		SetWearable(1);
		SetHUDSprite("trade", "hvybackpack");
	}

	void pack_deploy()
	{
		string MB_TEMP = "game.item.hand_index";
		MB_TEMP -= 2;
		MB_TEMP += MODEL_BODY_OFS;
		SetModelBody(0, MB_TEMP);
		SetViewModel("none");
	}

	void pack_wear()
	{
		SendPlayerMessage("You", "sling a heavy backpack over your shoulder.");
	}

}

}
