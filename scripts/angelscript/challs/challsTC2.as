#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Challstc2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(6, 12));
		if ((RandomInt(0, 1)))
		{
			AddStoreItem(STORENAME, "blunt_greatmaul", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana2", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana3", 1, 0);
		}
		AddStoreItem(STORENAME, "proj_bolt_iron", 25, 0, 0, 25);
		if (RandomInt(1, 8) == 1)
		{
			int SCROLL_TOME = RandomInt(1, 2);
			if (SCROLL_TIME == 1)
			{
				AddStoreItem(STORENAME, "scroll2_volcano", 1, 0);
			}
			if (SCROLL_TIME == 2)
			{
				AddStoreItem(STORENAME, "scroll_volcano", 1, 0);
			}
		}
	}

}

}
