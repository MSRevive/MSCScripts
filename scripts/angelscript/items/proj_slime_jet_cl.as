#pragma context client

namespace MS
{

class ProjSlimeJetCl : CGameScript
{
	string CL_LIGHT_ID;
	int FX_ACTIVE;
	string GLOW_COLOR;
	int GLOW_RAD;
	float MAX_DURATION;
	string MY_OWNER;
	string PASS_SPRITE;
	int ROT_COUNT;
	string SPRITE_SCALE;

	ProjSlimeJetCl()
	{
		GLOW_RAD = 96;
		GLOW_COLOR = Vector3(255, 128, 64);
		MAX_DURATION = 2.0;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		MY_OWNER = param1;
		PASS_SPRITE = param2;
		if ((param4).findFirst(PARAM) == 0)
		{
			SPRITE_SCALE = 0.75;
		}
		else
		{
			SPRITE_SCALE = param4;
		}
		FX_ACTIVE = 1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 0.25);
		CL_LIGHT_ID = "game.script.last_light_id";
		ROT_COUNT = 0;
		fx_loop();
		if ((param3).findFirst("PARAM") == 0)
		{
			MAX_DURATION("end_fx");
		}
		else
		{
			PARAM3("end_fx");
		}
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		string SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		ClientEffect("tempent", "sprite", PASS_SPRITE, SPRITE_POS, "setup_sprite");
	}

	void end_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		string L_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		ClientEffect("light", CL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 0.25);
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
	}

}

}
