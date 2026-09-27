#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemCrowShard : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemCrowShard()
	{
		MODEL_WORLD = "misc/item_key_ice.mdl";
		MODEL_HANDS = "misc/item_key_ice.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Crystal Shard");
		SetDescription("A shard of a magic key. It could be reforged , if you had all the pieces.");
		SetHUDSprite("trade", "key");
	}

}

}
