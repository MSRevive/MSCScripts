#pragma context server

namespace MS
{

class SlimeGlobeCl : CGameScript
{
	string FX_DURATION;
	int GROW_MODE;
	int SHRINK_MODE;

	void client_activate()
	{
		FX_DURATION = param2;
		GROW_MODE = 1;
		SHRINK_MODE = 0;
		LogDebug("*** slime_globe_cl PARAM1 FX_DURATION GROW_MODE SHRINK_MODE");
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", param1, "setup_slime_ball", "update_slime_ball");
		FX_DURATION("start_shrink");
	}

	void start_shrink()
	{
		LogDebug("*** slime_globe_cl start_shrink");
		if ((SHRINK_MODE)) return;
		GROW_MODE = 0;
		SHRINK_MODE = 1;
		ScheduleDelayedEvent(2.1, "remove_me");
	}

	void early_remove()
	{
		start_shrink();
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_slime_ball()
	{
		string L_FX_DURATION = FX_DURATION;
		L_FX_DURATION += 2.0;
		ClientEffect("tempent", "set_current_prop", "death_delay", L_FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 68);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 9);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
	}

	void update_slime_ball()
	{
		if ((GROW_MODE))
		{
			string CUR_SIZE = "game.tempent.fuser1";
			CUR_SIZE += 0.01;
			if (CUR_SIZE < 2.5)
			{
			}
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
		}
		if ((SHRINK_MODE))
		{
			string CUR_SIZE = "game.tempent.fuser1";
			CUR_SIZE -= 0.1;
			if (CUR_SIZE > 0)
			{
			}
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
		}
	}

}

}
