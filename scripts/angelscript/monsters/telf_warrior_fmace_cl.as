#pragma context client

namespace MS
{

class TelfWarriorFmaceCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string MY_OWNER;
	int ROT_CYCLE;
	int ROT_DISTANCE;

	TelfWarriorFmaceCl()
	{
		const string SPRITE_NAME = "xfireball3.spr";
		const int SPRITE_NFRAMES = 19;
		Precache("xfireball3.spr");
	}

	void client_activate()
	{
		MY_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		ROT_CYCLE = 0;
		ROT_DISTANCE = 0;
		FX_DURATION("end_fx");
		fx_loop();
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 128, Vector3(255, 128, 64), FX_DURATION);
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		ROT_CYCLE += 10;
		if (ROT_CYCLE > 359)
		{
			ROT_CYCLE = 0;
		}
		ROT_DISTANCE += 2;
		if (ROT_DISTANCE > 128)
		{
			ROT_DISTANCE = 0;
		}
		string SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, ROT_CYCLE, 0), Vector3(0, ROT_DISTANCE, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_weapon_sprite");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(6.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_weapon_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
	}

}

}
