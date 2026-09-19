#pragma context server

namespace MS
{

class BowsOrion1Cl : CGameScript
{
	string BALL_OFS;
	int FX_ACTIVE;
	string FX_OWNER;

	BowsOrion1Cl()
	{
		BALL_OFS = Vector3(0, 20, 0);
	}

	void client_activate()
	{
		FX_OWNER = param1;
		string FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		FX_ORIGIN += "z";
		string VIEW_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
		FX_ORIGIN += /* TODO: $relpos */ $relpos(VIEW_ANG, BALL_OFS);
		FX_ACTIVE = 1;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "setup_ball", "update_ball");
	}

	void update_ball()
	{
		if ((FX_ACTIVE))
		{
			string FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			FX_ORIGIN += "z";
			string VIEW_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "viewangles");
			FX_ORIGIN += /* TODO: $relpos */ $relpos(VIEW_ANG, BALL_OFS);
			ClientEffect("tempent", "set_current_prop", "origin", FX_ORIGIN);
			string CUR_SCALE = "game.tempent.fuser1";
			if (CUR_SCALE < ACT_SCALE)
			{
			}
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void add_charge()
	{
		ACT_SCALE += 0.75;
	}

	void charge_release()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_ball()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 100);
		ClientEffect("tempent", "set_current_prop", "body", 13);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 500);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 20);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
	}

}

}
