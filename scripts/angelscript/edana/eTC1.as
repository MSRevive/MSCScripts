#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Etc1 : CGameScript
{
	int HAVE_LETTER;

	void OnSpawn() override
	{
		SetName("mayor_chest");
	}

	void chest_additems()
	{
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "smallarms_knife", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "health_mpotion", 1, 0);
		}
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "health_apple", 1, 0);
		}
		add_gold(RandomInt(1, 5));
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "armor_leather_torn", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_broadhead", 30, 0, 0, 15);
		}
		if ((HAVE_LETTER)) return;
		HAVE_LETTER = 1;
		AddStoreItem(STORENAME, "item_letter_mayor", 1, 0);
	}

}

}
