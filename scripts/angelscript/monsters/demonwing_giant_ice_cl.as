#pragma context server

namespace MS
{

class DemonwingGiantIceCl : CGameScript
{
	string CLOUD_YAW;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		fire_breath_loop();
		FX_DURATION("end_fx");
	}

	void fire_breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "fire_breath_loop");
		CLOUD_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		ClientEffect("tempent", "sprite", "rain_mist.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_fire_cloud", "update_fire_cloud");
		ClientEffect("tempent", "sprite", "rain_mist.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_fire_cloud", "update_fire_cloud");
		ClientEffect("tempent", "sprite", "rain_mist.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_fire_cloud", "update_fire_cloud");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_fire_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (CUR_SCALE < 2)
		{
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		}
	}

	void setup_fire_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
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
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_YAW, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
