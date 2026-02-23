#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChestGreat : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 25));
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		AddStoreItem(STORENAME, "health_apple", 1, 0);
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		string CHANCE = RandomInt(1, 100);
		if (CHANCE < 5)
		{
			AddStoreItem(STORENAME, "swords_katana4", 1, 0);
		}
		else
		{
			if (CHANCE < 10)
			{
				AddStoreItem(STORENAME, "swords_katana3", 1, 0);
			}
			else
			{
				if (CHANCE < 25)
				{
					AddStoreItem(STORENAME, "swords_katana2", 1, 0);
				}
				else
				{
					if (CHANCE < 50)
					{
						AddStoreItem(STORENAME, "swords_katana", 1, 0);
					}
				}
			}
		}
	}

}

}
