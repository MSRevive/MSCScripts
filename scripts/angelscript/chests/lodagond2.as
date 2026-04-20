#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lodagond2 : CGameScript
{
	void OnSpawn() override
	{
		SetName("Lodagond Chest 2");
	}

	void chest_additems()
	{
		add_gold(300);
		chest_add_hpot_mpot();
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 12) == 1)
		{
			int SCROLL_TOME = RandomInt(1, 2);
			if (SCROLL_TOME == 1)
			{
				AddStoreItem(STORENAME, "scroll_lightning_storm", 1, 0);
			}
			if (SCROLL_TOME == 2)
			{
				AddStoreItem(STORENAME, "scroll2_lightning_storm", 1, 0);
			}
		}
		if (RandomInt(1, 6) == 1)
		{
			add_epic_item();
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		}
		if (RandomInt(1, 7) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 9) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
	}

}

}
