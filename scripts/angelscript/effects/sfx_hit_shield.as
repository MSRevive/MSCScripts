#pragma context client

namespace MS
{

class SfxHitShield : CGameScript
{
	string FX_COLOR;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_SCALE;
	string FX_SPRITE;
	int FX_SPRITE_FRAMES;
	string FX_YAW;

	SfxHitShield()
	{
		FX_SPRITE = "rain_ripple.spr";
		FX_SPRITE_FRAMES = 15;
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_YAW = param2;
		FX_COLOR = param3;
		FX_SCALE = param4;
		FX_DURATION = param5;
		ClientEffect("tempent", "sprite", FX_SPRITE, FX_ORIGIN, "setup_sprite");
		ClientEffect("tempent", "sprite", FX_SPRITE, FX_ORIGIN, "setup_sprite_negyaw");
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FX_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", FX_SPRITE_FRAMES);
	}

	void setup_sprite_negyaw()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string NEG_YAW = FX_YAW;
		NEG_YAW += 180;
		if (NEG_YAW > 359.99)
		{
			NEG_YAW -= 359.99;
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, NEG_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", FX_SPRITE_FRAMES);
	}

}

}
