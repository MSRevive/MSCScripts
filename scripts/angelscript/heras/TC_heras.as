#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TcHeras : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(10, 23));
		AddStoreItem(STORENAME, "health_mpotion", 3, 0);
		AddStoreItem(STORENAME, "proj_arrow_broadhead", 60, 0, 0, 30);
		string THIS_MAP = StringToLower(GetMapName());
		if (THIS_MAP == "edanasewers")
		{
			AddStoreItem(STORENAME, "item_riddleanswers2", 1, 0);
		}
		if (THIS_MAP == "heras")
		{
			AddStoreItem(STORENAME, "item_riddleanswers", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_iron", 25, 0, 0, 25);
		}
		addrandomitems();
	}

	void addrandomitems()
	{
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_knight", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_jagged", 60, 0, 0, 30);
		}
		if (RandomInt(1, 19) == 1)
		{
			AddStoreItem(STORENAME, "bows_longbow", 1, 0);
		}
	}

}

}
