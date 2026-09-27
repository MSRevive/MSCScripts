#pragma context client

namespace MS
{

class SfxFlames : CGameScript
{
	string DO_GLOW;
	string FLAME_SPR;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_MODEL;
	string GLOW_COLOR;
	int GLOW_RAD;
	string IS_DARK;
	string LIGHT_ID;
	string MODEL_HEIGHT;
	string MODEL_WIDTH;
	string OFS_MAX;
	string OFS_MIN;

	SfxFlames()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 255, 128);
		FLAME_SPR = "fire1_fixed.spr";
	}

	void client_activate()
	{
		FX_MODEL = param1;
		FX_DURATION = param2;
		MODEL_HEIGHT = param3;
		DO_GLOW = param4;
		IS_DARK = param5;
		MODEL_WIDTH = param6;
		string L_MODEL_WIDTH = MODEL_WIDTH;
		if ((MODEL_WIDTH).findFirst(PARAM) == 0)
		{
			int L_MODEL_WIDTH = 32;
		}
		if (MODEL_WIDTH == 0)
		{
			int L_MODEL_WIDTH = 32;
		}
		L_MODEL_WIDTH *= 0.5;
		OFS_MAX = L_MODEL_WIDTH;
		OFS_MIN = /* TODO: $neg */ $neg(L_MODEL_WIDTH);
		FX_ACTIVE = 1;
		if ((DO_GLOW))
		{
			SetCallback("render", "enable");
			if ((IS_DARK))
			{
				GLOW_COLOR = Vector3(255, 0, 128);
			}
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
			LIGHT_ID = "game.script.last_light_id";
		}
		FX_DURATION("effect_die");
		drip_flames();
	}

	void drip_flames()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.4, "drip_flames");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_MODEL, "origin");
		SPR_POS += Vector3(Random(OFS_MIN, OFS_MAX), Random(OFS_MIN, OFS_MAX), Random(0, MODEL_HEIGHT));
		ClientEffect("tempent", "sprite", FLAME_SPR, SPR_POS, "setup_sprite1_flame");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (!(DO_GLOW)) return;
		string L_POS = /* TODO: $getcl */ $getcl(FX_MODEL, "origin");
		ClientEffect("light", LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void effect_die()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void setup_sprite1_flame()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(0.4, 0.6));
		ClientEffect("tempent", "set_current_prop", "framerate", 25);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-4, 4), Random(-4, 4), 0));
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		if ((IS_DARK))
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
			ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 0, 255));
		}
	}

}

}
