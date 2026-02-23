#pragma context client

namespace MS
{

class SfxRaura : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;

	SfxRaura()
	{
		const string MODEL_NAME = "weapons/projectiles.mdl";
		const int MODEL_OFS = 54;
		const int V_OFS = -34;
		const int V_OFS_DUCK = 24;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		LogDebug("*** client_activate FX_OWNER FX_DURATION");
		string L_DURATION = FX_DURATION;
		L_DURATION += 1.0;
		L_DURATION("remove_fx");
		string L_POS = GetEntityOrigin(FX_OWNER);
		FX_ACTIVE = 1;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", L_POS, "make_aura", "update_aura");
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
		LogDebug("*** make_aura");
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 54);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
