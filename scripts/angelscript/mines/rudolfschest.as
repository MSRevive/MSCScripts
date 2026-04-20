#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Rudolfschest : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "blunt_rudolfsmace", 1, 0);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_gholy", 15, 0, 0, 15);
		}
		AddStoreItem(STORENAME, "proj_bolt_wooden", 50, 0, 0, 25);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_iron", 25, 0, 0, 25);
		}
	}

}

}
