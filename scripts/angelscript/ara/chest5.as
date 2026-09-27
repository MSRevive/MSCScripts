#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest5 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "proj_bolt_wooden", 50, 0, 0, 50);
		AddStoreItem(STORENAME, "proj_bolt_iron", 50, 0, 0, 50);
		AddStoreItem(STORENAME, "proj_bolt_silver", 50, 0, 0, 50);
		AddStoreItem(STORENAME, "proj_bolt_fire", 50, 0, 0, 50);
	}

}

}
