#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest9 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		AddStoreItem(STORENAME, "blunt_hammer2", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_wooden", 120, 0, 0, 60);
		get_chance(5, 10, 100, 50);
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "proj_arrow_broadhead", 120, 0, 0, 60);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "proj_arrow_poison", 120, 0, 0, 60);
		}
		if (RandomInt(1, 100) <= 5)
		{
			AddStoreItem(STORENAME, "proj_arrow_jagged", 120, 0, 0, 60);
		}
		if (RandomInt(1, 50) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_golden", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		}
	}

}

}
