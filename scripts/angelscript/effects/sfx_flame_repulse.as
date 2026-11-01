#pragma context server

namespace MS
{

class SfxFlameRepulse : CGameScript
{
	string FX_CENTER;

	void client_activate()
	{
		FX_CENTER = param1;
		ClientEffect("light", "new", FX_CENTER, 512, Vector3(255, 128, 64), 1.0);
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", FX_CENTER, "setup_repulse_burst", "update_repulse_burst");
		EmitSound3D("magic/boom.wav", 10, FX_CENTER);
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_repulse_burst()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (!(CUR_SCALE < 15)) return;
		CUR_SCALE += 0.5;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

	void setup_repulse_burst()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.5);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
	}

}

}
