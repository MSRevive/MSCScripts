#pragma context client

namespace MS
{

class SfxSealWarning : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_END_TIME;
	string FX_LIGHT_ID;
	string FX_ORIGIN;
	string SEAL_BODY;
	string SEAL_COLOR;
	string SEAL_MODEL;
	int SEAL_PITCH;
	string SEAL_RAD;
	string SEAL_TYPE;

	SfxSealWarning()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		SEAL_TYPE = param2;
		SEAL_RAD = param3;
		SEAL_BODY = param4;
		FX_DURATION = param5;
		SEAL_PITCH = 100;
		FX_END_TIME = GetGameTime();
		FX_END_TIME += FX_DURATION;
		SetCallback("render", "enable");
		if (SEAL_TYPE == "fire")
		{
			SEAL_COLOR = Vector3(255, 0, 0);
		}
		else
		{
			if (SEAL_TYPE == "cold")
			{
				SEAL_COLOR = Vector3(128, 128, 255);
			}
			else
			{
				if (SEAL_TYPE == "lightning")
				{
					SEAL_COLOR = Vector3(255, 255, 0);
				}
				else
				{
					if (SEAL_TYPE == "poison")
					{
						SEAL_COLOR = Vector3(0, 255, 0);
					}
				}
			}
		}
		FX_DURATION("end_fx");
		FX_ACTIVE = 1;
		EmitSound3D("weapons/mine_charge.wav", 10, FX_ORIGIN, 0.8, 0, 120);
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal_warn", "update_seal_warn");
		ClientEffect("light", "new", FX_ORIGIN, 10, SEAL_COLOR, 0.1);
		FX_LIGHT_ID = "game.script.last_light_id";
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

	void setup_seal_warn()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 10);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_BODY);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
	}

	void update_seal_warn()
	{
		if ((FX_ACTIVE))
		{
			string L_RENDER_RATIO = (FX_END_TIME - GetGameTime());
			string L_RENDER_RATIO = (L_RENDER_RATIO / FX_DURATION);
			string L_RENDER_AMT = /* TODO: $ratio */ $ratio(L_RENDER_RATIO, 255, 10);
		}
		else
		{
			int L_RENDER_AMT = 0;
		}
		ClientEffect("tempent", "set_current_prop", "renderamt", L_RENDER_AMT);
	}

	void game_prerender()
	{
		string L_RENDER_RATIO = (FX_END_TIME - GetGameTime());
		string L_RENDER_RATIO = (L_RENDER_RATIO / FX_DURATION);
		string L_RENDER_RADIUS = /* TODO: $ratio */ $ratio(L_RENDER_RATIO, SEAL_RAD, 10);
		string L_RENDER_RADIUS = (L_RENDER_RADIUS * 1.11);
		ClientEffect("light", FX_LIGHT_ID, FX_ORIGIN, L_RENDER_RADIUS, SEAL_COLOR, 0.1);
	}

}

}
