#pragma context client

namespace MS
{

class SfxMotionblurPerm : CGameScript
{
	string BLUR_ON;
	string MODEL_BODY_OFS;
	string param.ang;
	string sc.oldang;
	string sc.oldpos;
	string sfx.entidx;

	void client_activate()
	{
		sfx.entidx = param1;
		MODEL_BODY_OFS = param2;
		if (MODEL_BODY_OFS == "PARAM2")
		{
			MODEL_BODY_OFS = 0;
		}
		SetCallback("render", "enable");
		if (param3 != 1)
		{
			BLUR_ON = 1;
		}
	}

	void blur_off()
	{
		BLUR_ON = 0;
	}

	void blur_on()
	{
		BLUR_ON = 1;
	}

	void game_prerender()
	{
		if (!(BLUR_ON)) return;
		string l.pos = /* TODO: $getcl */ $getcl(sfx.entidx, "origin");
		if (sc.oldpos != l.pos)
		{
			param.ang = sc.oldang;
			createmodel(sc.oldpos);
			sc.oldpos = l.pos;
			sc.oldang = /* TODO: $getcl */ $getcl(sfx.entidx, "angles");
		}
	}

	void createmodel()
	{
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(sfx.entidx, "model"), param1, "setup_model");
	}

	void setup_model()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.15);
		ClientEffect("tempent", "set_current_prop", "angles", param.ang);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", MODEL_BODY_OFS);
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
