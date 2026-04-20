#pragma context client

namespace MS
{

class SfxSfaura : CGameScript
{
	string CUR_SIZE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string GLOW_COLOR;
	int GLOW_RAD;
	float GROWTH_RATE;
	string LIGHT_ID;
	int MAX_GLOW_SIZE;
	float MAX_SIZE;
	int MIN_GLOW_SIZE;
	float MIN_SIZE;
	int V_OFS;
	int V_OFS_DUCK;

	SfxSfaura()
	{
		MIN_SIZE = 2.0;
		MAX_SIZE = 9.0;
		MIN_GLOW_SIZE = 64;
		MAX_GLOW_SIZE = 368;
		V_OFS = -34;
		V_OFS_DUCK = 24;
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 128, 64);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((FX_ACTIVE))
		{
		}
		if (CUR_SIZE < 1.0)
		{
			CUR_SIZE += GROWTH_RATE;
		}
		if (CUR_SIZE > 1.0)
		{
			LogDebug("*** sfaura_client_maxsize");
			CUR_SIZE = 1.0;
		}
	}

	void client_activate()
	{
		GROWTH_RATE = 0.015;
		if ((param4).findFirst(PARAM) == 0)
		{
			GROWTH_RATE = param4;
		}
		SetCallback("render", "enable");
		FX_OWNER = param1;
		CUR_SIZE = param2;
		FX_DURATION = param3;
		LogDebug("*** client_activate CUR_SIZE [ /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_GLOW_SIZE, MAX_GLOW_SIZE) ] [ /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_SIZE, MAX_SIZE) ]");
		FX_ACTIVE = 1;
		FX_DURATION("remove_fx");
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "make_aura", "update_aura");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_GLOW_SIZE, MAX_GLOW_SIZE), GLOW_COLOR, 1.0);
		LIGHT_ID = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		ClientEffect("light", LIGHT_ID, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_GLOW_SIZE, MAX_GLOW_SIZE), GLOW_COLOR, 1.0);
	}

	void remove_fx()
	{
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
			ClientEffect("tempent", "set_current_prop", "scale", /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_SIZE, MAX_SIZE));
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
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_SIZE, MAX_SIZE));
	}

}

}
