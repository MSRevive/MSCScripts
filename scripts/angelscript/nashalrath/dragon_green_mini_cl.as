#pragma context server

namespace MS
{

class DragonGreenMiniCl : CGameScript
{
	string CLOUD_ANG;
	string CLOUD_ORG;
	string FX_ACTIVE;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		if (param2 == "breath")
		{
			FX_ACTIVE = 1;
			breath_loop();
		}
	}

	void breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "breath_loop");
		CLOUD_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		LogDebug("breath_loop CLOUD_ANG");
		CLOUD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud");
		for (int i = 0; i < RandomInt(1, 3); i++)
		{
			spit_rocks();
		}
	}

	void spit_rocks()
	{
		ClientEffect("tempent", "sprite", "rockgibs.mdl", CLOUD_ORG, "setup_rock");
		ClientEffect("tempent", "sprite", "rockgibs.mdl", CLOUD_ORG, "setup_rock");
		ClientEffect("tempent", "sprite", "rockgibs.mdl", CLOUD_ORG, "setup_rock");
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

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		float RND_RL = Random(-10, 10);
		float RND_UD = Random(-420, -280);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(20, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void setup_rock()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.75);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 3.0));
		float RND_RL = Random(-30, 30);
		float RND_UD = Random(-420, -280);
		float RND_PITCH = Random(20.0, 45.0);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(RND_PITCH, CLOUD_ANG, 0), Vector3(RND_RL, 1000, RND_UD));
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", RandomInt(0, 2));
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		float RND_PITCH = Random(0.0, 359.99);
		float RND_YAW = Random(0.0, 359.99);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(RND_PITCH, RND_YAW, 0));
	}

}

}
