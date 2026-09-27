#pragma context client

namespace MS
{

class ProjArrowPhxCl : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	string FX_RADIUS;
	string SCALE_RATIO;
	string SOUND_BURST;

	ProjArrowPhxCl()
	{
		SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		CYCLE_ANGLE = 0;
		string FX_RADIUS_RATIO = FX_RADIUS;
		FX_RADIUS_RATIO /= 256;
		SCALE_RATIO = /* TODO: $ratio */ $ratio(FX_RADIUS_RATIO, 1.0, 10.0);
		string L_FX_CENTER = FX_CENTER;
		string Z_ADJ = /* TODO: $ratio */ $ratio(FX_RADIUS_RATIO, 8.0, 30.0);
		L_FX_CENTER += "z";
		LogDebug("*** phx FX_RADIUS_RATIO SCALE_RATIO /* TODO: $get_ground_height */ $get_ground_height(FX_CENTER) Z_ADJ");
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", L_FX_CENTER, "setup_flame_burst", "update_flame_burst");
		ScheduleDelayedEvent(2.1, "remove_fx");
		string LIGHT_RAD = FX_RADIUS;
		LIGHT_RAD *= 1.5;
		ClientEffect("light", "new", FX_CENTER, LIGHT_RAD, Vector3(255, 128, 64), 2.0);
		EmitSound3D(SOUND_BURST, 5, FX_CENTER);
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_flame_burst()
	{
	}

	void setup_flame_burst()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", SCALE_RATIO);
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
