#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class HelenaFear : CGameScript
{
	HelenaFear()
	{
		const float DEATH_DELAY = 5.0;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.5, "make_fear");
	}

	void make_fear()
	{
		CallExternal("all", "orc_raid");
	}

}

}
