#pragma context server

#include "items/pack_base.as"

namespace MS
{

class PackHeavybackpack : CGameScript
{
	PackHeavybackpack()
	{
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "armor/packs/p_packs.mdl";
		const string MODEL_WORLD = "armor/packs/p_packs.mdl";
		const string MODEL_WEAR = "armor/packs/p_packs.mdl";
		const string CONTAINER_TYPE = "generic";
		const int CONTAINER_SPACE = 200;
		const int CONTAINER_MAXITEMS = 32;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_REJECT = "scroll2;shields;pack";
		const int MODEL_BODY_OFS = 2;
		const string ANIM_PREFIX = "backpack";
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
