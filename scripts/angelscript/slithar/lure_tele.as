#pragma context server

namespace MS
{

class LureTele : CGameScript
{
	int MADE_IT;

	void OnSpawn() override
	{
		SetModel("null.mdl");
		SetSolid("none");
		SetInvincible(true);
		SetRace("beloved");
		ScheduleDelayedEvent(0.1, "slithar_run_loop");
		ScheduleDelayedEvent(10.0, "slithar_cant_make_it");
	}

	void slithar_run_loop()
	{
		if ((MADE_IT)) return;
		ScheduleDelayedEvent(0.5, "slithar_run_loop");
		string SLITHAR_ID = FindEntityByName("snake_lord");
		string SLITHAR_RANGE = GetEntityRange(SLITHAR_ID);
		string MY_POS = GetMonsterProperty("origin");
		string MY_ID = GetEntityIndex(GetOwner());
		if ((MADE_IT)) return;
		CallExternal(SLITHAR_ID, "slithar_to_me", MY_POS, SLITHAR_RANGE, MY_ID);
	}

	void slithar_made_it()
	{
		MADE_IT = 1;
		SetAlive(0);
		DeleteEntity(GetOwner());
	}

	void slithar_cant_make_it()
	{
		if ((MADE_IT)) return;
		MADE_IT = 1;
		tele_slithar();
	}

	void tele_slithar()
	{
		SetName("slithar_lure");
		string SLITHAR_NAME = FindEntityByName("snake_lord");
		string SLITHAR_ID = GetEntityIndex(SLITHAR_NAME);
		CallExternal(SLITHAR_ID, "slithar_escape");
	}

}

}
