#pragma context server

namespace MS
{

class SfxWave : CGameScript
{
	int CUR_JUMPS;
	int FX_ACTIVE;
	string FX_COLOR;
	float FX_DURATION;
	string FX_LEVEL;
	string FX_LIGHT_ID;
	int FX_LIGHT_OFS;
	string FX_LIGHT_POS;
	int FX_MODEL_BODY;
	string FX_ORIGIN;
	string FX_OWNER;
	int FX_RENDER_AMT;
	string FX_SCRIPT_ID;
	string FX_SKILL;
	int FX_SPEED;
	string FX_YAW;
	int TIMES_HEALED;

	SfxWave()
	{
		FX_DURATION = 20.0;
		CUR_JUMPS = 0;
		TIMES_HEALED = 1;
		FX_DURATION = 20.0;
		FX_LIGHT_OFS = -100;
	}

	void OnSpawn() override
	{
		SetName("Holy Wave");
		SetModel("null.mdl");
		SetInvincible(true);
		SetHeight(0);
		SetWidth(0);
		SetSolid("none");
		FX_DURATION("end_me_please");
		EmitSound(GetOwner(), 2, "magic/hburst_sco_lgrinholy01.wav", 10);
	}

	void game_dynamically_created()
	{
		FX_OWNER = param1;
		FX_YAW = param2;
		FX_LEVEL = param3;
		FX_SKILL = param4;
		FX_ORIGIN = GetEntityOrigin(GetOwner());
		FX_SPEED = 260;
		ClientEvent("new", "all", GetScriptName(GetOwner()), FX_ORIGIN, FX_YAW, FX_SPEED);
		FX_SCRIPT_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.5, "burst_fx");
	}

	void burst_fx()
	{
		string L_POS = FX_ORIGIN;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, FX_YAW, 0), Vector3(0, (FX_SPEED / 2), 0));
		string L_TRACE = TraceLine(FX_ORIGIN, L_POS);
		if (L_TRACE == L_POS)
		{
			FX_ORIGIN = L_POS;
			L_POS += "z";
			string L_DMG = FX_LEVEL;
			L_DMG *= 2;
			XDoDamage(L_POS, 128, L_DMG, 0, FX_OWNER, GetOwner(), FX_SKILL, "holy_effect", "dmgevent:*holywave");
			ClientEvent("update", "all", FX_SCRIPT_ID, "sfx_wave_explody");
			ScheduleDelayedEvent(0.5, "burst_fx");
		}
		else
		{
			end_me_please();
		}
	}

	void holywave_dodamage()
	{
		string L_RELATIONSHIP = GetRelationship(param2);
		if (L_RELATIONSHIP == "enemy")
		{
			int L_ENEMY = 1;
		}
		if (L_RELATIONSHIP == "wary")
		{
			int L_ENEMY = 1;
		}
		if ((IsValidPlayer(param2)))
		{
			if (!("game.pvp"))
			{
				int L_ENEMY = 0;
			}
		}
		if ((L_ENEMY))
		{
			if ((param1))
			{
			}
			string L_DOT = FX_LEVEL;
			L_DOT *= 0.5;
			ApplyEffect(param2, "effects/dot_holy", 5.0, FX_OWNER, L_DOT, FX_SKILL);
		}
		else
		{
			ce_wave_do_heal(GetEntityIndex(param2));
		}
	}

	void ce_wave_do_heal()
	{
		if (!(GetEntityHealth(param1) != GetEntityMaxHealth(param1))) return;
		int L_IS_ME = 0;
		int L_ADD_DMG_POINTS = 0;
		string L_DOT = FX_LEVEL;
		L_DOT *= 4;
		L_DOT /= TIMES_HEALED;
		TIMES_HEALED *= 2;
		Effect("glow", param1, Vector3(0, 255, 0), 256, 0.5, 0.5);
		if (GetEntityIndex(FX_OWNER) == GetEntityIndex(param1))
		{
			int L_IS_ME = 1;
		}
		if (GetEntityHealth(param1) < GetEntityMaxHealth(param1))
		{
			HealEntity(param1, L_DOT);
			if ((L_IS_ME))
			{
				SendColoredMessage(FX_OWNER, "Your holy wave heals you for " + int(L_DOT) + " hp");
			}
			else
			{
				SendColoredMessage(FX_OWNER, "You heal " + GetEntityName(param1) + "for " + int(L_DOT) + " hp");
				if ((IsValidPlayer(param1)))
				{
					int L_ADD_DMG_POINTS = 1;
					SendColoredMessage(param1, GetEntityName(FX_OWNER) + "heals you for " + int(L_DOT) + " hp");
				}
				else
				{
					if ((GetEntityProperty(param1, "scriptvar")))
					{
						int L_ADD_DMG_POINTS = 1;
					}
				}
			}
			if ((L_ADD_DMG_POINTS))
			{
				CallExternal(FX_OWNER, "add_dmg_points", L_DOT);
			}
		}
	}

	void end_me_please()
	{
		ClientEvent("update", "all", FX_SCRIPT_ID, "end_fx");
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_YAW = param2;
		FX_SPEED = param3;
		FX_RENDER_AMT = 180;
		FX_ACTIVE = 1;
		SetCallback("render", "enable");
		FX_COLOR = Vector3(200, 128, 0);
		FX_MODEL_BODY = 75;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "fx_wave_setup", "fx_wave_update", "fx_wave_collide");
		FX_LIGHT_POS = FX_ORIGIN;
		string L_FX_LIGHT_POS = FX_LIGHT_POS;
		L_FX_LIGHT_POS += /* TODO: $relpos */ $relpos(Vector3(0, FX_YAW, 0), Vector3(0, FX_LIGHT_OFS, 0));
		ClientEffect("light", "new", L_FX_LIGHT_POS, FX_RENDER_AMT, Vector3(255, 255, 255), 0.1);
		FX_LIGHT_ID = "game.script.last_light_id";
		trail_loop();
		FX_DURATION("end_fx");
	}

	void trail_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "trail_loop");
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_LIGHT_POS, "fx_trail_setup");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (FX_RENDER_AMT > 220)
		{
			Vector3 L_FX_COLOR = Vector3(255, 255, 255);
		}
		else
		{
			string L_FX_COLOR = FX_COLOR;
		}
		string L_FX_LIGHT_POS = FX_LIGHT_POS;
		L_FX_LIGHT_POS += /* TODO: $relpos */ $relpos(Vector3(0, FX_YAW, 0), Vector3(0, FX_LIGHT_OFS, 0));
		ClientEffect("light", FX_LIGHT_ID, L_FX_LIGHT_POS, FX_RENDER_AMT, L_FX_COLOR, 0.1);
	}

	void fx_wave_update()
	{
		if ((FX_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, FX_YAW, 0), Vector3(0, FX_SPEED, 0)));
			ClientEffect("tempent", "set_current_prop", "renderamt", FX_RENDER_AMT);
			if (FX_RENDER_AMT > 140)
			{
				FX_RENDER_AMT -= 5;
			}
			string L_MY_POS = "game.tempent.origin";
			FX_LIGHT_POS = L_MY_POS;
			if (OLD_POS == L_MY_POS)
			{
				end_fx();
				return;
			}
			else
			{
				OLD_POS = L_MY_POS;
			}
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, -20000));
		}
	}

	void fx_wave_collide()
	{
		end_fx();
	}

	void sfx_wave_explody()
	{
		FX_RENDER_AMT = 255;
		EmitSound3D("magic/hburst_sca_outholy01.wav", 5, OLD_POS, 0.8, 0, RandomInt(80, 120));
	}

	void fx_wave_setup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "body", FX_MODEL_BODY);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FX_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, FX_YAW, 0), Vector3(0, FX_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "framerate", 0.01);
		ClientEffect("tempent", "set_current_prop", "frames", 99999);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		float L_NEXT_UPDATE = GetGameTime();
		L_NEXT_UPDATE += 0.5;
		ClientEffect("tempent", "set_current_prop", "fuser1", L_NEXT_UPDATE);
	}

	void fx_trail_setup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "body", FX_MODEL_BODY);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FX_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, FX_YAW, 0), Vector3(0, 0.1, 0)));
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 0.01);
		ClientEffect("tempent", "set_current_prop", "frames", 99999);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

}

}
