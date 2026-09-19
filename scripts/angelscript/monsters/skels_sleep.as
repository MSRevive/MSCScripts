#pragma context server

namespace MS
{

class SkelsSleep : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetRace("beloved");
		SetInvincible(true);
		SetName("skels_sleep");
		SetFly(true);
		SetHealth(10);
		PLAYING_DEAD = 1;
	}

	void suicide_me()
	{
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
