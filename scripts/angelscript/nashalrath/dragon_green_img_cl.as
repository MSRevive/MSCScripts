#pragma context server

namespace MS
{

class DragonGreenImgCl : CGameScript
{
	string BREATH_COLOR;
	string BREATH_TYPE;
	string BREATH_YAW;
	int FX_ACTIVE;
	string FX_OWNER;

	DragonGreenImgCl()
	{
	}

	void client_activate()
	{
		FX_OWNER = param1;
		BREATH_TYPE = param2;
		BREATH_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		BREATH_YAW = /* TODO: $vec.yaw */ $vec.yaw(BREATH_YAW);
		if (BREATH_TYPE == 1)
		{
			BREATH_COLOR = Vector3(255, 128, 0);
		}
		if (BREATH_TYPE == 2)
		{
			BREATH_COLOR = Vector3(255, 255, 0);
		}
		if (BREATH_TYPE == 3)
		{
			BREATH_COLOR = Vector3(64, 64, 255);
		}
		FX_ACTIVE = 1;
		breath_loop();
	}

	void breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		Random(0_1, 0_2)("breath_loop");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0"), "setup_breath_sprite", "update_breath_sprite");
	}

	void ext_breath_stop()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(8.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_breath_sprite()
	{
		if (!(FX_ACTIVE)) return;
		if (("game.tempent.origin").z > -2100)
		{
			ClientEffect("tempent", "set_current_prop", "gravity", 2);
			ClientEffect("tempent", "set_current_prop", "fuser2", 1);
			LogDebug("update_breath_sprite adjust_down");
		}
		else
		{
			if ("game.tempent.fuser2" == 1)
			{
			}
			ClientEffect("tempent", "set_current_prop", "gravity", -2);
		}
		string CUR_SCALE = "game.tempent.fuser1";
		if (!(CUR_SCALE < 20)) return;
		CUR_SCALE += 0.1;
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
	}

	void setup_breath_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 6.0);
		string L_BREATH_YAW = BREATH_YAW;
		L_BREATH_YAW += Random(-30.00, 30.00);
		string RND_F = Random(100.00, 300.00);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relpos */ $relpos(Vector3(0, L_BREATH_YAW, 0), Vector3(0, RND_F, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 2);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-3.0, -2.0));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", BREATH_COLOR);
	}

}

}
