#pragma context server

namespace MS
{

class SkeletonMageCl : CGameScript
{
	int ATTACK_LIGHT_ACTIVE;
	string ATTACK_LIGHT_COLOR;
	string ATTACK_LIGHT_ID;
	int ATTACK_LIGHT_RAD;
	string ATTACK_LIGHT_REMOVED;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string GLOW_COLOR;
	int GLOW_RAD;
	string SEAL_COLOR;
	string SEAL_GLOW_RAD;
	int SEAL_LIGHT_ACTIVE;
	string SEAL_LIGHT_ID;
	int SEAL_LIGHT_RADCOUNT;
	string SEAL_LIGHT_REMOVED;
	string SEAL_OFS;
	string SEAL_ORIGIN;
	string SEAL_RAD;
	string SKEL_LIGHT_ID;

	SkeletonMageCl()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 128, 64);
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, FX_DURATION);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		FX_ACTIVE = 1;
		FX_DURATION("end_effect");
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "exists"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
		if ((ATTACK_LIGHT_ACTIVE))
		{
			if (ATTACK_LIGHT_RAD < 256)
			{
				ATTACK_LIGHT_RAD += 1;
			}
			ClientEffect("light", ATTACK_LIGHT_ID, L_POS, ATTACK_LIGHT_RAD, ATTACK_LIGHT_COLOR, 0.1);
		}
		else
		{
			if (!(ATTACK_LIGHT_REMOVED))
			{
			}
			if (ATTACK_LIGHT_ID > 0)
			{
			}
			ATTACK_LIGHT_REMOVED = 1;
			ClientEffect("light", ATTACK_LIGHT_ID, Vector3(5000, 0, 0), 1, Vector3(1, 1, 1), 0.1);
		}
		if ((SEAL_LIGHT_ACTIVE))
		{
			if (SEAL_LIGHT_RADCOUNT < SEAL_GLOW_RAD)
			{
				SEAL_LIGHT_RADCOUNT += 1;
			}
			ClientEffect("light", SEAL_LIGHT_ID, L_POS, SEAL_LIGHT_RADCOUNT, SEAL_COLOR, 0.1);
		}
		else
		{
			if (!(SEAL_LIGHT_REMOVED))
			{
			}
			if (SEAL_LIGHT_ID > 0)
			{
			}
			SEAL_LIGHT_REMOVED = 1;
			ClientEffect("light", SEAL_LIGHT_ID, Vector3(5000, 0, 0), 1, Vector3(1, 1, 1), 0.1);
		}
	}

	void end_effect()
	{
		FX_ACTIVE = 0;
		SEAL_LIGHT_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_effect");
	}

	void remove_effect()
	{
		RemoveScript();
	}

	void show_orb()
	{
		ATTACK_LIGHT_COLOR = param1;
		ClientEffect("tempent", "sprite", "3dmflagry.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_orb_sprite", "update_orb_sprite");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 10, ATTACK_LIGHT_COLOR, 0.1);
		ATTACK_LIGHT_ID = "game.script.last_light_id";
		ATTACK_LIGHT_ACTIVE = 1;
		ATTACK_LIGHT_RAD = 10;
		ATTACK_LIGHT_REMOVED = 0;
	}

	void hide_orb()
	{
		ATTACK_LIGHT_ACTIVE = 0;
	}

	void setup_orb_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", ATTACK_LIGHT_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1);
	}

	void update_orb_sprite()
	{
		if ((ATTACK_LIGHT_ACTIVE))
		{
			string CUR_RENDERAMT = "game.tempent.fuser1";
			if (CUR_RENDERAMT < 255)
			{
				CUR_RENDERAMT += 1;
			}
			ClientEffect("tempent", "set_current_prop", "renderamt", CUR_RENDERAMT);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_RENDERAMT);
			ClientEffect("tempent", "set_current_prop", "origin", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"));
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		}
	}

	void show_seal_warning()
	{
		SEAL_ORIGIN = param1;
		SEAL_RAD = param2;
		SEAL_OFS = param3;
		SEAL_COLOR = param4;
		ClientEffect("tempent", "model", "weapons/magic/seals.mdl", SEAL_ORIGIN, "setup_seal_warn");
		SEAL_GLOW_RAD = SEAL_RAD;
		SEAL_GLOW_RAD *= 1.11;
		SEAL_LIGHT_ACTIVE = 1;
		SEAL_LIGHT_RADCOUNT = 1;
		SEAL_LIGHT_REMOVED = 0;
		ClientEffect("light", "new", SEAL_ORIGIN, SEAL_GLOW_RAD, SEAL_COLOR, 2.0);
		SEAL_LIGHT_ID = "game.script.last_light_id";
		ScheduleDelayedEvent(2.0, "seal_warning_end");
		EmitSound3D("magic/lightprep.wav", 5, SEAL_ORIGIN, 0.8, 0, 50);
	}

	void seal_warning_end()
	{
		SEAL_LIGHT_ACTIVE = 0;
	}

	void setup_seal_warn()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "body", SEAL_OFS);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SEAL_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
