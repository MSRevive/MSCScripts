#pragma context server

namespace MS
{

class BaseLightningShield : CGameScript
{
	int LSHIELD_ACTIVE;
	string LSHIELD_CL_IDX;
	string LSHIELD_DURATION;
	int LSHIELD_FX_ON;
	string LSHIELD_NEXT_SCAN;
	string LSHIELD_NEXT_UPDATE;
	int LSHIELD_PASSIVE_ENABLE;
	string LSHIELD_TARGET;

	BaseLightningShield()
	{
		LSHIELD_PASSIVE_ENABLE = 1;
		const int LSHIELD_PASSIVE = 1;
		const int LSHIELD_RADIUS = 96;
		const int DMG_LSHIELD = 100;
		const int LSHIELD_REPELL_STRENGTH = 1000;
		const int LSHIELD_V_CENTER = 36;
		const int CHANNEL_ZAP_START = 3;
		const int CHANNEL_ZAP_LOOP = 1;
		const string LSHIELD_CLFX_SCRIPT = "effects/sfx_lightning_shield";
		const string LSHIELD_DMG_TYPE = "lightning_effect";
		const float LSHIELD_FREQ_UPDATE = 0.5;
		const string SOUND_ZAP_LOOP = "magic/bolt_loop.wav";
		const string SOUND_ZAP_START = "magic/bolt_end.wav";
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(LSHIELD_PASSIVE)) return;
		if (!(LSHIELD_PASSIVE_ENABLE)) return;
		if ((LSHIELD_ACTIVE)) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetGameTime() > LSHIELD_NEXT_SCAN)
			{
				lshield_scan();
			}
		}
		if (!(IsEntityAlive(LSHIELD_TARGET)))
		{
			lshield_passive_fx_off();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityRange(LSHIELD_TARGET) <= LSHIELD_RADIUS)
		{
			lshield_passive_zap_target();
		}
		else
		{
			lshield_passive_fx_off();
		}
	}

	void lshield_passive_zap_target()
	{
		if (!(LSHIELD_FX_ON))
		{
			lshield_passive_fx_start();
		}
		if (GetGameTime() > LSHIELD_NEXT_UPDATE)
		{
			LSHIELD_NEXT_UPDATE = GetGameTime();
			LSHIELD_NEXT_UPDATE += LSHIELD_FREQ_UPDATE;
			ClientEvent("update", "all", LSHIELD_CL_IDX, "lshield_on", 0.5);
		}
		DoDamage(LSHIELD_TARGET, "direct", DMG_LSHIELD, 1.0, GetOwner());
		string ZAP_TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(LSHIELD_TARGET, "lightning");
		string ZAP_ROLL = Random(0.0, 2.0);
		if (!(ZAP_ROLL < ZAP_TARG_RESIST)) return;
		string TARG_ORG = GetEntityOrigin(LSHIELD_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(LSHIELD_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, LSHIELD_REPELL_STRENGTH, 10)));
	}

	void lshield_passive_fx_start()
	{
		LSHIELD_FX_ON = 1;
		EmitSound(GetOwner(), CHANNEL_ZAP_LOOP, SOUND_ZAP_LOOP, 10);
		EmitSound(GetOwner(), CHANNEL_ZAP_START, SOUND_ZAP_START, 10);
		if (LSHIELD_CL_IDX == 0)
		{
			lshield_start_cl_fx(10.1);
		}
	}

	void lshield_passive_fx_off()
	{
		if (!(LSHIELD_FX_ON)) return;
		LSHIELD_FX_ON = 0;
		EmitSound(GetOwner(), CHANNEL_ZAP_LOOP, SOUND_ZAP_LOOP, 0);
	}

	void lshield_scan()
	{
		LSHIELD_NEXT_SCAN = GetGameTime();
		LSHIELD_NEXT_SCAN += 1.0;
		string LSHIELD_LIST = FindEntitiesInSphere("enemy", LSHIELD_RADIUS);
		if (!(LSHIELD_LIST != "none")) return;
		if (GetTokenCount(LSHIELD_LIST, ";") > 1)
		{
			ScrambleTokens(LSHIELD_LIST, ";");
		}
		LSHIELD_TARGET = GetToken(LSHIELD_LIST, 0, ";");
	}

	void lshield_start_cl_fx()
	{
		ClientEvent("new", "all", LSHIELD_CLFX_SCRIPT, GetEntityIndex(GetOwner()), LSHIELD_RADIUS, 10.0, LSHIELD_V_CENTER, 1);
		LSHIELD_CL_IDX = "game.script.last_sent_id";
		PARAM1("lshield_reset_fx");
	}

	void lshield_reset_fx()
	{
		LSHIELD_CL_IDX = 0;
	}

	void lshield_activate()
	{
		LSHIELD_ACTIVE = 1;
		LSHIELD_DURATION = param1;
		lshield_loop();
		LSHIELD_DURATION("lshield_toggle_off");
		LSHIELD_FX_ON = 1;
		EmitSound(GetOwner(), CHANNEL_ZAP_LOOP, SOUND_ZAP_LOOP, 10);
		EmitSound(GetOwner(), CHANNEL_ZAP_START, SOUND_ZAP_START, 10);
		if (LSHIELD_CL_IDX == 0)
		{
			lshield_start_active_cl_fx(LSHIELD_DURATION);
		}
	}

	void lshield_start_active_cl_fx()
	{
		ClientEvent("new", "all", LSHIELD_CLFX_SCRIPT, GetEntityIndex(GetOwner()), LSHIELD_RADIUS, LSHIELD_DURATION, LSHIELD_V_CENTER, 0);
	}

	void lshield_toggle_off()
	{
		LSHIELD_ACTIVE = 0;
		LSHIELD_FX_ON = 0;
		EmitSound(GetOwner(), CHANNEL_ZAP_LOOP, SOUND_ZAP_LOOP, 0);
		LogDebug("lshield_toggle_off");
	}

	void lshield_loop()
	{
		if (!(LSHIELD_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "lshield_loop");
		if (GetGameTime() > LSHIELD_NEXT_SCAN)
		{
			lshield_scan();
		}
		if (!(IsEntityAlive(LSHIELD_TARGET))) return;
		if (!(GetEntityRange(LSHIELD_TARGET) <= LSHIELD_RADIUS)) return;
		DoDamage(LSHIELD_TARGET, "direct", DMG_LSHIELD, 1.0, GetOwner());
		string ZAP_TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(LSHIELD_TARGET, "lightning");
		string ZAP_ROLL = Random(0.0, 2.0);
		LogDebug("lshield_loop ZAP_ROLL vs ZAP_TARG_RESIST");
		if (!(ZAP_ROLL < ZAP_TARG_RESIST)) return;
		string TARG_ORG = GetEntityOrigin(LSHIELD_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(LSHIELD_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, LSHIELD_REPELL_STRENGTH, 10)));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((LSHIELD_FX_ON))
		{
			EmitSound(GetOwner(), CHANNEL_ZAP_LOOP, SOUND_ZAP_LOOP, 0);
		}
	}

}

}
