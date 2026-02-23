#pragma context server

#include "NPCs/human_guard.as"

namespace MS
{

class Memorialguard : CGameScript
{
	Memorialguard()
	{
		const int NO_CHAT = 1;
	}

	void OnSpawn() override
	{
		SetName("Memorial Guard");
	}

	void helena_raid_end()
	{
		SayText("All clear!");
	}

}

}
