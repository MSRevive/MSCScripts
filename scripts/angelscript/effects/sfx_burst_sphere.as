#pragma context server

namespace MS
{

class SfxBurstSphere : CGameScript
{
	int FX_ACTIVE;
	string FX_END_TIME;
	string FX_GROW_START;
	string FX_ORIGIN;
	float FX_SCALE;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_GROW_START = GetGameTime();
		FX_GROW_START += 2.5;
		FX_END_TIME = FX_GROW_START;
		FX_SCALE = 2.0;
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(6.0, "end_fx");
		ClientEffect("tempent", "model", "weapons/projectiles", FX_ORIGIN, "setup_bubble", "update_bubble");
	}

	void update_bubble()
	{
		if ((FX_ACTIVE))
		{
			if (!(GROW_MODE))
			{
				if (GetGameTime() > FX_GROW_START)
				{
				}
				GROW_MODE = 1;
			}
			if ((GROW_MODE))
			{
			}
			FX_SCALE += 0.01;
			ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		}
		else
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

	void setup_bubble()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		ClientEffect("tempent", "set_current_prop", "body", 1);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "frames", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
