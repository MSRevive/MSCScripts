#pragma context server

#include "bloodrose/chest_b_base.as"

namespace MS
{

class ChestB3 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "mana_gprotection", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_regen", 1, 0);
		}
	}

}

}
