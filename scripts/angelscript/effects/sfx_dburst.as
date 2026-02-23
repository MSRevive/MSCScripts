#pragma context client

namespace MS
{

class SfxDburst : CGameScript
{
	string CUR_SIZE;
	int FX_ACTIVE;
	string FX_AOE;
	string FX_LIGHT_ID;
	string FX_LIGHT_RAD;
	string FX_ORIGIN;
	string MAX_SIZE;
	float MIN_SIZE;

	SfxDburst()
	{
		const string MODEL_NAME = "weapons/projectiles.mdl";
		const int MODEL_OFS = 74;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		if ((FX_ACTIVE))
		{
		}
		if (CUR_SIZE <= 1)
		{
		}
		CUR_SIZE += 0.02;
		if (CUR_SIZE > 1)
		{
			CUR_SIZE = 1;
		}
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_AOE = param2;
		FX_ACTIVE = 1;
		if ((param3))
		{
			if (FX_AOE > 100)
			{
				string L_SOUND = "magic/dburst_large_sdr_darkness.wav";
			}
			else
			{
				string L_SOUND = "magic/dburst_sdr_blackout.wav";
			}
			EmitSound3D(L_SOUND, 10, FX_ORIGIN);
		}
		MIN_SIZE = 0.1;
		MAX_SIZE = FX_AOE;
		MAX_SIZE /= 90;
		FX_LIGHT_RAD = /* TODO: $math(multiply) */ FX_AOE;
		SetCallback("render", "enable");
		ClientEffect("light", "new", FX_ORIGIN, FX_LIGHT_RAD, Vector3(255, 0, 255), 0.1);
		FX_LIGHT_ID = "game.script.last_light_id";
		CUR_SIZE = 0;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "make_aura", "update_aura");
		ScheduleDelayedEvent(2.0, "end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		ClientEffect("light", FX_LIGHT_ID, FX_ORIGIN, /* TODO: $ratio */ $ratio(CUR_SIZE, FX_LIGHT_RAD, 0), Vector3(255, 0, 255), 0.1);
		LogDebug("*** $currentscript update_light CUR_SIZE /* TODO: $ratio */ $ratio(CUR_SIZE, FX_LIGHT_RAD, 0)");
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

	void update_aura()
	{
		int L_REMOVE_AURA = 0;
		if (!(FX_ACTIVE))
		{
			int L_REMOVE_AURA = 1;
		}
		if (CUR_SIZE >= 1)
		{
			int L_REMOVE_AURA = 1;
		}
		if ((L_REMOVE_AURA))
		{
			if ((FX_ACTIVE))
			{
				end_fx();
			}
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "scale", /* TODO: $ratio */ $ratio(CUR_SIZE, MIN_SIZE, MAX_SIZE));
		}
	}

	void make_aura()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "body", MODEL_OFS);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
