#pragma context server

namespace MS
{

class DoomPlantCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string SPUR_YAW;
	string TRAIL_ANG;

	void client_activate()
	{
		FX_DURATION = param1;
		FX_ACTIVE = 1;
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.1, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void shoot_spur()
	{
		if (!(FX_ACTIVE)) return;
		string SPUR_START = param1;
		SPUR_YAW = param2;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", SPUR_START, "setup_spur", "update_spur");
	}

	void update_spur()
	{
		if (!(GetGameTime() > NEXT_SHADOW)) return;
		string MY_ORG = "game.tempent.origin";
		TRAIL_ANG = "game.tempent.angles";
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", MY_ORG, "spur_trail");
	}

	void spur_trail()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.15);
		ClientEffect("tempent", "set_current_prop", "fade", 0.15);
		ClientEffect("tempent", "set_current_prop", "body", 24);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 7);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", TRAIL_ANG);
	}

	void setup_spur()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "body", 24);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 7);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, SPUR_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, SPUR_YAW, 0), Vector3(0, 1000, 0)));
	}

}

}
