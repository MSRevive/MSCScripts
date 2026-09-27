#pragma context server

namespace MS
{

class SfxCloud : CGameScript
{
	int FX_ACTIVE;
	string FX_CENTER;
	string FX_COLOR;
	string FX_DURATION;
	string FX_RADIUS;
	string FX_SPRITE;
	string SOUND_SPAWN;

	SfxCloud()
	{
		SOUND_SPAWN = "ambience/steamburst1.wav";
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_DURATION = param2;
		FX_RADIUS = param3;
		FX_COLOR = param4;
		FX_SPRITE = param5;
		if ((FX_SPRITE).findFirst(PARAM) == 0)
		{
			FX_SPRITE = "poison_cloud.spr";
		}
		if ((FX_COLOR).findFirst(PARAM) == 0)
		{
			FX_COLOR = Vector3(0, 255, 0);
		}
		string L_FX_RADIUS = FX_RADIUS;
		ClientEffect("light", "new", FX_CENTER, L_FX_RADIUS, FX_COLOR, FX_DURATION);
		FX_ACTIVE = 1;
		FX_DURATION("end_fx");
		smokes_loop();
		EmitSound3D(SOUND_SPAWN, 10, FX_CENTER);
	}

	void smokes_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "smokes_loop");
		string SPRITE_POS = FX_CENTER;
		float RND_ANG = Random(0, 359.99);
		string NEG_RAD = /* TODO: $neg */ $neg(FX_RADIUS);
		float RND_OFS = Random(NEG_RAD, FX_RADIUS);
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_OFS, 0));
		ClientEffect("tempent", "sprite", FX_SPRITE, SPRITE_POS, "setup_smoke");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(3.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_smoke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.005);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
