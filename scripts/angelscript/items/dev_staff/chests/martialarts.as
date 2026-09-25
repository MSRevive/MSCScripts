#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Martialarts : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "blunt_gauntlets", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_bear", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_demon", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_fire", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_ic", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_leather", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_serpant", 1, 0);
	}

}

}
