#pragma context server

namespace MS
{

class BaseStormBrush : CGameScript
{
	int BASE_RENDERAMT;
	int BASE_RENDERMODE;
	int RND_AMT;

	BaseStormBrush()
	{
		BASE_RENDERAMT = 255;
		BASE_RENDERMODE = 5;
	}

	void OnSpawn() override
	{
		SetProp(GetOwner(), "rendermode", BASE_RENDERMODE);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void storm_show()
	{
		SetProp(GetOwner(), "rendermode", BASE_RENDERMODE);
		SetProp(GetOwner(), "renderamt", BASE_RENDERAMT);
	}

	void storm_hide()
	{
		SetProp(GetOwner(), "rendermode", BASE_RENDERMODE);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void storm_change_speed()
	{
		SetProp(GetOwner(), "avelocity", Vector3(0, param1, 0));
	}

	void storm_fade_in()
	{
		RND_AMT = 0;
		storm_fade_in_loop();
	}

	void storm_fade_in_loop()
	{
		if (!(RND_AMT < BASE_RENDERAMT)) return;
		RND_AMT += 4;
		if (RND_AMT > BASE_RENDERAMT)
		{
			RND_AMT = BASE_RENDERAMT;
		}
		SetProp(GetOwner(), "rendermode", BASE_RENDERMODE);
		SetProp(GetOwner(), "renderamt", RND_AMT);
		if (!(RND_AMT < BASE_RENDERAMT)) return;
		ScheduleDelayedEvent(0.1, "storm_fade_in_loop");
	}

	void storm_fade_out()
	{
		RND_AMT = BASE_RENDERAMT;
		storm_fade_out_loop();
	}

	void storm_fade_out_loop()
	{
		if (!(RND_AMT > 0)) return;
		RND_AMT -= 4;
		if (RND_AMT < 0)
		{
			RND_AMT = 0;
		}
		SetProp(GetOwner(), "rendermode", BASE_RENDERMODE);
		SetProp(GetOwner(), "renderamt", RND_AMT);
		if (!(RND_AMT > 0)) return;
		ScheduleDelayedEvent(0.1, "storm_fade_out_loop");
	}

}

}
