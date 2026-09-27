#pragma context server

namespace MS
{

class Teleport : CGameScript
{
	void OnSpawn() override
	{
		SetName("slithar_lure");
		SetModel("null.mdl");
		SetInvincible(true);
		SetRace("beloved");
		SetFly(true);
		1 = float(1);
		SetGravity(0);
		ScheduleDelayedEvent(0.1, "lure_slithar");
	}

	void lure_slithar()
	{
		string SLITHAR_ID = FindEntityByName("snake_lord");
		CallExternal(SLITHAR_ID, "slithar_escape");
	}

}

}
