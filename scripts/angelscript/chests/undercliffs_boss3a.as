#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsBoss3a : CGameScript
{
	int BC_GLOWSHELL;
	string BC_GLOWSHELL_COLOR;
	int BC_SPRITE_IN;

	UndercliffsBoss3a()
	{
		BC_SPRITE_IN = 1;
		BC_GLOWSHELL = 1;
		BC_GLOWSHELL_COLOR = Vector3(255, 255, 255);
	}

	void OnSpawn() override
	{
		SetName("Prismatic Chest");
		SetMonsterClip(0);
		tc_add_artifact("axes_b", 4);
		tc_add_artifact("axes_c", 4);
	}

	void chest_additems()
	{
		if ((ItemExists(CHEST_USER, "item_ring_ryza")))
		{
			if (GetPlayerQuestData(CHEST_USER, "manaring") == "0")
			{
				if (!(ItemExists(CHEST_USER, "item_ring_ryza_gem3")))
				{
					AddStoreItem(STORENAME, "item_ring_ryza_gem3", 1, 0);
				}
			}
		}
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= 2;
		L_GOLD_TO_ADD *= "game.playersnb";
		if (L_GOLD_TO_ADD > 25000)
		{
			int L_GOLD_TO_ADD = 25000;
		}
		add_gold(int(L_GOLD_TO_ADD));
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		AddStoreItem(STORENAME, "item_crystal_return", 1, 0);
		AddStoreItem(STORENAME, "mana_speed", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
		for (int i = 0; i < RandomInt(1, 2); i++)
		{
			add_items_self_adj();
		}
	}

	void add_items_self_adj()
	{
		int L_RAND = RandomInt(1, 5);
		if (L_RAND == 1)
		{
			add_great_arrows(50);
			add_great_pot();
			add_great_item();
		}
		if (L_RAND == 2)
		{
			add_great_arrows(50);
			add_great_pot();
			add_great_item();
			add_epic_item();
		}
		if (L_RAND == 3)
		{
			add_great_arrows(50);
			add_great_pot();
			add_great_item();
			add_epic_item();
			add_epic_arrows(50);
			add_epic_pot();
		}
		if (L_RAND == 4)
		{
			add_great_arrows(75);
			add_great_pot();
			add_great_item();
			add_epic_item();
			add_epic_arrows(75);
			add_epic_pot();
		}
		if (L_RAND == 5)
		{
			add_great_arrows(80);
			add_great_pot();
			add_great_item();
			add_epic_item();
			add_epic_arrows(80);
			add_epic_pot();
		}
	}

}

}
