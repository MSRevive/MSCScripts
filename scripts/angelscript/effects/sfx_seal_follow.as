#pragma context server

namespace MS
{

class SfxSealFollow : CGameScript
{
	string DO_GLOW;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_MODEL_OFS;
	string FX_OWNER;
	string GLOW_COLOR;
	string GLOW_RAD;
	string LIGHT_ID;
	string MODEL_NAME;
	int V_OFS;
	int V_OFS_DUCK;

	SfxSealFollow()
	{
		MODEL_NAME = "weapons/magic/seals.mdl";
		V_OFS = 0;
		V_OFS_DUCK = 0;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_MODEL_OFS = param3;
		DO_GLOW = param4;
		GLOW_COLOR = param5;
		GLOW_RAD = param6;
		LogDebug("*** seal_follow FX_OWNER FX_DURATION");
		string L_DURATION = FX_DURATION;
		L_DURATION += 1.0;
		L_DURATION("remove_fx");
		FX_ACTIVE = 1;
		ClientEffect("tempent", "model", MODEL_NAME, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "make_aura", "update_aura");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
		LIGHT_ID = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "exists"))) return;
		ClientEffect("light", LIGHT_ID, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void remove_fx()
	{
		LogDebug("**** seal_follow remove");
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void update_aura()
	{
		if (!(FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
		else
		{
			string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			string L_VOFS = V_OFS;
			L_POS += "z";
			if (/* TODO: $get_contents */ $get_contents(L_POS) != "empty")
			{
				L_POS += "z";
			}
			ClientEffect("tempent", "set_current_prop", "origin", L_POS);
		}
	}

	void make_aura()
	{
		LogDebug("*** make_aura");
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", FX_MODEL_OFS);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
