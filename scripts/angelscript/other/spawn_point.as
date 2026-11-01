#pragma context server

namespace MS
{

class SpawnPoint : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(1.0, "set_spawn_point");
		SetFly(true);
		SetGravity(0);
	}

	void set_spawn_point()
	{
		SetGlobalVar("G_RANDOM_SPAWN", 1);
		string MY_LOC = GetEntityOrigin(GetOwner());
		MY_LOC += "z";
		CallExternal(GAME_MASTER, "set_spawn_point", MY_LOC);
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
