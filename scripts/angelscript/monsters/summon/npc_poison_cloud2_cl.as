#pragma context server

namespace MS
{

class NpcPoisonCloud2Cl : CGameScript
{
	string FX_COLOR;
	string FX_ORIGIN;
	int IS_ACTIVE;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_ORIGIN += "z";
		string FX_DURATION = param2;
		string CLOUD_VARIANT = param3;
		if (CLOUD_VARIANT == 1)
		{
			FX_COLOR = Vector3(0, 0, 0);
		}
		if (CLOUD_VARIANT == 2)
		{
			FX_COLOR = Vector3(128, 255, 0);
		}
		if (CLOUD_VARIANT == 3)
		{
			FX_COLOR = Vector3(255, 0, 0);
		}
		LogDebug("*** client_activate org FX_ORIGIN dur FX_DURATION type CLOUD_VARIANT");
		IS_ACTIVE = 1;
		do_smokes();
		FX_DURATION("end_fx");
	}

	void do_smokes()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "do_smokes");
		for (int i = 0; i < 3; i++)
		{
			do_smokes_loop();
		}
	}

	void do_smokes_loop()
	{
		string L_POS = FX_ORIGIN;
		L_POS += "x";
		L_POS += "y";
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
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

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
