#pragma context server

namespace MS
{

class SorcTelepoint : CGameScript
{
	void OnSpawn() override
	{
		set_point();
		SetGravity(0);
		SetModel("none");
		SetInvincible(true);
		SetRace("beloved");
	}

	void set_point()
	{
		if (!(IsEntityAlive(GAME_MASTER)))
		{
			Random(1_0, 2_0)("set_point");
		}
		if (!(IsEntityAlive(GAME_MASTER))) return;
		CallExternal(GAME_MASTER, "gm_set_sorc_point", GetEntityOrigin(GetOwner()));
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
