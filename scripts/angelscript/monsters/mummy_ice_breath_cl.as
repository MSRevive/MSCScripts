#pragma context client

namespace MS
{

class MummyIceBreathCl : CGameScript
{
	int FX_ACTIVE;
	string MY_OWNER;

	void client_activate()
	{
		MY_OWNER = param1;
		FX_ACTIVE = 1;
		fx_loop();
		PARAM2("fx_end");
	}

	void fx_end()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		ClientEffect("tempent", "sprite", "char_breath.spr", /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0"), "setup_sprite");
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 30);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(1.5, 2.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-1, 1));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		string CLOUD_ANG = /* TODO: $getcl */ $getcl(MY_OWNER, "angles.yaw");
		string RND_RL = Random(-30, 30);
		string RND_SPEED = Random(350, 400);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, RND_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
