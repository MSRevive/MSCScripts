#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyIce : CGameScript
{
	KeyIce()
	{
		const string MODEL_WORLD = "misc/item_key_ice.mdl";
		const string MODEL_HANDS = "misc/item_key_ice.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Key of Ice");
		SetDescription("This key seems to be made of magical ice");
		SetHUDSprite("trade", 163);
	}

}

}
