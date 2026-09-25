#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc6 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 50));
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "blunt_hammer2", 1, 0);
		AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		AddStoreItem(STORENAME, "swords_bastardsword", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana2", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana3", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "sheath_belt_snakeskin", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_skullblade2", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_silvertipped", 30, 0, 0, 15);
		}
		if (RandomInt(1, 5) == 1)
		{
			add_good_item();
		}
	}

}

}
