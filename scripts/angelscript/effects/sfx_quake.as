#pragma context server

namespace MS
{

class SfxQuake : CGameScript
{
	int CIRC_COUNT;
	string CIRC_RAD;
	string CIRC_STEP;
	int FX_ACTIVE;
	string FX_AOE;
	string FX_DURATION;
	string FX_MOBILE;
	string FX_N_CIRCS;
	string FX_ORIGIN;
	string FX_RATIO;
	string FX_ROCKS_PER_CIRC;
	string FX_SRC;
	string FX_VOLCANIC;
	float ROT_COUNT;
	string ROT_STEP;

	SfxQuake()
	{
	}

	void client_activate()
	{
		FX_SRC = param1;
		FX_MOBILE = param2;
		FX_AOE = param3;
		FX_DURATION = param4;
		FX_VOLCANIC = param5;
		FX_ACTIVE = 1;
		if ((FX_VOLCANIC))
		{
			if ((param6).findFirst(PARAM) == 0)
			{
				ATTACKER_IDX = param6;
			}
			else
			{
				ATTACKER_IDX = 0;
			}
			RandomInt(0_5, 1_0)("flaming_rocks_loop");
		}
		FX_RATIO = (FX_AOE / 1024);
		FX_ROCKS_PER_CIRC = /* TODO: $ratio */ $ratio(FX_RATIO, 4, 16);
		FX_ROCKS_PER_CIRC = int(FX_ROCKS_PER_CIRC);
		FX_N_CIRCS = /* TODO: $ratio */ $ratio(FX_RATIO, 2, 8);
		FX_N_CIRCS = int(FX_N_CIRCS);
		quake_loop();
		FX_DURATION("end_fx");
	}

	void flaming_rocks_loop()
	{
		if (!(FX_ACTIVE)) return;
		Random(0_25, 0_5)("flaming_rocks_loop");
		if ((FX_MOBILE))
		{
			FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_SRC, "origin");
		}
		else
		{
			FX_ORIGIN = FX_SRC;
		}
		float L_DROP_YAW = Random(0, 359.99);
		float L_DROP_DIST = Random(0, FX_AOE);
		string L_DROP_POINT = FX_ORIGIN;
		L_DROP_POINT += /* TODO: $relpos */ $relpos(Vector3(0, L_DROP_YAW, 0), Vector3(0, L_DROP_DIST, 256));
		ClientEffect("tempent", "model", "rockgibs.mdl", L_DROP_POINT, "setup_frock", "update_frock");
	}

	void cb_frock_land()
	{
		string L_ORG = "game.tempent.origin";
		ClientEffect("tempent", "sprite", "xfireball3.spr", L_ORG, "setup_frock_explode");
		ClientEffect("tempent", "sprite", "xfireball3.spr", L_ORG, "setup_frock_explode");
		ClientEffect("tempent", "sprite", "xfireball3.spr", L_ORG, "setup_frock_explode");
		EmitSound3D("fire.wav", 10, L_ORG);
		if (!(ATTACKER_IDX > 0)) return;
		string L_PLR_IDX = "game.localplayer.index";
		string L_PLR_ORG = /* TODO: $getcl */ $getcl(L_PLR_IDX, "origin");
		LogDebug("*** $currentscript cb_frock_land ds Distance(L_ORG, L_PLR_ORG) atk ATTACKER_IDX [ L_ORG vs. L_PLR_ORG ]");
	}

	void setup_frock()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(6.0, 8.0));
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "cb_collide", "cb_frock_land");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", RandomInt(1, 2));
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(90, RND_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "fuser1", (GetGameTime() + 0.1));
	}

	void update_frock()
	{
		if (!(GetGameTime() > "game.tempent.fuser1")) return;
		ClientEffect("tempent", "set_current_prop", "fuser1", (GetGameTime() + 0.1));
		ClientEffect("tempent", "sprite", "xfireball3.spr", "game.tempent.origin", "setup_frock_trail");
	}

	void setup_frock_trail()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 96, 64));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void setup_frock_explode()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 19);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 2);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 96, 64));
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-100, 100), Random(-100, 100), Random(100, 400)));
	}

	void quake_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "quake_loop");
		if ((FX_MOBILE))
		{
			FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_SRC, "origin");
		}
		else
		{
			FX_ORIGIN = FX_SRC;
		}
		FX_ORIGIN = "z";
		CIRC_COUNT = 0;
		CIRC_STEP = (FX_AOE / FX_N_CIRCS);
		for (int i = 0; i < FX_N_CIRCS; i++)
		{
			do_circles();
		}
	}

	void do_circles()
	{
		string CUR_CIRC = i;
		CIRC_RAD = (CIRC_STEP * CUR_CIRC);
		CIRC_RAD += CIRC_STEP;
		ROT_COUNT = Random(0, 359.99);
		string L_NROCKS = (CUR_CIRC / FX_N_CIRCS);
		string L_NROCKS = /* TODO: $ratio */ $ratio(L_NROCKS, 4, FX_ROCKS_PER_CIRC);
		int L_NROCKS = int(L_NROCKS);
		ROT_STEP = (359.99 / L_NROCKS);
		for (int i = 0; i < L_NROCKS; i++)
		{
			do_rocks();
		}
	}

	void do_rocks()
	{
		string L_POS = FX_ORIGIN;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, CIRC_RAD, 0));
		ClientEffect("tempent", "model", "rockgibs.mdl", L_POS, "setup_rock", "update_rock");
		ROT_COUNT += ROT_STEP;
		if (ROT_COUNT > 359.99)
		{
			ROT_COUNT -= 359.99;
		}
	}

	void setup_rock()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(1.4, 2.0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 50));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", RandomInt(1, 2));
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, RND_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "fuser1", GetGameTime());
	}

	void update_rock()
	{
		if (!(FX_ACTIVE))
		{
			string L_CUR_VEL = "game.tempent.velocity";
			L_CUR_VEL += "z";
			if ((L_CUR_VEL).z < -600)
			{
				L_CUR_VEL = "z";
			}
			ClientEffect("tempent", "set_current_prop", "bouncefactor", 1);
			ClientEffect("tempent", "set_current_prop", "velocity", L_CUR_VEL);
			ClientEffect("tempent", "set_current_prop", "gravity", 1);
			ClientEffect("tempent", "set_current_prop", "collide", "world");
		}
		string CUR_ANG = "game.tempent.angles";
		string L_YAW = /* TODO: $vec.yaw */ $vec.yaw(CUR_ANG);
		L_YAW += 1;
		if (L_YAW > 359.99)
		{
			L_YAW -= 359.99;
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, L_YAW, 0));
		float CUR_REND = GetGameTime();
		CUR_REND -= "game.tempent.fuser1";
		string CUR_REND = (CUR_REND / 3);
		string CUR_REND = /* TODO: $ratio */ $ratio(CUR_REND, 512, 0);
		if (CUR_REND > 255)
		{
			int CUR_REND = 255;
		}
		ClientEffect("tempent", "set_current_prop", "renderamt", CUR_REND);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(4.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
