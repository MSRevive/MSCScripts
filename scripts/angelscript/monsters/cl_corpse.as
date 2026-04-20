#pragma context server

namespace MS
{

class ClCorpse : CGameScript
{
	string FX_ANGLES;
	string FX_BODY;
	string FX_FADE_START;
	string FX_NOBOUNCE;
	string FX_OWNER;
	string FX_SEQ;
	string FX_SKIN;

	void client_activate()
	{
		FX_OWNER = param1;
		string FX_MODEL = /* TODO: $getcl */ $getcl(FX_OWNER, "model");
		FX_SEQ = param2;
		FX_SKIN = param3;
		FX_BODY = param4;
		FX_NOBOUNCE = param5;
		FX_FADE_START = GetGameTime();
		FX_FADE_START += 10.0;
		FX_ANGLES = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		ClientEffect("tempent", "model", FX_MODEL, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_corpse");
		ScheduleDelayedEvent(18.0, "remove_script");
	}

	void remove_script()
	{
		RemoveScript();
	}

	void setup_corpse()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 15.0);
		ClientEffect("tempent", "set_current_prop", "body", FX_BODY);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", FX_SEQ);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "skin", FX_SKIN);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "frames", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "texture");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "angles", FX_ANGLES);
		if (FX_NOBOUNCE == 1)
		{
			ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		}
	}

}

}
