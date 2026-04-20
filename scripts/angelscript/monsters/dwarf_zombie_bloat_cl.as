#pragma context client

namespace MS
{

class DwarfZombieBloatCl : CGameScript
{
	string CLOUD_ANG;
	int DO_PUKE;
	string MY_OWNER;
	string PUKE_SPRITE;
	int PUKE_SPRITE_FRAMES;

	DwarfZombieBloatCl()
	{
		PUKE_SPRITE = "bloodspray.spr";
		PUKE_SPRITE_FRAMES = 10;
		Precache(PUKE_SPRITE);
	}

	void client_activate()
	{
		MY_OWNER = param1;
		DO_PUKE = 1;
		puke_loop();
		ScheduleDelayedEvent(15.0, "end_puke");
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
		string OWNER_HEAD = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		string OWNER_PUKE = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		CLOUD_ANG = /* TODO: $angles */ $angles(OWNER_HEAD, OWNER_PUKE);
		CLOUD_ANG = /* TODO: $vec.yaw */ $vec.yaw(CLOUD_ANG);
		ClientEffect("tempent", "sprite", PUKE_SPRITE, /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0"), "setup_puke", "update_puke");
	}

	void update_puke()
	{
		string L_CUR_SCALE = "game.tempent.fuser1";
		L_CUR_SCALE += 0.1;
		ClientEffect("tempent", "set_current_prop", "scale", L_CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", L_CUR_SCALE);
	}

	void setup_puke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", PUKE_SPRITE_FRAMES);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		float L_START_SCALE = Random(0.25, 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", L_START_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(2, 4));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "fuser1", L_START_SCALE);
		float RND_RL = Random(-10, 10);
		float RND_UD = Random(-220, -180);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(-75, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
