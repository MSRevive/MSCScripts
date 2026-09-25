#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class DeraliasewersGloam : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(501, 1999));
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
			add_great_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
			add_great_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_potion();
		}
	}

	void add_potion()
	{
		int RND_POT = RandomInt(1, 4);
		if (RND_POT == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
		}
		if (RND_POT == 2)
		{
			AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		}
		if (RND_POT == 3)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		if (RND_POT == 4)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
	}

}

}
