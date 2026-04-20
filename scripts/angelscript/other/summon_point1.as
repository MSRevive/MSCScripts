#pragma context server

namespace MS
{

class SummonPoint1 : CGameScript
{
	int IN_USE;
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("summon_point1");
		SetFly(true);
		SetGravity(0);
		SetInvincible(true);
		SetRace("beloved");
		IN_USE = 0;
		SetSolid("none");
		SetNoPush(true);
		PLAYING_DEAD = 1;
	}

	void summon_used()
	{
		IN_USE = 1;
		ScheduleDelayedEvent(2.0, "summon_reset");
	}

	void summon_reset()
	{
		IN_USE = 0;
	}

}

}
