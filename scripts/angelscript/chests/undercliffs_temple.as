#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsTemple : CGameScript
{
	UndercliffsTemple()
	{
		const int BC_SPRITE_IN = 1;
	}

	void OnSpawn() override
	{
		SetMonsterClip(0);
	}

	void chest_additems()
	{
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= 2;
		L_GOLD_TO_ADD *= "game.playersnb";
		if (L_GOLD_TO_ADD > 25000)
		{
			int L_GOLD_TO_ADD = 25000;
		}
		add_gold(int(L_GOLD_TO_ADD));
		offer_felewyn_symbol(25);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_holy", 15, 0, 0, 15);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_gholy", 15, 0, 0, 15);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
		}
		AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
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
		}
		if (L_RAND == 2)
		{
			add_epic_item();
		}
		if (L_RAND == 3)
		{
			add_epic_item();
			add_good_pot();
		}
		if (L_RAND == 4)
		{
			add_epic_item();
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
