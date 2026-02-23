#pragma context server

namespace MS
{

class DragonGuardBreathCl : CGameScript
{
	int BREATH_ON;
	string BREATH_TYPE;
	string CLOUD_ANG;
	string FX_OWNER;
	string SPR_EVENT;
	string SPR_NAME;

	DragonGuardBreathCl()
	{
		const float FX_DURATION = 5.0;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		BREATH_TYPE = param2;
		LogDebug("*** breath_activate FX_OWNER BREATH_TYPE");
		FX_DURATION("end_fx");
		if (BREATH_TYPE == "cold")
		{
			SPR_NAME = "rain_mist.spr";
			SPR_EVENT = "setup_cloud_cold";
		}
		if (BREATH_TYPE == "fire")
		{
			SPR_NAME = "explode1.spr";
			SPR_EVENT = "setup_cloud_fire";
		}
		if (BREATH_TYPE == "poison")
		{
			SPR_NAME = "poison_cloud.spr";
			SPR_EVENT = "setup_cloud_poison";
		}
		BREATH_ON = 1;
		breath_loop();
	}

	void end_fx()
	{
		BREATH_ON = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.2, "breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		CLOUD_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		ClientEffect("tempent", "sprite", SPR_NAME, CLOUD_ORG, SPR_EVENT, "update_cloud");
		ClientEffect("tempent", "sprite", SPR_NAME, CLOUD_ORG, SPR_EVENT, "update_cloud");
		ClientEffect("tempent", "sprite", SPR_NAME, CLOUD_ORG, SPR_EVENT, "update_cloud");
	}

	void setup_cloud_cold()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.01);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.01);
		string RND_RL = Random(-20, 20);
		string RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void update_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (CUR_SCALE < 1.5)
		{
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		}
	}

	void setup_cloud_fire()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.2);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		if (RandomInt(1, 3) == 1)
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 0));
		}
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.2);
		string RND_RL = Random(-20, 20);
		string RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void setup_cloud_poison()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		string RND_RL = Random(-20, 20);
		string RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
