#pragma context server

namespace MS
{

class ProjElementalCl : CGameScript
{
	string CLOUD_ORG;
	string CUR_ANG;
	string CUR_ORG;
	string CUR_VEL;
	int CYCLE_ANGLE;
	string FX_COLOR;
	string FX_DURATION;
	string FX_OWNER;
	string FX_SPRITE;
	int IS_ACTIVE;
	string PROJ_LIGHT_ID;
	int UPDATE_VEL;

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.01, 0.05));
		if ((IS_ACTIVE))
		{
		}
		ClientEffect("tempent", "sprite", FX_SPRITE, CLOUD_ORG, "spit_flames");
		ClientEffect("tempent", "sprite", FX_SPRITE, CLOUD_ORG, "spit_flames");
		ClientEffect("tempent", "sprite", FX_SPRITE, CLOUD_ORG, "spit_flames");
	}

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

	void proj_explode()
	{
		IS_ACTIVE = 0;
		ClientEffect("light", "new", CLOUD_ORG, 256, FX_COLOR, 2.0);
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_explode_sprites();
		}
		ScheduleDelayedEvent(1.5, "remove_fx");
	}

	void create_explode_sprites()
	{
		string SPR_POS = CLOUD_ORG;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 0));
		ClientEffect("tempent", "sprite", FX_SPRITE, SPR_POS, "setup_explode_sprite", "update_explode_sprite");
		CYCLE_ANGLE += 20;
	}

	void update_explode_sprite()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		if (!(CUR_SIZE > 0.01)) return;
		CUR_SIZE -= 0.01;
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
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
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(CUR_ANG, Vector3(Random(-120, 120), -200, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
	}

	void setup_explode_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string SPRITE_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 200, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "angles", CUR_ANG);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1.0);
	}

}

}
