#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsTown : CGameScript
{
	UndercliffsTown()
	{
		const int BC_SPRITE_IN = 1;
	}

	void OnSpawn() override
	{
		SetMonsterClip(0);
	}

	void chest_additems()
	{
		AddStoreItem(STORENAME, "health_apple", RandomInt(1, 5), 0);
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= 2;
		L_GOLD_TO_ADD *= "game.playersnb";
		if (L_GOLD_TO_ADD > 25000)
		{
			int L_GOLD_TO_ADD = 25000;
		}
		add_gold(int(L_GOLD_TO_ADD));
		AddStoreItem(STORENAME, "item_gwond", 1, 0);
		AddStoreItem(STORENAME, "item_galat_note_100", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_blunt", 15, 0, 0, 15);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w1", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_wolvesbane", 1, 0);
		}
		for (int i = 0; i < RandomInt(1, 2); i++)
		{
			add_items_self_adj();
		}
	}

	void add_items_self_adj()
	{
		string L_RAND = RandomInt(1, 5);
		if (L_RAND == 1)
		{
			add_great_item();
			add_good_pot();
		}
		if (L_RAND == 2)
		{
			add_epic_item();
			add_good_pot();
			add_great_pot();
		}
		if (L_RAND == 3)
		{
			add_epic_item();
			add_great_pot();
			add_epic_pot();
		}
		if (L_RAND == 4)
		{
			add_epic_item();
			add_epic_arrows(15);
			add_epic_pot();
		}
		if (L_RAND == 5)
		{
			add_epic_item();
			add_epic_arrows(30);
			add_great_pot();
			add_epic_pot();
		}
	}

}

}
