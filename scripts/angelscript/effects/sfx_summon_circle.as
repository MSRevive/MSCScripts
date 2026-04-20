#pragma context client

namespace MS
{

class SfxSummonCircle : CGameScript
{
	string FX_ORIGIN;
	string SEAL_MODEL;
	string SEAL_OFS;

	SfxSummonCircle()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		SEAL_OFS = param2;
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal");
		EmitSound3D("magic/spawn_loud.wav", 10, FX_ORIGIN);
		ScheduleDelayedEvent(4.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_seal()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

}

}
