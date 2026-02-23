#pragma context server

namespace MS
{

class SfxCod : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	string GLOW_RAD;
	string MODEL_OFS;
	string SND_CHAN;

	SfxCod()
	{
		const string SEAL_MODEL = "weapons/magic/seals.mdl";
		const Vector3 GLOW_COLOR = Vector3(255, 0, 0);
		const string SEAL_SOUND = "ambience/pulsemachine.wav";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_DURATION = param2;
		MODEL_OFS = param3;
		FX_ACTIVE = 1;
		GLOW_RAD = param4;
		SND_CHAN = param5;
		LogDebug("cod_soundchan SND_CHAN");
		FX_DURATION("end_fx");
		ClientEffect("light", "new", FX_ORIGIN, GLOW_RAD, GLOW_COLOR, FX_DURATION);
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_seal()
	{
		string L_FX_DURATION = FX_DURATION;
		L_FX_DURATION *= 2.0;
		ClientEffect("tempent", "set_current_prop", "death_delay", L_FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", MODEL_OFS);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
