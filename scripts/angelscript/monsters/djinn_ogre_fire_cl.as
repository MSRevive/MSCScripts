#pragma context server

namespace MS
{

class DjinnOgreFireCl : CGameScript
{
	string CLOUD_ANG;
	string FLAME_SPRITE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	int FX_STORM_ON;
	string GLOW_COLOR;
	int GLOW_RAD;
	string LEFT_HAND_POS;
	string MY_LIGHT_ID;
	int N_FRAMES;
	string RIGHT_HAND_POS;

	DjinnOgreFireCl()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 128, 0);
		FLAME_SPRITE = "explode1.spr";
		N_FRAMES = 9;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		RIGHT_HAND_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		LEFT_HAND_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		SetCallback("render", "enable");
		FX_ACTIVE = 1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		MY_LIGHT_ID = "game.script.last_light_id";
		RIGHT_HAND_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		LEFT_HAND_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		ClientEffect("tempent", "sprite", "Fire1_fixed.spr", RIGHT_HAND_POS, "setup_hand_sprite", "update_rhand_sprite");
		ClientEffect("tempent", "sprite", "Fire1_fixed.spr", LEFT_HAND_POS, "setup_hand_sprite", "update_lhand_sprite");
		if (param3 == 1)
		{
			fire_storm_on();
		}
		FX_DURATION("end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		ClientEffect("light", MY_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void update_rhand_sprite()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", RIGHT_HAND_POS);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void update_lhand_sprite()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", LEFT_HAND_POS);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void fire_storm_on()
	{
		FX_STORM_ON = 1;
		fire_storm_loop();
	}

	void fire_storm_off()
	{
		FX_STORM_ON = 0;
	}

	void fire_storm_loop()
	{
		if (!(FX_STORM_ON)) return;
		make_cloud(RIGHT_HAND_POS, /* TODO: $getcl */ $getcl(FX_OWNER, "angles"));
		make_cloud(LEFT_HAND_POS, /* TODO: $getcl */ $getcl(FX_OWNER, "angles"));
		ScheduleDelayedEvent(0.1, "fire_storm_loop");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		FX_STORM_ON = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void make_cloud()
	{
		string CLOUD_ORG = param1;
		CLOUD_ANG = param2;
		ClientEffect("tempent", "sprite", FLAME_SPRITE, CLOUD_ORG, "setup_cloud", "update_cloud");
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
		ClientEffect("tempent", "set_current_prop", "frames", N_FRAME);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "angles", CLOUD_ANG);
		float RND_RL = Random(-20, 20);
		float RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(CLOUD_ANG, Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void setup_hand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
