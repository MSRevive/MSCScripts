#pragma context client

namespace MS
{

class SfxModelTest : CGameScript
{
	string FX_ORG;
	string MODEL_BODY_OFS;
	string MODEL_IDX;
	string MODEL_SKIN;

	void client_activate()
	{
		FX_ORG = param1;
		MODEL_IDX = param2;
		MODEL_BODY_OFS = param3;
		MODEL_SKIN = param4;
		create_model(MODEL_IDX);
		ScheduleDelayedEvent(20.0, "end_fx");
	}

	void end_fx()
	{
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void create_model()
	{
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(MODEL_IDX, "model"), FX_ORG, "setup_model");
	}

	void setup_model()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20.0);
		ClientEffect("tempent", "set_current_prop", "angles", /* TODO: $getcl */ $getcl(MODEL_IDX, "angles"));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 90);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", MODEL_BODY_OFS);
		ClientEffect("tempent", "set_current_prop", "skin", MODEL_SKIN);
		ClientEffect("tempent", "set_current_prop", "sequence", /* TODO: $getcl */ $getcl(MODEL_IDX, "sequence"));
		ClientEffect("tempent", "set_current_prop", "frame", /* TODO: $getcl */ $getcl(MODEL_IDX, "frame"));
	}

}

}
