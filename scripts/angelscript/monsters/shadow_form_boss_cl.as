#pragma context server

namespace MS
{

class ShadowFormBossCl : CGameScript
{
	int BOSS_DEAD;
	string CUR_ROT;
	int FX_ACTIVE;
	string FX_OWNER;
	int FX_RADIUS;
	string OWNER_ORG;
	float ROT_DIR;
	float START_SCALE;

	ShadowFormBossCl()
	{
		const int V_ADJ = 48;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(30.0, "end_fx");
		fx_loop();
	}

	void end_fx()
	{
		if ((BOSS_DEAD)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void end_fx_post_boss()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		OWNER_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		FX_RADIUS = 90;
		START_SCALE = 1.0;
		ROT_DIR = -0.1;
		for (int i = 0; i < 18; i++)
		{
			make_smokes();
		}
		FX_RADIUS = 180;
		START_SCALE = 0.8;
		ROT_DIR = 0.1;
		for (int i = 0; i < 18; i++)
		{
			make_smokes();
		}
		FX_RADIUS = 270;
		START_SCALE = 0.6;
		ROT_DIR = -0.1;
		for (int i = 0; i < 18; i++)
		{
			make_smokes();
		}
	}

	void make_smokes()
	{
		CUR_ROT = i;
		CUR_ROT *= 20;
		string SPR_POS = OWNER_ORG;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ROT, 0), Vector3(0, FX_RADIUS, V_ADJ));
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows1", "update_shadows1");
	}

	void boss_died()
	{
		BOSS_DEAD = 1;
		ScheduleDelayedEvent(10.0, "end_fx_post_boss");
	}

	void update_shadows1()
	{
		if (!(FX_ACTIVE)) return;
		if ((BOSS_DEAD))
		{
			string SPR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 0));
			string L_ROT = "game.tempent.fuser2";
			SPR_VEL += /* TODO: $relvel */ $relvel(Vector3(0, L_ROT, 0), Vector3(0, 100, 0));
			ClientEffect("tempent", "set_current_prop", "velocity", SPR_VEL);
		}
		if ((BOSS_DEAD)) return;
		if (RandomInt(1, 10) == 1)
		{
			string CUR_FRAME = "game.tempent.fuser1";
			CUR_FRAME += 1;
			if (CUR_FRAME > 30)
			{
				int CUR_FRAME = 20;
			}
			ClientEffect("tempent", "set_current_prop", "frame", CUR_FRAME);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_FRAME);
		}
		string L_ROT = "game.tempent.fuser2";
		string L_DIR = "game.tempent.fuser3";
		string L_RAD = "game.tempent.fuser4";
		L_ROT += L_DIR;
		if (L_ROT < 0)
		{
			float L_ROT = 359.99;
		}
		if (L_ROT > 359.99)
		{
			int L_ROT = 0;
		}
		string SPR_POS = OWNER_ORG;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_ROT, 0), Vector3(0, L_RAD, V_ADJ));
		ClientEffect("tempent", "set_current_prop", "origin", SPR_POS);
		ClientEffect("tempent", "set_current_prop", "fuser2", L_ROT);
	}

	void setup_shadows1()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 30.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frame", 20);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", START_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 20.0);
		ClientEffect("tempent", "set_current_prop", "fuser2", CUR_ROT);
		ClientEffect("tempent", "set_current_prop", "fuser3", ROT_DIR);
		ClientEffect("tempent", "set_current_prop", "fuser4", FX_RADIUS);
	}

}

}
