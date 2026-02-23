#pragma context client

namespace MS
{

class ProjArrowSpiralCl : CGameScript
{
	string CL_LIGHT_ID;
	int FX_ACTIVE;
	string GLOW_COLOR;
	string MY_OWNER;
	int ROT_COUNT;
	string SPRITE_COLOR;
	string SPRITE_FRAMES;
	string SPRITE_NAME;
	string SPRITE_SCALE;

	ProjArrowSpiralCl()
	{
		const int GLOW_RAD = 256;
		const float MAX_DURATION = 10.0;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		MY_OWNER = param1;
		SPRITE_NAME = param2;
		SPRITE_FRAMES = param3;
		SPRITE_SCALE = param4;
		SPRITE_COLOR = param5;
		GLOW_COLOR = param6;
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
		ROT_COUNT += 10;
		if (ROT_COUNT > 359)
		{
			ROT_COUNT = 0;
		}
		string SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(ROT_COUNT, ROT_COUNT, 0), Vector3(0, 32, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_spiral_sprite");
		string SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(/* TODO: $neg */ $neg(ROT_COUNT), /* TODO: $neg */ $neg(ROT_COUNT), 0), Vector3(0, 32, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_spiral_sprite");
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "isplayer"))) return;
		end_fx();
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
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		ClientEffect("light", CL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 0.25);
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
