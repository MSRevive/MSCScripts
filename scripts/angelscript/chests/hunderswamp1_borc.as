#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Hunderswamp1Borc : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "chest_sprite_in");
	}

	void chest_sprite_in()
	{
		SetSolid("trigger");
	}

	void chest_additems()
	{
		add_epic_item();
		add_epic_item();
	}

}

}
