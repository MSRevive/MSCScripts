#pragma context client

namespace MS
{

class MummyBileAttackCl : CGameScript
{
	int DO_PUKE;
	string MY_OWNER;

	MummyBileAttackCl()
	{
		const string PUKE_SPRITE = "bloodspray.spr";
		const int PUKE_SPRITE_FRAMES = 10;
		Precache(PUKE_SPRITE);
	}

	void client_activate()
	{
		MY_OWNER = param1;
		DO_PUKE = 1;
		puke_loop();
		ScheduleDelayedEvent(4.0, "end_puke");
	}

	void end_puke()
	{
		DO_PUKE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void puke_loop()
	{
		if (!(DO_PUKE)) return;
		ScheduleDelayedEvent(0.1, "puke_loop");
		ClientEffect("tempent", "sprite", PUKE_SPRITE, /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0"), "setup_puke");
	}

	void setup_puke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", PUKE_SPRITE_FRAMES);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(1.5, 2.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(2, 4));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		string CLOUD_ANG = /* TODO: $getcl */ $getcl(MY_OWNER, "angles.yaw");
		string RND_RL = Random(-10, 10);
		string RND_UD = Random(-220, -180);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(-75, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
