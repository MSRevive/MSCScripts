#pragma context client

namespace MS
{

class ProjUbCl : CGameScript
{
	string SPRITE_NAME;
	int SPRITE_NFRAMES;

	ProjUbCl()
	{
		SPRITE_NAME = "xflare1.spr";
		SPRITE_NFRAMES = 20;
	}

	void client_activate()
	{
		ClientEffect("tempent", "sprite", SPRITE_NAME, param1, "make_sprite");
		ClientEffect("tempent", "sprite", SPRITE_NAME, param2, "make_sprite");
		EmitSound3D("magic/frost_reverse.wav", 10, param2);
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void make_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
