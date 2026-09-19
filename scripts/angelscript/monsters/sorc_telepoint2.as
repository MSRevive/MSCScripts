#pragma context server

namespace MS
{

class SorcTelepoint2 : CGameScript
{
	int IN_USE;
	int IS_TELE;

	void OnSpawn() override
	{
		SetName("sorc_telepoint2");
		SetFly(true);
		SetGravity(0);
		SetInvincible(true);
		SetRace("beloved");
		IN_USE = 0;
		SetSolid("none");
		IS_TELE = 1;
		SetNoPush(true);
		if (!(StringToLower(GetMapName()) == "shad_palace")) return;
		ScheduleDelayedEvent(2.0, "special_reg");
	}

	void special_reg()
	{
		if (G_RUNE_POINTS == "G_RUNE_POINTS")
		{
			SetGlobalVar("G_RUNE_POINTS", "");
		}
		if (G_RUNE_POINTS.length() > 0) G_RUNE_POINTS += ";";
		G_RUNE_POINTS += GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void tele_used()
	{
		IN_USE = 1;
		ScheduleDelayedEvent(2.0, "tele_reset");
	}

	void tele_reset()
	{
		IN_USE = 0;
	}

}

}
