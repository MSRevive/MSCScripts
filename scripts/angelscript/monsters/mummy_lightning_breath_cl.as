#pragma context client

namespace MS
{

class MummyLightningBreathCl : CGameScript
{
	int BEAM_ON;
	string FX_DURATION;
	string MY_OWNER;

	void client_activate()
	{
		MY_OWNER = param1;
		FX_DURATION = param2;
		BEAM_ON = 1;
		beam_loop();
		FX_DURATION("end_fx");
	}

	void beam_loop()
	{
		if (!(BEAM_ON)) return;
		ScheduleDelayedEvent(0.01, "beam_loop");
		string SPARK_ORG = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPARK_ORG, "ke_spit_sparks");
		string BEAM_START = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		string BEAM_END = BEAM_START;
		string BEAM_ANG = /* TODO: $getcl */ $getcl(MY_OWNER, "angles.yaw");
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BEAM_ANG, 0), Vector3(Random(-32, 32), 400, Random(-100, 100)));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 2, 0.1, 0.3, 0.1, 30, Vector3(2, 1.5, 0.25));
	}

	void end_fx()
	{
		BEAM_ON = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void ke_spit_sparks()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.1, 0.75));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 128));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(1.0, 3.0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		string CLOUD_ANG = /* TODO: $getcl */ $getcl(MY_OWNER, "angles.yaw");
		string RND_RL = Random(-100, 100);
		string RND_UD = Random(-220, -180);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(-75, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
