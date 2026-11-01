#pragma context client

namespace MS
{

class CircleOfDeathCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_SPRITE;
	string GLOW_COLOR;
	int GLOW_RAD;
	string SEAL_MODEL;
	int SEAL_OFS;

	CircleOfDeathCl()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SEAL_OFS = 4;
		FX_SPRITE = "skull.spr";
		GLOW_COLOR = Vector3(255, 0, 0);
		GLOW_RAD = 196;
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		FX_DURATION("end_fx");
		ClientEffect("light", "new", FX_ORIGIN, GLOW_RAD, GLOW_COLOR, FX_DURATION);
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal");
		fx_loop();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "fx_loop");
		string SKULL_ORIGIN = FX_ORIGIN;
		SKULL_ORIGIN += "z";
		ClientEffect("tempent", "sprite", FX_SPRITE, SKULL_ORIGIN, "setup_skull");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_seal()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 15);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
	}

	void setup_skull()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 15);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -1));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
	}

}

}
