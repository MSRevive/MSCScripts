#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestABase : CGameScript
{
	string SCROLL_TOME;

	void chest_additems()
	{
		add_gold(RandomInt(50, 500));
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "item_log", 1, 0);
		AddStoreItem(STORENAME, "item_crystal_return", 1, 0);
		if (FOAMY_CHEST_TYPE == 1)
		{
			if ((RandomInt(0, 1)))
			{
				AddStoreItem(STORENAME, "mana_gprotection", 1, 0);
			}
			else
			{
				AddStoreItem(STORENAME, "mana_protection", 1, 0);
			}
			SCROLL_TOME = GetRandomToken("scroll_poison_cloud;scroll2_poison_cloud;scroll_acid_xolt;scroll2_acid_xolt;scroll_poison;scroll2_poison", ";");
			AddStoreItem(STORENAME, SCROLL_TOME, 1, 0);
		}
		if (FOAMY_CHEST_TYPE == 2)
		{
			add_great_item();
			AddStoreItem(STORENAME, "smallarms_fangstooth", 1, 0);
		}
		if (FOAMY_CHEST_TYPE == 3)
		{
			AddStoreItem(STORENAME, "swords_nkatana", 1, 0);
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
		if (FOAMY_CHEST_TYPE == 4)
		{
			AddStoreItem(STORENAME, "armor_helm_bronze", 1, 0);
			if (RandomInt(1, 8) == 1)
			{
				AddStoreItem(STORENAME, "armor_salamander", 1, 0);
			}
			if (RandomInt(1, 4) == 1)
			{
				AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
			}
		}
	}

}

}
