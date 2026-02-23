#pragma context client

namespace MS
{

class WizardCl : CGameScript
{
	int FOUNTAIN_ACTIVE;
	int FOUNTAIN_MODE;
	string SPRITE_CENTER;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((FOUNTAIN_ACTIVE))
		{
		}
		if (FOUNTAIN_MODE == 1)
		{
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "glow_sprite");
		}
		if (FOUNTAIN_MODE == 2)
		{
			ClientEffect("tempent", "sprite", "glow01.spr", SPRITE_CENTER, "explode_sprite");
			ClientEffect("tempent", "sprite", "glow01.spr", SPRITE_CENTER, "explode_sprite");
			ClientEffect("tempent", "sprite", "glow01.spr", SPRITE_CENTER, "explode_sprite");
		}
	}

	void client_activate()
	{
		SPRITE_CENTER = param1;
		FOUNTAIN_ACTIVE = 1;
		FOUNTAIN_MODE = 1;
	}

	void do_explode()
	{
		FOUNTAIN_MODE = 2;
		ScheduleDelayedEvent(3.0, "remove_script");
	}

	void glow_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-1.1, -1.6));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 128, 128));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
	}

	void explode_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "color", Vector3(255, 255, 255));
	}

	void remove_script()
	{
		RemoveScript();
	}

}

}
