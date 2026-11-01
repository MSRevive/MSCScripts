#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercryptsT1 : CGameScript
{
	void OnSpawn() override
	{
		SetMonsterClip(0);
	}

	void chest_additems()
	{
		add_gold(200);
		if (GetEntityMaxHealth(CHEST_USER) < 10)
		{
			int MIN_ITEM_LEVEL = 0;
			int UPGRADE_CHANCE = 0;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 50)
		{
			int MIN_ITEM_LEVEL = 0;
			int UPGRADE_CHANCE = 5;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 100)
		{
			int MIN_ITEM_LEVEL = 1;
			int UPGRADE_CHANCE = 10;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 400)
		{
			int MIN_ITEM_LEVEL = 1;
			int UPGRADE_CHANCE = 20;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 600)
		{
			int MIN_ITEM_LEVEL = 1;
			int UPGRADE_CHANCE = 50;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 800)
		{
			int MIN_ITEM_LEVEL = 2;
			int UPGRADE_CHANCE = 75;
		}
		if (GetEntityMaxHealth(CHEST_USER) >= 1000)
		{
			int MIN_ITEM_LEVEL = 3;
			int UPGRADE_CHANCE = 0;
		}
		if (RandomInt(1, 100) <= UPGRADE_CHANCE)
		{
			MIN_ITEM_LEVEL += 1;
		}
		if (RandomInt(1, 100) <= UPGRADE_CHANCE)
		{
			MIN_ITEM_LEVEL += 1;
		}
		if (MIN_ITEM_LEVEL > 3)
		{
			int MIN_ITEM_LEVEL = 3;
		}
		if (MIN_ITEM_LEVEL == 0)
		{
			string ITEM_EVENT = "add_noob_item";
		}
		if (MIN_ITEM_LEVEL == 1)
		{
			string ITEM_EVENT = "add_good_item";
		}
		if (MIN_ITEM_LEVEL == 2)
		{
			string ITEM_EVENT = "add_great_item";
		}
		if (MIN_ITEM_LEVEL == 3)
		{
			string ITEM_EVENT = "add_epic_item";
		}
		ITEM_EVENT(100);
	}

}

}
