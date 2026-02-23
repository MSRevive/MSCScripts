#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class IceMain : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("bows_frost", 10);
		tc_add_artifact("armor_helm_gaz2", 10);
	}

	void chest_additems()
	{
		add_gold(546);
		AddStoreItem(STORENAME, "proj_arrow_frost", 120, 0, 0, 60);
		AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		}
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "swords_liceblade", 1, 0);
		}
		AddStoreItem(STORENAME, "mana_forget", 1, 0);
		if (RandomInt(1, 100) <= 2)
		{
			AddStoreItem(STORENAME, "scroll2_ice_blast", 1, 0);
		}
		string SCROLL_TOME = RandomInt(1, 2);
		if (SCROLL_TOME == 1)
		{
			AddStoreItem(STORENAME, "scroll_ice_shield", 1, 0);
		}
		if (SCROLL_TOME == 2)
		{
			AddStoreItem(STORENAME, "scroll2_ice_shield", 1, 0);
		}
		if (RandomInt(1, 100) <= 10)
		{
			string SCROLL_TOME = RandomInt(1, 2);
			if (SCROLL_TOME == 1)
			{
				AddStoreItem(STORENAME, "scroll_blizzard", 1, 0);
			}
			if (SCROLL_TOME == 2)
			{
				AddStoreItem(STORENAME, "scroll2_blizzard", 1, 0);
			}
		}
	}

}

}
