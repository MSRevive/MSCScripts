#pragma context client

namespace MS
{

class SfxCircleOfFire : CGameScript
{
	int CYCLE_ANGLE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_RAD;
	string SEAL_MODEL;
	string SEAL_OFS;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;

	SfxCircleOfFire()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SPRITE_NAME = "Fire2.spr";
		SPRITE_NFRAMES = 8;
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_RAD = param2;
		SEAL_OFS = param3;
		FX_DURATION = param4;
		FX_DURATION("remove_fx");
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal1");
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal2");
		FX_ACTIVE = 1;
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 9; i++)
		{
			make_flames();
		}
	}

	void make_flames()
	{
		string SPRITE_POS = FX_ORIGIN;
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, FX_RAD, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_flame_sprite");
		CYCLE_ANGLE += 40;
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_seal1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_seal2()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_flame_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
