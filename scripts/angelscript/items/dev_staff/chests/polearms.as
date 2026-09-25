#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Polearms : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "polearms_a", 1, 0);
		AddStoreItem(STORENAME, "polearms_ba", 1, 0);
		AddStoreItem(STORENAME, "polearms_dra", 1, 0);
		AddStoreItem(STORENAME, "polearms_h", 1, 0);
		AddStoreItem(STORENAME, "polearms_hal", 1, 0);
		AddStoreItem(STORENAME, "polearms_har", 1, 0);
		AddStoreItem(STORENAME, "polearms_nag", 1, 0);
		AddStoreItem(STORENAME, "polearms_ph", 1, 0);
		AddStoreItem(STORENAME, "polearms_qs", 1, 0);
		AddStoreItem(STORENAME, "polearms_sl", 1, 0);
		AddStoreItem(STORENAME, "polearms_sp", 1, 0);
		AddStoreItem(STORENAME, "polearms_ti", 1, 0);
		AddStoreItem(STORENAME, "polearms_tri", 1, 0);
	}

}

}
