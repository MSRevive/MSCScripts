#pragma context client

namespace MS
{

class ProjFlameJetCl : CGameScript
{
	string CL_LIGHT_ID;
	int FX_ACTIVE;
	string MY_OWNER;
	string PASS_SPRITE;
	int ROT_COUNT;

	ProjFlameJetCl()
	{
		const int GLOW_RAD = 96;
		const Vector3 GLOW_COLOR = Vector3(255, 128, 64);
		const float MAX_DURATION = 10.0;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		MY_OWNER = param1;
		PASS_SPRITE = param2;
		FX_ACTIVE = 1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 0.25);
		CL_LIGHT_ID = "game.script.last_light_id";
		ROT_COUNT = 0;
		fx_loop();
		MAX_DURATION("end_fx");
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
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
	}

}

}
