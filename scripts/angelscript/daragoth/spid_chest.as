#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SpidChest : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 25));
		AddStoreItem(STORENAME, "drink_mead", 5, 0);
		AddStoreItem(STORENAME, "health_apple", 5, 0);
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		CallExternal("all", "spider_chest_used");
	}

}

}
