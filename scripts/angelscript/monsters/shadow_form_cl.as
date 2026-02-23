#pragma context server

namespace MS
{

class ShadowFormCl : CGameScript
{
	int DEATH_MODE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string NEG_FX_HEIGHT;
	string NEG_FX_WIDTH;
	string SHADOW_X_OFF;
	string SHADOW_Y_OFF;
	string SHADOW_Z_OFF;

	ShadowFormCl()
	{
		const int FX_WIDTH = 48;
		const int FX_HEIGHT = 48;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		NEG_FX_WIDTH = /* TODO: $neg */ $neg(FX_WIDTH);
		NEG_FX_HEIGHT = /* TODO: $neg */ $neg(FX_HEIGHT);
		do_shadows();
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		if ((DEATH_MODE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_shadows()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "do_shadows");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SHADOW_X_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Y_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Z_OFF = Random(NEG_FX_HEIGHT, FX_HEIGHT);
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SHADOW_X_OFF, SHADOW_Y_OFF, SHADOW_Z_OFF));
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows", "update_shadows");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SHADOW_X_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Y_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Z_OFF = Random(NEG_FX_HEIGHT, FX_HEIGHT);
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SHADOW_X_OFF, SHADOW_Y_OFF, SHADOW_Z_OFF));
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows", "update_shadows");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SHADOW_X_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Y_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Z_OFF = Random(NEG_FX_HEIGHT, FX_HEIGHT);
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SHADOW_X_OFF, SHADOW_Y_OFF, SHADOW_Z_OFF));
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows", "update_shadows");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SHADOW_X_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Y_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Z_OFF = Random(NEG_FX_HEIGHT, FX_HEIGHT);
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SHADOW_X_OFF, SHADOW_Y_OFF, SHADOW_Z_OFF));
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows", "update_shadows");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SHADOW_X_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Y_OFF = Random(NEG_FX_WIDTH, FX_WIDTH);
		SHADOW_Z_OFF = Random(NEG_FX_HEIGHT, FX_HEIGHT);
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(SHADOW_X_OFF, SHADOW_Y_OFF, SHADOW_Z_OFF));
		SPR_POS += "z";
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows", "update_shadows");
	}

	void update_shadows()
	{
		if (!(DEATH_MODE))
		{
			string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			SPR_POS += "z";
			string MY_X_OFF = "game.tempent.fuser1";
			string MY_Y_OFF = "game.tempent.fuser2";
			string MY_Z_OFF = "game.tempent.fuser3";
			SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(MY_X_OFF, MY_Y_OFF, MY_Z_OFF));
			ClientEffect("tempent", "set_current_prop", "origin", SPR_POS);
		}
		else
		{
			string CUR_SCALE = "game.tempent.fuser4";
			CUR_SCALE -= 0.2;
			if (CUR_SCALE < 0)
			{
				float CUR_SCALE = 0.01;
				ClientEffect("tempent", "set_current_prop", "framerate", 30);
			}
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
			string CUR_YAW = "game.tempent.fuser1";
			if (CUR_YAW != 999)
			{
				string CUR_YAW = Random(0, 359.0);
				ClientEffect("tempent", "set_current_prop", "angles.yaw", CUR_YAW);
				ClientEffect("tempent", "set_current_prop", "velocity.y", Random(-100, 100));
				ClientEffect("tempent", "set_current_prop", "fuser1", 999);
				ClientEffect("tempent", "set_current_prop", "framerate", 5);
				ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
			}
		}
	}

	void shadow_death()
	{
		DEATH_MODE = 1;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(4.0, "remove_fx");
	}

	void setup_shadows()
	{
		string RND_SCALE = Random(0.4, 0.6);
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.4, 0.6));
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", SHADOW_X_OFF);
		ClientEffect("tempent", "set_current_prop", "fuser2", SHADOW_Y_OFF);
		ClientEffect("tempent", "set_current_prop", "fuser3", SHADOW_Z_OFF);
		ClientEffect("tempent", "set_current_prop", "fuser4", RND_SCALE);
	}

}

}
