#pragma context server

namespace MS
{

class SfxLightningCage : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	int FX_SPHERE_SIZE;

	void client_activate()
	{
		LogDebug("**** client_activate force_cage_cl PARAM1 PARAM2 PARAM3");
		FX_DURATION = param1;
		FX_ORIGIN = param2;
		FX_ACTIVE = 1;
		FX_SPHERE_SIZE = 1;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "setup_efield", "update_efield");
		FX_DURATION("end_fx");
	}

	void update_efield()
	{
		if ((FX_ACTIVE)) return;
		ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
	}

	void end_fx()
	{
		LogDebug("**** force_cage_cl end_fx");
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_efield()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 63);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SPHERE_SIZE);
	}

}

}
