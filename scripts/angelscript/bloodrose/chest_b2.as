#pragma context server

#include "bloodrose/chest_b_base.as"

namespace MS
{

class ChestB2 : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
	}

}

}
