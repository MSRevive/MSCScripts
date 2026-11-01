#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ChapelBat : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 40));
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "health_spotion", 1, 0);
		}
		AddStoreItem(STORENAME, "swords_bastardsword", 1, 0);
		if (RandomInt(1, 2) == 1)
		{
			add_noob_item();
		}
		if (RandomInt(1, 2) == 1)
		{
			add_noob_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana2", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_longsword", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana2", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana3", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade2", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_silvertipped", 300, 0, 0, 60);
		}
	}

}

}
