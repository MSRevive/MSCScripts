#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyIce : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	KeyIce()
	{
		MODEL_WORLD = "misc/item_key_ice.mdl";
		MODEL_HANDS = "misc/item_key_ice.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Key of Ice");
		SetDescription("This key seems to be made of magical ice");
		SetHUDSprite("trade", 163);
	}

}

}
