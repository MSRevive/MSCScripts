#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Idemarks1Final : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("armor_rehab", 9);
	}

	void chest_additems()
	{
		add_gold(3000);
		add_epic_item();
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_arrows();
		}
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
			add_epic_pot();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_pot();
		}
	}

}

}
