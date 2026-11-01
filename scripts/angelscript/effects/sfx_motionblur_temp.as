#pragma context client

namespace MS
{

class SfxMotionblurTemp : CGameScript
{
	int BLUR_ON;
	string FX_DURATION;
	string MODEL_BODY_OFS;
	string MODEL_IDX;
	string MODEL_SKIN;
	string OLD_ANG;
	string OLD_POS;
	string PASS_ANG;

	void client_activate()
	{
		MODEL_IDX = param1;
		MODEL_BODY_OFS = param2;
		MODEL_SKIN = param3;
		FX_DURATION = param4;
		SetCallback("render", "enable");
		BLUR_ON = 1;
		FX_DURATION("end_fx");
	}

	void end_fx()
	{
		BLUR_ON = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(BLUR_ON)) return;
		string CUR_POS = /* TODO: $getcl */ $getcl(MODEL_IDX, "origin");
		if (OLD_POS != CUR_POS)
		{
			PASS_ANG = OLD_ANG;
			create_model(OLD_POS);
			OLD_POS = CUR_POS;
			OLD_ANG = /* TODO: $getcl */ $getcl(MODEL_IDX, "angles");
		}
		else
		{
			end_fx();
		}
	}

	void create_model()
	{
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(MODEL_IDX, "model"), param1, "setup_model");
	}

	void setup_model()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.15);
		ClientEffect("tempent", "set_current_prop", "angles", PASS_ANG);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", MODEL_BODY_OFS);
		ClientEffect("tempent", "set_current_prop", "skin", MODEL_SKIN);
		ClientEffect("tempent", "set_current_prop", "sequence", /* TODO: $getcl */ $getcl(MODEL_IDX, "sequence"));
		ClientEffect("tempent", "set_current_prop", "frame", /* TODO: $getcl */ $getcl(MODEL_IDX, "frame"));
	}

}

}
