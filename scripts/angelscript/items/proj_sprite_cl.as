#pragma context server

namespace MS
{

class ProjSpriteCl : CGameScript
{
	int FX_ACTIVE;
	string FX_ANG;
	string FX_ORIGIN;
	string FX_OWNER;
	string FX_SPRITE;
	string FX_VEL;

	ProjSpriteCl()
	{
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		FX_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		FX_VEL = /* TODO: $getcl */ $getcl(FX_OWNER, "velocity");
		FX_SPRITE = param2;
		FX_ACTIVE = 1;
		ClientEffect("tempent", "sprite", FX_SPRITE, FX_ORIGIN, "setup_proj_sprite", "update_proj_sprite");
	}

	void update_proj_sprite()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"));
			ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $getcl */ $getcl(FX_OWNER, "velocity"));
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(5000, 5000, 5000));
		}
	}

	void proj_landed()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.2, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_proj_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 60.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30.0);
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", FX_ANG);
		ClientEffect("tempent", "set_current_prop", "velocity", FX_VEL);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
