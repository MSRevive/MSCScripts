#pragma context client

namespace MS
{

class TelfWarriorBowClNew : CGameScript
{
	string CL_LIGHT_ID;
	int FX_ACTIVE;
	string GLOW_COLOR;
	string MY_ANG;
	string MY_POS;
	string MY_SPEED;
	int ROT_COUNT;
	string SPRITE_COLOR;
	string SPRITE_FRAMES;
	string SPRITE_NAME;
	string SPRITE_SCALE;

	TelfWarriorBowClNew()
	{
		const int GLOW_RAD = 256;
		const float MAX_DURATION = 10.0;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		MY_POS = param1;
		SPRITE_NAME = param2;
		SPRITE_FRAMES = param3;
		SPRITE_SCALE = param4;
		SPRITE_COLOR = param5;
		GLOW_COLOR = param6;
		MY_ANG = param7;
		MY_SPEED = param8;
		LogDebug("**** Dest MY_SPEED");
		ClientEffect("tempent", "sprite", SPRITE_NAME, MY_POS, "setup_tracker_sprite", "update_tracker_sprite", "end_tracker_sprite");
		FX_ACTIVE = 1;
		ClientEffect("light", "new", MY_POS, GLOW_RAD, GLOW_COLOR, 0.25);
		CL_LIGHT_ID = "game.script.last_light_id";
		ROT_COUNT = 0;
		fx_loop();
		MAX_DURATION("end_fx");
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		ROT_COUNT += 10;
		if (ROT_COUNT > 359)
		{
			ROT_COUNT = 0;
		}
		string SPRITE_POS = MY_POS;
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(ROT_COUNT, ROT_COUNT, 0), Vector3(0, 32, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_spiral_sprite");
		string SPRITE_POS = MY_POS;
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(/* TODO: $neg */ $neg(ROT_COUNT), /* TODO: $neg */ $neg(ROT_COUNT), 0), Vector3(0, 32, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_spiral_sprite");
	}

	void end_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		ClientEffect("light", CL_LIGHT_ID, MY_POS, GLOW_RAD, GLOW_COLOR, 0.25);
	}

	void end_tracker_sprite()
	{
		end_fx();
	}

	void update_tracker_sprite()
	{
		MY_POS = "game.tempent.origin";
	}

	void setup_tracker_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		string TRACKER_VEL = /* TODO: $relvel */ $relvel(MY_ANG, Vector3(0, MY_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", TRACKER_VEL);
	}

	void setup_spiral_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_FRAMES);
	}

}

}
