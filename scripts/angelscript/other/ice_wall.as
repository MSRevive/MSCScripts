#pragma context server

namespace MS
{

class IceWall : CGameScript
{
	int IS_ACTIVE;
	int ROT_COUNT;

	void OnSpawn() override
	{
		SetInvincible(true);
	}

	void activate_wall()
	{
		LogDebug("activate_wall GetEntityOrigin(param1)");
		SetEntityOrigin(GetOwner(), GetEntityOrigin(param1));
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		if ((IS_ACTIVE)) return;
		ROT_COUNT = 0;
		IS_ACTIVE = 1;
		spin_loop();
	}

	void spin_loop()
	{
		if (!(IS_ACTIVE)) return;
		ROT_COUNT += 1;
		if (ROT_COUNT > 359)
		{
			ROT_COUNT = 0;
		}
		SetAngles("face");
		ScheduleDelayedEvent(0.1, "spin_loop");
	}

	void deactivate_wall()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "hide_wall");
	}

	void hide_wall()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
	}

}

}
