#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyCrystal : CGameScript
{
	KeyCrystal()
	{
		const string MODEL_WORLD = "misc/item_key_ice.mdl";
		const string MODEL_HANDS = "misc/item_key_ice.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Crystal Key");
		SetDescription("This delicate enchanted key reforged from crystal fragments");
		SetHUDSprite("trade", "key");
	}

}

}
