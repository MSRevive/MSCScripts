#pragma context server

namespace MS
{

class ShadowFormBossFxCl : CGameScript
{
	int FX_ACTIVE;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		do_tracker_loop();
		do_smokes_loop();
		ScheduleDelayedEvent(30.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_smokes_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "do_smokes_loop");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows2", "update_shadows2");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows2", "update_shadows2");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows2", "update_shadows2");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment3");
		ClientEffect("tempent", "sprite", "shadowfog.spr", SPR_POS, "setup_shadows2", "update_shadows2");
	}

	void update_shadows2()
	{
		string CUR_FRAME = "game.tempent.fuser1";
		CUR_FRAME += 1;
		if (CUR_FRAME > 30)
		{
			int CUR_FRAME = 20;
		}
		ClientEffect("tempent", "set_current_prop", "frame", CUR_FRAME);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_FRAME);
		string CUR_SCALE = "game.tempent.fuser2";
		CUR_SCALE -= 0.01;
		if (CUR_SCALE <= 0.01)
		{
			int CUR_SCALE = 0;
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		}
		ClientEffect("tempent", "set_current_prop", "fuser2", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

	void setup_shadows2()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frame", 39);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.4, 0.6));
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "update", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 20);
		ClientEffect("tempent", "set_current_prop", "fuser2", 2.0);
	}

}

}
