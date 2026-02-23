#pragma context client

namespace MS
{

class ReaversCl : CGameScript
{
	int BREATH_ACTIVE;
	string BREATH_TYPE;
	string CLOUD_ANG;
	string DOING_BREATH;
	string DOING_ERRUPT;
	int ERRUPT_ACTIVE;
	string ERRUPT_CUR_ANG;
	int ERRUPT_CUR_START_ANG;
	string ERRUPT_TYPE;
	int FX_ACTIVE;
	string FX_OWNER;

	ReaversCl()
	{
		const string PUKE_SPRITE = "bloodspray.spr";
		const int PUKE_SPRITE_FRAMES = 10;
		Precache(PUKE_SPRITE);
	}

	void client_activate()
	{
		FX_OWNER = param1;
		BREATH_TYPE = param2;
		ERRUPT_TYPE = param3;
		DOING_ERRUPT = param4;
		DOING_BREATH = param5;
		FX_ACTIVE = 1;
		if ((DOING_ERRUPT))
		{
			errupt_on(ERRUPT_TYPE);
		}
		if ((DOING_BREATH))
		{
			breath_on(BREATH_TYPE);
		}
		ScheduleDelayedEvent(30.0, "end_fx");
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

	void errupt_on()
	{
		if (!(FX_ACTIVE)) return;
		ERRUPT_TYPE = param1;
		ERRUPT_ACTIVE = 1;
		ERRUPT_CUR_START_ANG = 0;
		errupt_loop();
	}

	void errupt_off()
	{
		ERRUPT_ACTIVE = 0;
	}

	void errupt_loop()
	{
		if (!(FX_ACTIVE)) return;
		if (!(ERRUPT_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "errupt_loop");
		if (ERRUPT_TYPE == "poison")
		{
			ERRUPT_CUR_ANG = ERRUPT_CUR_START_ANG;
			for (int i = 0; i < 9; i++)
			{
				errupt_setup_puke();
			}
		}
		else
		{
			ERRUPT_CUR_ANG = ERRUPT_CUR_START_ANG;
			for (int i = 0; i < 9; i++)
			{
				errupt_setup_fire();
			}
		}
		ERRUPT_CUR_START_ANG += 1;
		if (ERRUPT_CUR_START_ANG > 40)
		{
			ERRUPT_CUR_START_ANG = 0;
		}
	}

	void errupt_setup_puke()
	{
		ClientEffect("tempent", "sprite", PUKE_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_puke", "update_puke");
		ERRUPT_CUR_ANG += 40;
		if (ERRUPT_CUR_ANG > 359)
		{
			ERRUPT_CUR_ANG -= 359;
		}
	}

	void errupt_setup_fire()
	{
		ClientEffect("tempent", "sprite", "xfireball3.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_fire");
		ERRUPT_CUR_ANG += 40;
		if (ERRUPT_CUR_ANG > 359)
		{
			ERRUPT_CUR_ANG -= 359;
		}
	}

	void update_puke()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		if (!(CUR_SIZE < 4.0)) return;
		CUR_SIZE += 0.05;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
	}

	void setup_puke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", PUKE_SPRITE_FRAMES);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(1.5, 2.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(3.0, 5.0));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, ERRUPT_CUR_ANG, 0), Vector3(0, 400, 300));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void setup_fire()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.25));
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 96, 64));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(3.0, 4.0));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, ERRUPT_CUR_ANG, 0), Vector3(0, 400, 300));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void breath_on()
	{
		if (!(FX_ACTIVE)) return;
		BREATH_TYPE = param1;
		BREATH_ACTIVE = 1;
		breath_loop();
	}

	void breath_off()
	{
		BREATH_ACTIVE = 0;
	}

	void breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		if (!(BREATH_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "breath_loop");
		make_cloud(/* TODO: $getcl */ $getcl(FX_OWNER, "attachment1"), /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw"));
	}

	void make_cloud()
	{
		string CLOUD_ORG = param1;
		CLOUD_ANG = param2;
		if (BREATH_TYPE == "poison")
		{
			ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
			ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
			ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
		}
		else
		{
			ClientEffect("tempent", "sprite", "explode1.spr", CLOUD_ORG, "setup_fire_cloud", "update_cloud");
			ClientEffect("tempent", "sprite", "explode1.spr", CLOUD_ORG, "setup_fire_cloud", "update_cloud");
			ClientEffect("tempent", "sprite", "explode1.spr", CLOUD_ORG, "setup_fire_cloud", "update_cloud");
		}
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

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", RandomInt(100, 200));
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 128, 64));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		string RND_RL = Random(-10, 10);
		string RND_UD = Random(-30, 30);
		string RND_FD = Random(300, 400);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, RND_FD, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void setup_fire_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		if (RandomInt(1, 3) == 1)
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 0));
		}
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
