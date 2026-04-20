#pragma context server

namespace MS
{

class ProjFlamejetGuidedCl : CGameScript
{
	string CLOUD_ORG;
	string CUR_ANG;
	string CUR_ORG;
	string CUR_VEL;
	string FX_COLOR;
	string FX_DURATION;
	string FX_OWNER;
	string FX_SPRITE;
	int IS_ACTIVE;
	string PROJ_LIGHT_ID;
	int UPDATE_VEL;

	void client_activate()
	{
		FX_OWNER = param1;
		CUR_ANG = param2;
		CUR_VEL = param3;
		FX_COLOR = param4;
		FX_DURATION = param5;
		FX_SPRITE = param6;
		CUR_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SetCallback("render", "enable");
		IS_ACTIVE = 1;
		CLOUD_ORG = CUR_ORG;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", CUR_ORG, "setup_cloud", "update_cloud");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 128, FX_COLOR, 5.0);
		PROJ_LIGHT_ID = "game.script.last_light_id";
		LogDebug("*** proj_flamejet_guided_cl FX_SPRITE");
		string L_FAILSAFE_DURATION = FX_DURATION;
		L_FAILSAFE_DURATION *= 1.5;
		L_FAILSAFE_DURATION("end_fx");
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "exists"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		ClientEffect("light", PROJ_LIGHT_ID, L_POS, 128, FX_COLOR, 1.0);
	}

	void sv_update_vel()
	{
		CUR_ANG = param1;
		CUR_VEL = param2;
		CUR_ORG = param3;
		UPDATE_VEL = 1;
	}

	void update_cloud()
	{
		if ((IS_ACTIVE))
		{
			CLOUD_ORG = "game.tempent.origin";
			LogDebug("update_cloud FX_SPRITE CLOUD_ORG");
			if ((UPDATE_VEL))
			{
				ClientEffect("tempent", "set_current_prop", "angles", CUR_ANG);
				ClientEffect("tempent", "set_current_prop", "velocity", CUR_VEL);
				UPDATE_VEL = 0;
			}
			ClientEffect("tempent", "sprite", FX_SPRITE, CLOUD_ORG, "spit_flames", "update_flames");
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 0, 0));
		}
	}

	void proj_explode()
	{
		IS_ACTIVE = 0;
		ClientEffect("light", "new", CLOUD_ORG, 256, FX_COLOR, 2.0);
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void end_fx()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(3.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 1);
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
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

	void spit_flames()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
	}

	void update_flames()
	{
		string CUR_SCALE = "game.tempent.scale";
		CUR_SCALE -= 0.1;
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
	}

}

}
