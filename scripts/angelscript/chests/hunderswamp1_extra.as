#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Hunderswamp1Extra : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_crep", 10);
		ScheduleDelayedEvent(0.1, "chest_sprite_in");
	}

	void chest_sprite_in()
	{
		SetSolid("trigger");
	}

	void chest_additems()
	{
		add_epic_item();
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
	}

}

}
