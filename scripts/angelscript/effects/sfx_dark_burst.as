#pragma context server

namespace MS
{

class SfxDarkBurst : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	int FX_RAD;
	string LIGHT_ID;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		EmitSound3D("magic/temple.wav", 10, FX_ORIGIN);
		EmitSound3D("magic/boom.wav", 10, FX_ORIGIN);
		SetCallback("render", "enable");
		FX_RAD = 128;
		ClientEffect("light", "new", FX_ORIGIN, FX_RAD, Vector3(255, 0, 255), 0.1);
		LIGHT_ID = "game.script.last_light_id";
		FX_DURATION("end_fx");
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", FX_ORIGIN, "setup_dark_burst", "update_dark_burst");
	}

	void game_prerender()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("light", LIGHT_ID, FX_ORIGIN, 128, Vector3(255, 0, 255), 0.1);
		}
		else
		{
			if (FX_RAD > 2)
			{
			}
			FX_RAD -= 1;
			ClientEffect("light", LIGHT_ID, FX_ORIGIN, FX_RAD, Vector3(255, 0, 255), 0.1);
		}
	}

	void update_dark_burst()
	{
		if ((FX_ACTIVE))
		{
			string CUR_SCALE = "game.tempent.fuser1";
			if (CUR_SCALE < 1.0)
			{
			}
			CUR_SCALE += 0.04;
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		}
		if (!(FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_dark_burst()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 54);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
