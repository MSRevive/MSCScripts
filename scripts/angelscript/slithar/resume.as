#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class Resume : CGameScript
{
	int PLAYING_DEAD;

	Resume()
	{
		const float DEATH_DELAY = 10.0;
		PLAYING_DEAD = 1;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "send_resume");
	}

	void send_resume()
	{
		string SLITHAR_ID = FindEntityByName("snake_lord");
		CallExternal(SLITHAR_ID, "slithar_resume");
	}

}

}
