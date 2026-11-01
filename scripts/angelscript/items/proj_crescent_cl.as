#pragma context server

namespace MS
{

class ProjCrescentCl : CGameScript
{
	string CUR_ANG;
	string CUR_ORG;
	string CUR_VEL;
	string FX_OWNER;
	int IS_ACTIVE;
	int UPDATE_VEL;

	void client_activate()
	{
		FX_OWNER = param1;
		CUR_ANG = param2;
		CUR_VEL = param3;
		CUR_ORG = param4;
		SetCallback("render", "enable");
		IS_ACTIVE = 1;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", CUR_ORG, "setup_cre", "update_cre");
		ScheduleDelayedEvent(3.0, "end_fx");
	}

	void sv_update_vel()
	{
		CUR_ANG = param1;
		CUR_VEL = param2;
		CUR_ORG = param3;
		UPDATE_VEL = 1;
	}

	void update_cre()
	{
		if ((IS_ACTIVE))
		{
			if ((UPDATE_VEL))
			{
				ClientEffect("tempent", "set_current_prop", "angles", CUR_ANG);
				ClientEffect("tempent", "set_current_prop", "velocity", CUR_VEL);
				UPDATE_VEL = 0;
			}
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 0, 0));
		}
	}

	void end_fx()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.2, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_cre()
	{
		ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", CUR_ANG);
		ClientEffect("tempent", "set_current_prop", "velocity", CUR_VEL);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", 71);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "sequence", 11);
	}

}

}
