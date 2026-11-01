#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Cavechest2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(5, 20));
		AddStoreItem(STORENAME, "sheath_belt", 1, 0);
		AddStoreItem(STORENAME, "smallarms_dagger", 1, 0);
		if (!(RandomInt(1, 3) == 1)) return;
		AddStoreItem(STORENAME, "sheath_spellbook", 1, 0);
	}

}

}
