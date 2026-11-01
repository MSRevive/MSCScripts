#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Ww3d : CGameScript
{
	void OnSpawn() override
	{
		SetName("geric_chest");
		tc_add_artifact("armor_dark", 100);
	}

	void chest_additems()
	{
		add_gold(300);
		offer_felewyn_symbol(10);
		if ((RandomInt(0, 1)))
		{
			add_epic_item();
		}
	}

}

}
