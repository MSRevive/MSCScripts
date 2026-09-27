#pragma context server

namespace MS
{

class WindCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_SCALE;

	void OnRepeatTimer()
	{
		SetRepeatDelay(9.0);
		if ((FX_ACTIVE))
		{
		}
		EmitSound3D("magic/vent1.wav", 10, FX_ORIGIN);
	}

	void client_activate()
	{
		LogDebug("****** wind client_activate");
		FX_ORIGIN = param1;
		FX_SCALE = param2;
		FX_DURATION = param3;
		FX_ACTIVE = 1;
		EmitSound3D("magic/vent1.wav", 10, FX_ORIGIN);
		ClientEffect("tempent", "model", "monsters/monster_extras.mdl", FX_ORIGIN, "setup_wind", "update_wind");
		FX_DURATION("end_fx");
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

	void update_wind()
	{
		if ((FX_ACTIVE)) return;
		ClientEffect("tempent", "set_current_prop", "origin", Vector3(9999, 9999, 9999));
	}

	void setup_wind()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		ClientEffect("tempent", "set_current_prop", "body", 0);
		ClientEffect("tempent", "set_current_prop", "sequence", 2);
		ClientEffect("tempent", "set_current_prop", "frames", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
