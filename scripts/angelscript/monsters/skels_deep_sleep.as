#pragma context server

namespace MS
{

class SkelsDeepSleep : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetRace("beloved");
		SetInvincible(true);
		SetName("skels_deep_sleep");
		SetFly(true);
		SetHealth(10);
		PLAYING_DEAD = 1;
		LogDebug("Deep Sleep Spawned - skeletons will not awake until monsters/skels_wakeup is spawned");
	}

	void suicide_me()
	{
		LogDebug("skels_deep_sleep got order to suicide");
		SetRace("hated");
		SetInvincible(false);
		SetAlive(0);
		ScheduleDelayedEvent(0.2, "suicide_me2");
	}

	void suicide_me2()
	{
		DeleteEntity(GetOwner());
	}

}

}
