#pragma context client

namespace MS
{

class SfxShockBurst : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	string FX_RADIUS;
	string SEAL_MODEL;
	string SOUND_BURST;

	SfxShockBurst()
	{
		SOUND_BURST = "magic/lightning_strike2.wav";
		SEAL_MODEL = "weapons/magic/seals.mdl";
		Precache(SEAL_MODEL);
		Precache(SOUND_BURST);
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		string DO_GLOW = param3;
		string GLOW_COLOR = param4;
		if ((DO_GLOW))
		{
			ClientEffect("light", "new", FX_CENTER, FX_RADIUS, GLOW_COLOR, 1.0);
		}
		ScheduleDelayedEvent(2.0, "remove_me");
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_beams();
		}
		ClientEffect("tempent", "model", SEAL_MODEL, FX_CENTER, "setup_seal");
		EmitSound3D(SOUND_BURST, 10, FX_CENTER);
	}

	void remove_me()
	{
		RemoveScript();
	}

	void create_beams()
	{
		string CL_BEAM_START = FX_CENTER;
		string BEAM_RAD = FX_RADIUS;
		BEAM_RAD *= 0.6;
		CL_BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, BEAM_RAD, 0));
		string CL_BEAM_END = CL_BEAM_START;
		CL_BEAM_END += "z";
		ClientEffect("beam_points", CL_BEAM_START, CL_BEAM_END, "lgtning.spr", 1.0, 5.0, 3.0, 200, 50, 30, Vector3(1.0, 1.0, 0.0));
		CYCLE_ANGLE += 20;
	}

	void setup_seal()
	{
		int MODEL_BODY = 28;
		if (FX_RADIUS > 128)
		{
			int MODEL_BODY = 29;
		}
		if (FX_RADIUS <= 64)
		{
			int MODEL_BODY = 27;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "body", MODEL_BODY);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
	}

}

}
