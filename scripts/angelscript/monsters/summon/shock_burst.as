#pragma context server

namespace MS
{

class ShockBurst : CGameScript
{
	int ANG_ADJ;
	string BEAM_COLOR;
	string BEAM_WIDTH;
	int BOLTS_DEFINED;
	int CUR_ANG;
	int CUR_RAD;
	string IS_ACTIVE;
	int LOOP_COUNT;
	string MY_DMG;
	string MY_OWNER;
	string MY_RADIUS;
	string NUM_BOLTS;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;

	ShockBurst()
	{
		const string SOUND_THUNDER = "weather/Storm_exclamation.wav";
		const int BOLT_HEIGHT = 512;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DMG = param2;
		MY_RADIUS = param3;
		NUM_BOLTS = param4;
		BEAM_COLOR = param5;
		BEAM_WIDTH = param6;
		if (BEAM_COLOR == "PARAM5")
		{
			BEAM_COLOR = Vector3(255, 255, 0);
		}
		if (BEAM_WIDTH == "PARAM6")
		{
			BEAM_WIDTH = 200;
		}
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		ANG_ADJ = 359;
		ANG_ADJ /= NUM_BOLTS;
		CUR_RAD = 5;
		CUR_ANG = 0;
		BOLTS_DEFINED = 0;
		ScheduleDelayedEvent(0.25, "define_bolts");
	}

	void OnSpawn() override
	{
		SetName("Lightning Blast");
		SetRace("hated");
		SetHealth(1);
		SetInvincible(true);
		PLAYING_DEAD = 1;
	}

	void define_bolts()
	{
		if (!(BOLTS_DEFINED < NUM_BOLTS)) return;
		BOLTS_DEFINED += 1;
		if (BOLTS_DEFINED <= NUM_BOLTS)
		{
			CUR_RAD += 2;
			CUR_ANG += 5;
			DL_ANG_ADJ += CUR_ANG;
			if (DL_ANG_ADJ > 359)
			{
				DL_ANG_ADJ -= 359;
			}
			string DBOLT_START = GetMonsterProperty("origin");
			DBOLT_START += /* TODO: $relpos */ $relpos(Vector3(0, DL_ANG_ADJ, 0), Vector3(0, CUR_RAD, 0));
			SpawnNPC("monsters/summon/shock_burst_child", DBOLT_START, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, BOLTS_DEFINED
			if (BOLTS_STRING != "BOLTS_STRING")
			{
				if (BOLTS_STRING.length() > 0) BOLTS_STRING += ";";
				BOLTS_STRING += GetEntityIndex(m_hLastCreated);
			}
			if (BOLTS_STRING == "BOLTS_STRING")
			{
				BOLTS_STRING = GetEntityIndex(m_hLastCreated);
			}
			ScheduleDelayedEvent(0.25, "define_bolts");
		}
		if (BOLTS_DEFINED == NUM_BOLTS)
		{
			IS_ACTIVE = 1;
			move_bolts();
			EmitSound(GetOwner(), 0, SOUND_THUNDER, 10);
		}
	}

	void move_bolts()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "move_bolts");
		CUR_RAD += 2;
		CUR_ANG += 5;
		LOOP_COUNT = 0;
		for (int i = 0; i < NUM_BOLTS; i++)
		{
			draw_bolts();
		}
		if (CUR_RAD >= MY_RADIUS)
		{
			end_summon();
		}
	}

	void draw_bolts()
	{
		string L_ANG_ADJ = LOOP_COUNT;
		L_ANG_ADJ *= ANG_ADJ;
		L_ANG_ADJ += CUR_ANG;
		if (L_ANG_ADJ > 359)
		{
			L_ANG_ADJ -= 359;
		}
		string BOLT_START = GetMonsterProperty("origin");
		BOLT_START += /* TODO: $relpos */ $relpos(Vector3(0, L_ANG_ADJ, 0), Vector3(0, CUR_RAD, 0));
		string BOLT_END = BOLT_START;
		BOLT_END += "z";
		Effect("beam", "point", "lgtning.spr", BEAM_WIDTH, BOLT_START, BOLT_END, BEAM_COLOR, 255, 100, 0.1);
		string BOLT_TO_MOVE = GetToken(BOLTS_STRING, LOOP_COUNT, ";");
		SetEntityOrigin(BOLT_TO_MOVE, BOLT_START);
		LOOP_COUNT += 1;
	}

	void end_summon()
	{
		IS_ACTIVE = 0;
		LOOP_COUNT = 0;
		remove_bolts_loop();
	}

	void remove_bolts_loop()
	{
		if (LOOP_COUNT < NUM_BOLTS)
		{
			ScheduleDelayedEvent(0.1, "remove_bolts_loop");
		}
		if (LOOP_COUNT == NUM_BOLTS)
		{
			ScheduleDelayedEvent(1.0, "remove_me");
		}
		string BOLT_TO_REMOVE = GetToken(BOLTS_STRING, LOOP_COUNT, ";");
		if (((BOLT_TO_REMOVE !is null)))
		{
			DeleteEntity(BOLT_TO_REMOVE);
		}
		LOOP_COUNT += 1;
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
