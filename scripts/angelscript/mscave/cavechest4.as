#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest4 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "swords_shortsword", 1, 0);
		}
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "axes_axe", 1, 0);
		}
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "axes_battleaxe", 1, 0);
		}
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "smallarms_dagger", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana", 1, 0);
		}
		else
		{
			if (RandomInt(1, 10) == 1)
			{
				AddStoreItem(STORENAME, "swords_katana2", 1, 0);
			}
			else
			{
				if (RandomInt(1, 15) == 1)
				{
					AddStoreItem(STORENAME, "swords_katana3", 1, 0);
				}
			}
		}
	}

}

}
