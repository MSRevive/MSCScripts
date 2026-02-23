#pragma context server

namespace MS
{

class AbominationCl : CGameScript
{
	string ATTACHMENT_POS;
	string BREATH_TYPE;
	string CLOUD_ANG;
	int FX_ACTIVE;
	string FX_OWNER;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		if ((FX_ACTIVE))
		{
		}
		ATTACHMENT_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
	}

	void client_activate()
	{
		FX_OWNER = param1;
		BREATH_TYPE = param2;
		if ((BREATH_TYPE).findFirst("PARAM") == 0)
		{
			BREATH_TYPE = 0;
		}
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 256, Vector3(0, 255, 0), 1.0);
		SetCallback("render", "enable");
		FX_ACTIVE = 1;
		breath_loop();
		ScheduleDelayedEvent(15.0, "end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		make_cloud(/* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw"));
		ScheduleDelayedEvent(0.2, "breath_loop");
	}

	void make_cloud()
	{
		string CLOUD_ORG = param1;
		CLOUD_ANG = param2;
		if (BREATH_TYPE == 0)
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

	void end_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.25, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (CUR_SCALE < 2)
		{
			CUR_SCALE += 0.1;
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
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
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
