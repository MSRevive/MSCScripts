#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class KeyCrystal : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	KeyCrystal()
	{
		MODEL_WORLD = "misc/item_key_ice.mdl";
		MODEL_HANDS = "misc/item_key_ice.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Crystal Key");
		SetDescription("This delicate enchanted key reforged from crystal fragments");
		SetHUDSprite("trade", "key");
	}

}

}
