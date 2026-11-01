#pragma context server

namespace MS
{

class SwampTubeCl : CGameScript
{
	string FX_OWNER;
	string NEEDLE_ANGS;

	void client_activate()
	{
		FX_OWNER = param1;
		string NEEDLE_START_POS = /* TODO: $getcl */ $getcl(param1, "attachment0");
		NEEDLE_ANGS = param2;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", NEEDLE_START_POS, "setup_needle", "do_nadda", "needle_collide");
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_nadda()
	{
	}

	void needle_collide()
	{
		EmitSound3D("weapons/bow/arrowhit1.wav", 10, "game.tempent.origin");
	}

	void setup_needle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string L_NEEDLE_ANGS = NEEDLE_ANGS;
		ClientEffect("tempent", "set_current_prop", "angles", L_NEEDLE_ANGS);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(NEEDLE_ANGS, Vector3(0, 1000, 0)));
		ClientEffect("tempent", "set_current_prop", "body", 26);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

}

}
