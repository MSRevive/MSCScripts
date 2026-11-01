#pragma context client

namespace MS
{

class SfxStunring : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string OWNER_HEIGHT;
	int TILT_AMT;
	string TILT_DIR;

	SfxStunring()
	{
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		OWNER_HEIGHT = param3;
		OWNER_HEIGHT -= 16;
		FX_ACTIVE = 1;
		OWNER_HEIGHT += 15;
		if ((/* TODO: $getcl */ $getcl(FX_OWNER, "isplayer")))
		{
			OWNER_HEIGHT -= 35;
		}
		TILT_AMT = 0;
		string OWNER_HEAD = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		OWNER_HEAD += "z";
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", OWNER_HEAD, "setup_stun_ring", "update_stun_ring");
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_stun_ring()
	{
		string OWNER_HEAD = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		OWNER_HEAD += "z";
		ClientEffect("tempent", "set_current_prop", "origin", OWNER_HEAD);
		if (TILT_DIR == 1)
		{
			TILT_AMT += 0.1;
		}
		else
		{
			TILT_AMT -= 0.1;
		}
		if (TILT_AMT > 10)
		{
			TILT_DIR = 0;
		}
		if (TILT_AMT < -10)
		{
			TILT_DIR = 1;
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(TILT_AMT, 0, /* TODO: $neg */ $neg(TILT_AMT)));
	}

	void setup_stun_ring()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 53);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		string FADE_DELAY = FX_DURATION;
		FADE_DELAY *= 0.5;
		FADE_DELAY += FX_DURATION;
		ClientEffect("tempent", "set_current_prop", "fadeout", FADE_DELAY);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
