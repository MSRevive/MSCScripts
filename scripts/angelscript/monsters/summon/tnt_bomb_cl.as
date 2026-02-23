#pragma context server

namespace MS
{

class TntBombCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string LIGHT_IDX;

	TntBombCl()
	{
		const int GLOW_RAD = 64;
		const Vector3 GLOW_COLOR = Vector3(255, 64, 0);
	}

	void client_activate()
	{
		LogDebug("*** $currentscript PARAM1 PARAM2");
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		sparks_loop();
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), GLOW_RAD, GLOW_COLOR, FX_DURATION);
		LIGHT_IDX = "game.script.last_light_id";
		SetCallback("render", "enable");
		FX_DURATION("end_fx");
	}

	void sparks_loop()
	{
		if (!(FX_ACTIVE)) return;
		Random(0_1, 0_5)("sparks_loop");
		ClientEffect("spark", FX_OWNER, 0);
	}

	void game_prerender()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("light", LIGHT_IDX, /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), GLOW_RAD, GLOW_COLOR, 1.0);
		}
		else
		{
			ClientEffect("light", LIGHT_IDX, /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), 0, Vector3(0, 0, 0), 1.0);
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
