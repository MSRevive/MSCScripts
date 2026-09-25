#pragma context server

namespace MS
{

class LightningStrikeCl : CGameScript
{
	int FX_ACTIVE;
	string FX_GROUND;
	string FX_ORIGIN;
	string FX_STRIKE_TIME;
	int GLOW_SIZE;
	string LIGHT_ID;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_STRIKE_TIME = param2;
		FX_GROUND = FX_ORIGIN;
		FX_GROUND = "z";
		FX_STRIKE_TIME("do_strike");
		if (!(FX_STRIKE_TIME > 0)) return;
		GLOW_SIZE = 1;
		ClientEffect("light", "new", FX_GROUND, 1, Vector3(255, 255, 0), 5.0);
		LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
		EmitSound3D("magic/bolt_start.wav", 10, FX_GROUND);
		FX_ACTIVE = 1;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_glow_sprite", "update_glow_sprite");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (GLOW_SIZE < 255)
		{
			GLOW_SIZE += 1;
		}
		ClientEffect("light", LIGHT_ID, FX_GROUND, GLOW_SIZE, Vector3(255, 255, 0), 1.0);
	}

	void do_strike()
	{
		ClientEffect("beam_points", FX_ORIGIN, FX_GROUND, "lgtning.spr", 2.0, 30, 1, 0.8, 0.5, 30, Vector3(255, 255, 0));
		SetSoundVolume(5);
		EmitSound(GetOwner(), 5, "weather/Storm_exclamation.wav", 10);
		ScheduleDelayedEvent(3.0, "remove_fx");
		if (!(FX_STRIKE_TIME > 0)) return;
		EmitSound3D("weather/lightning.wav", 10, FX_GROUND);
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_spit_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_spit_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_spit_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_spit_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_GROUND, "setup_spit_sprite");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_glow_sprite()
	{
		if (!(FX_ACTIVE)) return;
		string CUR_SCALE = "game.tempent.fuser1";
		if (!(CUR_SCALE < 6)) return;
		CUR_SCALE += 0.01;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

	void setup_glow_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 128);
	}

	void setup_spit_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		float RND_ANG = Random(0, 359.99);
		float RND_VEL = Random(100, 200);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_VEL, RND_VEL)));
	}

}

}
