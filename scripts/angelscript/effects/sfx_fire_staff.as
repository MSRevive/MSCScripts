#pragma context server

namespace MS
{

class SfxFireStaff : CGameScript
{
	void client_activate()
	{
		string FX_ORIGIN = param1;
		EmitSound3D("magic/dragon_fire.wav", 10, FX_ORIGIN);
		ClientEffect("light", "new", FX_ORIGIN, 128, Vector3(255, 128, 64), 1.5);
		ClientEffect("tempent", "model", "weapons/magic/seals.mdl", FX_ORIGIN, "setup_seal");
		FX_ORIGIN += "z";
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "setup_fire_ring");
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_seal()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.5);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_fire_ring()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.5);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 4.5);
	}

}

}
