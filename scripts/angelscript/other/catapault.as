#pragma context server

namespace MS
{

class Catapault : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("catapault");
		SetFly(true);
		SetGravity(0);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("orc");
		SetWidth(1);
		SetHeight(1);
		PLAYING_DEAD = 1;
		SetIdleAnim("none");
		SetMoveAnim("none");
	}

	void OneBall()
	{
		Catapaults(1);
	}

	void FiveBalls()
	{
		Catapaults(5);
	}

	void Catapaults()
	{
		for (int i = 0; i < param1; i++)
		{
			FireCatapault();
		}
		CallExternal("all", "CatapaultsIncoming");
	}

	void FireCatapault()
	{
		ScheduleDelayedEvent(Random(0.0, 1.5), "CatapaultShoot");
	}

	void CatapaultShoot()
	{
		if ((StringToLower(GetMapName())).findFirst("helena") >= 0)
		{
			CallExternal("all", "catapults_fire");
			SetAngles("view");
		}
		else
		{
			SetAngles("view");
		}
		TossProjectile("proj_catapaultball", /* TODO: $relpos */ $relpos("z", "x", "y"), "none", 1000, 1000, 30, "none");
	}

}

}
