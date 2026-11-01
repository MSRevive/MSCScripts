#pragma context server

namespace MS
{

class BatLargeCorpseCl : CGameScript
{
	string USE_SKIN;

	void client_activate()
	{
		USE_SKIN = param2;
		string FX_ORIGIN = param1;
		ClientEffect("tempent", "model", "monsters/bat_large.mdl", FX_ORIGIN, "setup_corpse");
		ScheduleDelayedEvent(7.0, "remove_script");
	}

	void remove_script()
	{
		RemoveScript();
	}

	void setup_corpse()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.1);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "skin", USE_SKIN);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
	}

}

}
