#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Islesofdread1 : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_paura", 5);
	}

	void chest_additems()
	{
		add_gold(1000);
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_good_item();
		}
	}

}

}
