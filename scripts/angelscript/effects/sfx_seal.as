#pragma context client

namespace MS
{

class SfxSeal : CGameScript
{
	string CYCLE_ANGLE;
	string FREQ_SOUND;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_EXTRAS_TYPE;
	string FX_ORIGIN;
	string FX_RAD;
	string NEXT_SOUND;
	int RENDER_AMT;
	string SEAL_OFS;

	SfxSeal()
	{
		const string SEAL_MODEL = "weapons/magic/seals.mdl";
		const string SNOW_SPRITE = "firemagic_8bit.spr";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_RAD = param2;
		SEAL_OFS = param3;
		FX_DURATION = param4;
		FX_EXTRAS_TYPE = param5;
		FX_DURATION("end_fx");
		if (FX_EXTRAS_TYPE != "spider")
		{
			ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal1");
			ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal2");
		}
		else
		{
			ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_spider_seal", "update_spider_seal");
		}
		if (FX_EXTRAS_TYPE == "freeze_solid")
		{
			CYCLE_ANGLE = 0;
			FREQ_SOUND = 1.0;
			EmitSound3D("magic/spawn_loud.wav", 10, FX_ORIGIN);
			ClientEffect("light", "new", FX_ORIGIN, FX_RAD, Vector3(128, 128, 255), FX_DURATION);
			ScheduleDelayedEvent(0.1, "make_snow");
		}
		FX_ACTIVE = 1;
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void make_snow()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "make_snow");
		if (GetGameTime() > NEXT_SOUND)
		{
			NEXT_SOUND = GetGameTime();
			NEXT_SOUND += FREQ_SOUND;
			EmitSound3D("magic/frost_forward.wav", 10, FX_ORIGIN);
		}
		string SPR_POS = FX_ORIGIN;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, FX_RAD, 256));
		ClientEffect("tempent", "sprite", SNOW_SPRITE, SPR_POS, "setup_snow");
		CYCLE_ANGLE += 40;
		if (CYCLE_ANGLE >= 359.99)
		{
			CYCLE_ANGLE = 0;
		}
	}

	void update_spider_seal()
	{
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", RENDER_AMT);
		RENDER_AMT -= 2;
		if (RENDER_AMT < 100)
		{
			if ((FX_ACTIVE))
			{
				RENDER_AMT = 100;
			}
			else
			{
				if (RENDER_AMT < 0)
				{
				}
				RENDER_AMT = 0;
			}
		}
	}

	void ext_spider_pulse()
	{
		RENDER_AMT = 255;
	}

	void setup_spider_seal()
	{
		string L_FX_DURATION = FX_DURATION;
		L_FX_DURATION += 1;
		ClientEffect("tempent", "set_current_prop", "death_delay", L_FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_seal1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_seal2()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void setup_snow()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
	}

}

}
