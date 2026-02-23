#pragma context server

namespace MS
{

class SfxPoisonCloud : CGameScript
{
	string DBG_AOE_RATIO;
	string DBG_SPRITE_COUNT;
	int FX_ACTIVE;
	string FX_AOE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_SOUND;
	float SPITE_GRAVITY;
	string SPRITE_SCALE;
	int SPRITE_SCALE_MAX;
	int SPRITE_SCALE_MIN;

	SfxPoisonCloud()
	{
		const string SPRITE_NAME = "poison_cloud.spr";
		const string SOUND_BURST = "ambience/steamburst1.wav";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_AOE = param2;
		FX_DURATION = param3;
		if (param4 != "PARAM4")
		{
			FX_SOUND = param4;
		}
		else
		{
			FX_SOUND = 1;
		}
		FX_ACTIVE = 1;
		string L_LIGHT_RAD = FX_AOE;
		L_LIGHT_RAD *= 1.5;
		ClientEffect("light", "new", FX_ORIGIN, L_LIGHT_RAD, Vector3(0, 255, 0), FX_DURATION);
		string L_AOE_RATIO = FX_AOE;
		if (L_AOE_RATIO > 256)
		{
			int L_AOE_RATIO = 256;
		}
		L_AOE_RATIO /= 256;
		SPRITE_SCALE_MIN = 5;
		SPRITE_SCALE_MAX = 5;
		SPRITE_SCALE_MIN *= L_AOE_RATIO;
		SPRITE_SCALE_MAX *= L_AOE_RATIO;
		DBG_AOE_RATIO = L_AOE_RATIO;
		do_smokes();
		FX_DURATION("end_fx");
		if (!(FX_SOUND)) return;
		EmitSound3D(SOUND_BURST, 10, FX_ORIGIN);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(3.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_smokes()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "do_smokes");
		string RND_DIST = Random(0, FX_AOE);
		string RND_ANG = Random(0, 359.99);
		int L_OFS_Z = 0;
		string L_POS = FX_ORIGIN;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, L_OFS_Z));
		SPRITE_SCALE = Random(SPRITE_SCALE_MIN, SPRITE_SCALE_MAX);
		string L_PILLAR_SCALE = SPRITE_SCALE;
		L_PILLAR_SCALE *= 1.5;
		string L_DIST_RATIO = RND_DIST;
		L_DIST_RATIO /= FX_AOE;
		string L_DIST_RATIO = /* TODO: $ratio */ $ratio(L_DIST_RATIO, 0, 1.2);
		float L_FRATIO = 1.3;
		L_FRATIO -= L_DIST_RATIO;
		SPITE_GRAVITY = -0.03;
		SPRITE_SCALE *= L_FRATIO;
		ClientEffect("tempent", "sprite", SPRITE_NAME, L_POS, "setup_smoke", "update_smoke");
		if (DBG_SPRITE_COUNT == "DBG_SPRITE_COUNT")
		{
			DBG_SPRITE_COUNT = 1;
		}
		SPITE_GRAVITY = -0.05;
		SPRITE_SCALE = L_PILLAR_SCALE;
		ClientEffect("tempent", "sprite", SPRITE_NAME, FX_ORIGIN, "setup_smoke", "update_smoke");
		DBG_SPRITE_COUNT = 0;
	}

	void update_smoke()
	{
		string CUR_SCALE = "game.tempent.fuser1HD";
		if (CUR_SCALE > 0.02)
		{
			CUR_SCALE *= 0.99;
			ClientEffect("tempent", "set_current_prop", "scaleHD", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "fuser1HD", CUR_SCALE);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(6000, 6000, 6000));
		}
	}

	void setup_smoke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 15);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 150);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", SPITE_GRAVITY);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser2", GetGameTime());
		ClientEffect("tempent", "set_current_prop", "iuser1", DBG_SPRITE_COUNT);
	}

}

}
