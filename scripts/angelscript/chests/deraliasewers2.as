#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Deraliasewers2 : CGameScript
{
	string GAVE_KEY;

	void chest_additems()
	{
		if (!(GAVE_KEY))
		{
			GAVE_KEY = 1;
			AddStoreItem(STORENAME, "item_key_sewer", 1, 0);
		}
		else
		{
			if (RandomInt(1, 5) == 1)
			{
				AddStoreItem(STORENAME, "item_key_sewer", 1, 0);
			}
		}
		add_gold(RandomInt(200, 1200));
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "armor_salamander", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			add_good_item();
			add_great_item();
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				add_epic_item();
			}
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_great_item();
			add_great_item();
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				add_epic_item();
			}
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				add_epic_item();
			}
			add_epic_arrows();
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_great_item();
			add_epic_item();
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				add_epic_item();
			}
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				add_epic_item();
			}
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 20) == 1)
		{
			add_epic_item();
			add_epic_arrows();
			if (RandomInt(1, 10) <= "game.playersnb")
			{
				AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
			}
		}
	}

}

}
