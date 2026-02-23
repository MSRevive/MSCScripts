#pragma context server

namespace MS
{

class ProjMana2Cl : CGameScript
{
	string BALL_SIZE;
	int FX_ACTIVE;
	string FX_ANG;
	string FX_CUR_ORG;
	string FX_ORIGIN;
	string FX_VEL;

	ProjMana2Cl()
	{
		const string FX_MODEL = "weapons/projectiles.mdl";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_ANG = param2;
		FX_VEL = param3;
		BALL_SIZE = param4;
		FX_ACTIVE = 1;
		ClientEffect("tempent", "model", FX_MODEL, FX_ORIGIN, "setup_arrow", "update_arrow", "cl_projectile_collide");
		ScheduleDelayedEvent(10.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void reduce_size()
	{
		BALL_SIZE -= 1;
		if (BALL_SIZE == 0)
		{
			FX_ACTIVE = 0;
		}
	}

	void update_arrow()
	{
		ClientEffect("tempent", "set_current_prop", "scale", /* TODO: $math(multiply) */ BALL_SIZE);
		if ((FX_ACTIVE))
		{
			FX_CUR_ORG = "game.tempent.origin";
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void setup_arrow()
	{
		ClientEffect("tempent", "set_current_prop", "origin", FX_ORIGIN);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "scale", /* TODO: $math(multiply) */ BALL_SIZE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", FX_ANG);
		ClientEffect("tempent", "set_current_prop", "velocity", FX_VEL);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "body", 13);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "cb_collide", "cl_projectile_collide");
	}

	void cl_projectile_collide()
	{
		end_fx();
	}

}

}
