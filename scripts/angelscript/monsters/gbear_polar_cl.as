#pragma context server

namespace MS
{

class GbearPolarCl : CGameScript
{
	string BREATH_ANG;
	string BREATH_ON;
	string BREATH_VEL;
	string CLOUD_ANG;
	string FX_DURATION;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		BREATH_ON = param3;
		if ((BREATH_ON))
		{
			breath_on();
		}
		PARAM2("end_fx");
	}

	void end_fx()
	{
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void quick_breath()
	{
		BREATH_VEL = /* TODO: $getcl */ $getcl(FX_OWNER, "velocity");
		BREATH_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		BREATH_VEL += /* TODO: $relpos */ $relpos(BREATH_ANG, Vector3(0, Random(5, 100), 0));
		ClientEffect("tempent", "sprite", "char_breath.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "weather_snow_breath");
	}

	void quick_breath_last()
	{
		BREATH_ON = 0;
		quick_breath();
		end_fx();
	}

	void breath_on()
	{
		BREATH_ON = 1;
		breath_loop();
	}

	void breath_off()
	{
		BREATH_ON = 0;
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.2, "breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		CLOUD_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		ClientEffect("tempent", "sprite", "rain_mist.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
		ClientEffect("tempent", "sprite", "rain_mist.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
		ClientEffect("tempent", "sprite", "rain_mist.spr", CLOUD_ORG, "setup_cloud", "update_cloud");
	}

	void weather_snow_breath()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 30);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.3, 0.75));
		ClientEffect("tempent", "set_current_prop", "gravity", -0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", RandomInt(30, 100));
		ClientEffect("tempent", "set_current_prop", "angles", BREATH_ANG);
		ClientEffect("tempent", "set_current_prop", "velocity", BREATH_VEL);
	}

	void setup_cloud()
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
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void update_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (CUR_SCALE < 2)
		{
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		}
	}

}

}
