#pragma context client

namespace MS
{

class SfxSplodie : CGameScript
{
	string SPLODIE_SOUND;
	string SPLODIE_SPRITE;
	string SPR_COLOR;

	SfxSplodie()
	{
		SPLODIE_SPRITE = "bigsmoke.spr";
		SPLODIE_SOUND = "weapons/explode3.wav";
	}

	void client_activate()
	{
		string L_POS = param1;
		SPR_COLOR = param2;
		ClientEffect("tempent", "sprite", SPLODIE_SPRITE, L_POS, "setup_smoke");
		EmitSound3D(SPLODIE_SOUND, 10, L_POS);
		ScheduleDelayedEvent(2.1, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

	void setup_smoke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "color");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPR_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
