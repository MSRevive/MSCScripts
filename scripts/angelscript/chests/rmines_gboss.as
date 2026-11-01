#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RminesGboss : CGameScript
{
	void chest_additems()
	{
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= "game.playersnb";
		L_GOLD_TO_ADD *= 10;
		add_gold(int(L_GOLD_TO_ADD));
		AddStoreItem(STORENAME, "proj_bolt_poison", 25, 0, 0, 25);
		add_great_item();
		add_epic_item();
		add_great_arrows();
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "mana_bravery", 1, 0);
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "mana_paura", 1, 0);
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
		AddStoreItem(STORENAME, "proj_bolt_poison", 25, 0, 0, 25);
	}

}

}
