#pragma context server

namespace MS
{

class AfflictionLanceCl : CGameScript
{
	string CLOUD_VEL;
	string END_TIME;
	int FX_ACTIVE;
	int FX_ANGS;
	string FX_DURATION;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		FX_ANGS = 0;
		END_TIME = (GetGameTime() + FX_DURATION);
		fx_loop();
	}

	void end_fx()
	{
		SetRepeatDelay(1.0);
		if (!(GetGameTime() >= END_TIME)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "fx_loop");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string VEL_PITCH = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.pitch");
		string VEL_ROLL = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.roll");
		VEL_PITCH -= 90;
		SPR_POS += "z";
		CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(VEL_PITCH, FX_ANGS, VEL_ROLL), Vector3(0, 150, 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", SPR_POS, "setup_cloud", "update_cloud");
		SPR_POS += "z";
		CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(VEL_PITCH, FX_ANGS, 0), Vector3(0, -150, 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", SPR_POS, "setup_cloud", "update_cloud");
		FX_ANGS += 10;
		if (!(FX_ANGS > 359)) return;
		FX_ANGS = 0;
	}

	void update_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		CUR_SCALE += 0.01;
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "renderamt", 150);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void keep_on()
	{
		END_TIME = (GetGameTime() + FX_DURATION);
	}

}

}
