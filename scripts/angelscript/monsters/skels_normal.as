#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class SkelsNormal : CGameScript
{
	string ANIM_DEATH;
	string ANIM_IDLE;
	float DEATH_DELAY;

	SkelsNormal()
	{
		DEATH_DELAY = 1.0;
		ANIM_IDLE = "";
		ANIM_DEATH = "";
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		SetFly(true);
		SetHealth(10);
		ScheduleDelayedEvent(0.1, "remove_sleeps");
	}

	void remove_sleeps()
	{
		string SLEEPER_TYPEA = FindEntityByName("skels_sleep");
		string SLEEPER_IDA = GetEntityIndex(SLEEPER_TYPEB);
		CallExternal(SLEEPER_IDA, "suicide_me");
		ScheduleDelayedEvent(0.2, "remove_sleeps2");
	}

	void remove_sleeps2()
	{
		string SLEEPER_TYPEB = FindEntityByName("skels_deep_sleep");
		string SLEEPER_IDB = GetEntityIndex(SLEEPER_TYPEB);
		CallExternal(SLEEPER_IDB, "suicide_me");
		ScheduleDelayedEvent(0.2, "double_remove");
	}

	void double_remove()
	{
		DeleteEntity(SLEEPER_IDA);
		DeleteEntity(SLEEPER_IDB);
	}

}

}
