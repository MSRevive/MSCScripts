#pragma context server

namespace MS
{

class DwarfBomberCl : CGameScript
{
	string FX_ACTIVATE_TIME;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_LACTIVE;
	string FX_OWNER;
	string FX_RACTIVE;
	string LIGHT_LHAND;
	string LIGHT_RHAND;

	DwarfBomberCl()
	{
		const string RHAND_IDX = "attachment0";
		const string LHAND_IDX = "attachment1";
		const int GLOW_RAD = 64;
		const Vector3 GLOW_COLOR = Vector3(255, 64, 0);
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		FX_ACTIVATE_TIME = GetGameTime();
		FX_RACTIVE = param3;
		FX_LACTIVE = param4;
		set_hands(FX_RACTIVE, FX_LACTIVE);
		sparks_loop();
		SetCallback("render", "enable");
		FX_DURATION("end_fx");
	}

	void sparks_loop()
	{
		if (!(FX_ACTIVE)) return;
		Random(0_1, 0_5)("sparks_loop");
		if ((FX_RACTIVE))
		{
			ClientEffect("spark", FX_OWNER, 0);
		}
		if ((FX_LACTIVE))
		{
			ClientEffect("spark", FX_OWNER, 1);
		}
	}

	void game_prerender()
	{
		if ((FX_ACTIVE))
		{
			if ((FX_RACTIVE))
			{
				ClientEffect("light", LIGHT_RHAND, /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_IDX), GLOW_RAD, GLOW_COLOR, 1.0);
			}
			else
			{
				if (LIGHT_RHAND > 0)
				{
				}
				ClientEffect("light", LIGHT_RHAND, /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_IDX), 0, Vector3(0, 0, 0), 1.0);
				LIGHT_RHAND = -1;
			}
			if ((FX_LACTIVE))
			{
				ClientEffect("light", LIGHT_LHAND, /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_IDX), GLOW_RAD, GLOW_COLOR, 1.0);
			}
			else
			{
				if (LIGHT_LHAND > 0)
				{
				}
				ClientEffect("light", LIGHT_LHAND, /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_IDX), 0, Vector3(0, 0, 0), 1.0);
				LIGHT_LHAND = -1;
			}
		}
		else
		{
			if (LIGHT_RHAND > 0)
			{
				ClientEffect("light", LIGHT_RHAND, /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_IDX), 0, Vector3(0, 0, 0), 1.0);
				LIGHT_RHAND = -1;
			}
			if (LIGHT_LHAND > 0)
			{
				ClientEffect("light", LIGHT_LHAND, /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_IDX), 0, Vector3(0, 0, 0), 1.0);
				LIGHT_LHAND = -1;
			}
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

	void set_hands()
	{
		FX_RACTIVE = param1;
		FX_LACTIVE = param2;
		if ((FX_RACTIVE))
		{
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_IDX), GLOW_RAD, GLOW_COLOR, FX_DURATION);
			LIGHT_RHAND = "game.script.last_light_id";
		}
		if ((FX_LACTIVE))
		{
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_IDX), GLOW_RAD, GLOW_COLOR, FX_DURATION);
			LIGHT_LHAND = "game.script.last_light_id";
		}
	}

}

}
