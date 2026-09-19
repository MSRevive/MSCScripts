#pragma context server

namespace MS
{

class BluntStaffICl : CGameScript
{
	int FX_ACTIVE;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		fx_loop();
		ScheduleDelayedEvent(20.0, "end_fx");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPR_POS = "z";
		ClientEffect("decal", 16, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), SPR_POS);
	}

	void end_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(5.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "fx_loop");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPR_POS = "z";
		SPR_POS += "x";
		SPR_POS += "y";
		ClientEffect("decal", 17, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), SPR_POS);
	}

	void update_ice_sprite()
	{
		string L_FIX_FRAME = "game.tempent.fuser1";
		ClientEffect("tempent", "set_current_prop", "frame", L_FIX_FRAME);
	}

	void setup_ice_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(200, 200, 255));
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "frame", FIX_FRAME);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "fuser1", FIX_FRAME);
	}

}

}
