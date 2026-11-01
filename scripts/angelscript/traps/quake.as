#pragma context server

namespace MS
{

class Quake : CGameScript
{
	string DMG_OWNER;
	string DO_EVENTS;
	string NO_DAMAGE;
	int NO_SLOW;
	int PLAYING_DEAD;
	int QUAKE_ACTIVE;
	int QUAKE_AOE;
	float QUAKE_DURATION;
	string QUAKE_END_TIME;
	int QUAKE_GLOBAL;
	string QUAKE_TARGS;
	string SOUND_QUAKE_LOOP;
	string SOUND_QUAKE_START;

	Quake()
	{
		QUAKE_AOE = 512;
		QUAKE_DURATION = 10.0;
		SOUND_QUAKE_START = "magic/volcano_start.wav";
		SOUND_QUAKE_LOOP = "magic/volcano_loop.wav";
	}

	void game_precache()
	{
		Precache("rockgibs.mdl");
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_QUAKE_START
		EmitSound(0, 0, SOUND_QUAKE_START);
		// svplaysound: svplaysound 0 0 SOUND_QUAKE_LOOP
		EmitSound(0, 0, SOUND_QUAKE_LOOP);
	}

	void OnSpawn() override
	{
		SetName("Earthquake");
		SetModel("null.mdl");
		SetHealth(1);
		SetWidth(1);
		SetHeight(1);
		SetInvincible(true);
		SetGravity(0);
		SetFly(true);
		SetBloodType("none");
		SetRace("hated");
		PLAYING_DEAD = 1;
		SetNoPush(true);
		ScheduleDelayedEvent(0.2, "do_quake");
	}

	void game_postspawn()
	{
		DO_EVENTS = param4;
		if (DO_EVENTS != "none")
		{
			handle_events();
		}
		if (param2 == 0)
		{
			NO_DAMAGE = 1;
		}
		else
		{
			SetDamageMultiplier(param2);
		}
	}

	void game_dynamically_created()
	{
		LogDebug("game_dynamically_created PARAM1 PARAM2 PARAM3 PARAM4");
		if (param1 == "events")
		{
			DO_EVENTS = param2;
			ScheduleDelayedEvent(0.1, "handle_events");
		}
		else
		{
			if ((IsEntityAlive(param1)))
			{
			}
			DMG_OWNER = param1;
			SetRace(GetEntityRace(DMG_OWNER));
		}
	}

	void handle_events()
	{
		for (int i = 0; i < GetTokenCount(DO_EVENTS, ";"); i++)
		{
			handle_events_loop();
		}
	}

	void handle_events_loop()
	{
		string CUR_IDX = i;
		string CUR_EVENT = GetToken(DO_EVENTS, CUR_IDX, ";");
		if (CUR_IDX < (GetTokenCount(DO_EVENTS, ";") - 1))
		{
			string PARAM_OUT = GetToken(DO_EVENTS, (CUR_IDX + 1), ";");
		}
		CUR_EVENT(PARAM_OUT);
	}

	void set_aoe()
	{
		LogDebug("set_aoe PARAM1");
		if (!((param1).findFirst(PARAM) == 0)) return;
		QUAKE_AOE = param1;
	}

	void set_dur()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		QUAKE_DURATION = param1;
		LogDebug("set_dur PARAM1 [ QUAKE_DURATION ]");
	}

	void set_global()
	{
		LogDebug("set_global");
		QUAKE_GLOBAL = 1;
	}

	void set_noslow()
	{
		NO_SLOW = 1;
	}

	void set_nodamage()
	{
		NO_DAMAGE = 1;
	}

	void do_quake()
	{
		QUAKE_ACTIVE = 1;
		LogDebug("do_quake QUAKE_DURATION");
		if (!(QUAKE_GLOBAL))
		{
			// svplaysound: svplaysound 1 10 SOUND_QUAKE_START 0.8 60
			EmitSound(1, 10, SOUND_QUAKE_START, 0.8, 60);
			// svplaysound: svplaysound 2 10 SOUND_QUAKE_LOOP 0.8 60
			EmitSound(2, 10, SOUND_QUAKE_LOOP, 0.8, 60);
			QUAKE_AOE = 256;
		}
		QUAKE_END_TIME = GetGameTime();
		QUAKE_END_TIME += QUAKE_DURATION;
		QUAKE_DURATION("quake_end");
		if (!(QUAKE_GLOBAL))
		{
			ScheduleDelayedEvent(0.1, "quake_loop");
			Effect("screenshake", GetEntityOrigin(GetOwner()), 50, 10, QUAKE_DURATION, (QUAKE_AOE * 1.5));
			ClientEvent("new", "all", "effects/sfx_quake", GetEntityIndex(GetOwner()), 1, QUAKE_AOE, QUAKE_DURATION);
		}
		else
		{
			CallExternal("players", "ext_quake_fx", QUAKE_DURATION, SOUND_QUAKE_START, SOUND_QUAKE_LOOP);
			ScheduleDelayedEvent(0.1, "global_quake_loop");
		}
	}

	void quake_loop()
	{
		if (!(QUAKE_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "quake_loop");
		QUAKE_TARGS = FindEntitiesInSphere("enemy", QUAKE_AOE);
		if (!(QUAKE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(QUAKE_TARGS, ";"); i++)
		{
			quake_applyeffect();
		}
	}

	void global_quake_loop()
	{
		if (!(QUAKE_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "quake_loop");
		if (!(GetPlayerCount() > 0)) return;
		GetAllPlayers(QUAKE_TARGS);
		if (!(QUAKE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(QUAKE_TARGS, ";"); i++)
		{
			quake_applyeffect();
		}
	}

	void quake_applyeffect()
	{
		string CUR_TARG = GetToken(QUAKE_TARGS, i, ";");
		if (!(IsOnGround(CUR_TARG))) return;
		string L_DMG = GetEntityMaxHealth(CUR_TARG);
		L_DMG *= 0.01;
		if ((NO_DAMAGE))
		{
			int L_DMG = 0;
		}
		if ((NO_SLOW)) return;
		if (!(QUAKE_GLOBAL))
		{
			ApplyEffect(CUR_TARG, "effects/effect_quake", GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), QUAKE_AOE, L_DMG, QUAKE_END_TIME, 0);
		}
		else
		{
			ApplyEffect(CUR_TARG, "effects/effect_quake", CUR_TARG, GetEntityIndex(GetOwner()), QUAKE_AOE, L_DMG, QUAKE_END_TIME, 0);
		}
	}

	void quake_end()
	{
		if (!(QUAKE_GLOBAL))
		{
			// svplaysound: if ( !QUAKE_GLOBAL ) svplaysound 2 0 SOUND_QUAKE_LOOP
			EmitSound(2, 0, SOUND_QUAKE_LOOP);
		}
		QUAKE_ACTIVE = 0;
	}

}

}
