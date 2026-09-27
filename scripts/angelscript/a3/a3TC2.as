#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class A3tc2 : CGameScript
{
	void chest_additems()
	{
		add_gold(RandomInt(17, 30));
		AddStoreItem(STORENAME, "axes_axe", 1, 0);
		AddStoreItem(STORENAME, "health_lpotion", 1, 0);
		int L_ARROW_QUANT = 30;
		L_ARROW_QUANT *= RandomInt(1, 2);
		AddStoreItem(STORENAME, "proj_arrow_silvertipped", L_ARROW_QUANT, 0, 0, 30);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			add_noob_item();
		}
	}

}

}
