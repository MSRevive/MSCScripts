#pragma context server

namespace MS
{

class RockStorm : CGameScript
{
	string CURRENT_TARGET;
	float DUR_SPIN;
	int FIRE_ROCK;
	string MY_BASE_DAMAGE;
	string MY_DISTANCE;
	string MY_JUMP_SIZE;
	string MY_OWNER;
	string MY_OWNER_POS;
	string MY_OWNER_RACE;
	string MY_VERTICAL;
	string NUMBER_ROCKS;
	string OWNER_GROUND;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int RAISE_COUNT;
	int RAISE_MAX;
	string ROCKA_ID;
	int ROCKA_OFS;
	string ROCKA_START;
	string ROCKB_ID;
	int ROCKB_OFS;
	string ROCKB_START;
	string ROCKC_ID;
	int ROCKC_OFS;
	string ROCKC_START;
	string ROCKD_ID;
	int ROCKD_OFS;
	string ROCKD_START;
	string ROCKS_CENTER;
	string ROCKS_CV;
	string ROCKS_THROWN;
	string ROCK_SCRIPT;
	string ROCK_TARGETS;
	string ROT_ADJ;
	string SOUND_LEVITATE;
	string SOUND_SPIN;
	string SOUND_SUMMON;
	string SPIN_COUNT;

	RockStorm()
	{
		ROCK_SCRIPT = "monsters/summon/rock";
		SOUND_LEVITATE = "fans/fan4on.wav";
		SOUND_SPIN = "magic/fan4_noloop.wav";
		DUR_SPIN = 1.74;
		SOUND_SUMMON = "magic/volcano_start.wav";
		ROCKA_OFS = 0;
		ROCKB_OFS = 90;
		ROCKC_OFS = 180;
		ROCKD_OFS = 270;
		RAISE_MAX = 20;
	}

	void OnSpawn() override
	{
		SetModel("null.mdl");
		SetInvincible(true);
		SetNoPush(true);
		SetWidth(1);
		SetHeight(1);
		SetSolid("none");
		PLAYING_DEAD = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_OWNER_POS = GetEntityOrigin(MY_OWNER);
		MY_OWNER_RACE = GetEntityRace(MY_OWNER);
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		NUMBER_ROCKS = param2;
		OWNER_GROUND = /* TODO: $get_ground_height */ $get_ground_height(MY_OWNER_POS);
		MY_BASE_DAMAGE = param3;
		MY_DISTANCE = param4;
		FIRE_ROCK = 0;
		if (param6 != "PARAM6")
		{
			FIRE_ROCK = 1;
		}
		LogDebug("game_dynamically_created owner GetEntityName(param1) org MY_OWNER_POS race MY_OWNER_RACE #rcks NUMBER_ROCKS dmg MY_BASE_DAMAGE dist MY_DISTANCE vert PARAM5 fire FIRE_ROCK");
		SetRace(MY_OWNER_RACE);
		string OWNER_X = (MY_OWNER_POS).x;
		string OWNER_Y = (MY_OWNER_POS).y;
		string OWNER_Z = (MY_OWNER_POS).z;
		MY_VERTICAL = OWNER_GROUND;
		MY_VERTICAL += param5;
		Vector3 TRACE_END = Vector3(OWNER_X, OWNER_Y, MY_VERTICAL);
		string TRACE_VERT = TraceLine(MY_OWNER_POS, TRACE_END);
		if (Distance(TRACE_VERT, TRACE_END) > 0)
		{
			MY_VERTICAL = (TRACE_VERT).z;
			Vector3 TRACE_END = Vector3(OWNER_X, OWNER_Y, MY_VERTICAL);
		}
		Vector3 MY_OWNER_GPOS = Vector3(OWNER_X, OWNER_Y, OWNER_GROUND);
		float DIST_TO_HOVER = Distance(MY_OWNER_GPOS, TRACE_END);
		MY_JUMP_SIZE = DIST_TO_HOVER;
		MY_JUMP_SIZE /= 20;
		ROCKS_CENTER = MY_OWNER_GPOS;
		ScheduleDelayedEvent(0.1, "rocks_begin");
	}

	void rocks_begin()
	{
		if (NUMBER_ROCKS >= 1)
		{
			ROCKA_START = ROCKS_CENTER;
			ROCKA_START += /* TODO: $relpos */ $relpos(Vector3(0, ROCKA_OFS, 0), Vector3(0, MY_DISTANCE, 0));
			SpawnNPC(ROCK_SCRIPT, ROCKA_START, ScriptMode::Legacy); // params: MY_OWNER, FIRE_ROCK
			ROCKA_ID = GetEntityIndex(m_hLastCreated);
		}
		if (NUMBER_ROCKS >= 2)
		{
			ScheduleDelayedEvent(0.1, "setup_rockb");
		}
		if (NUMBER_ROCKS >= 3)
		{
			ScheduleDelayedEvent(0.2, "setup_rockc");
		}
		if (NUMBER_ROCKS >= 4)
		{
			ScheduleDelayedEvent(0.25, "setup_rockd");
		}
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 255, 20, 3.0, 256);
		ScheduleDelayedEvent(0.2, "levitate_noise");
		RAISE_COUNT = 0;
		ScheduleDelayedEvent(0.3, "rocks_raise");
	}

	void setup_rockb()
	{
		ROCKB_START = ROCKS_CENTER;
		ROCKB_START += /* TODO: $relpos */ $relpos(Vector3(0, ROCKB_OFS, 0), Vector3(0, MY_DISTANCE, 0));
		SpawnNPC(ROCK_SCRIPT, ROCKB_START, ScriptMode::Legacy); // params: MY_OWNER, FIRE_ROCK
		ROCKB_ID = GetEntityIndex(m_hLastCreated);
	}

	void setup_rockc()
	{
		ROCKC_START = ROCKS_CENTER;
		ROCKC_START += /* TODO: $relpos */ $relpos(Vector3(0, ROCKC_OFS, 0), Vector3(0, MY_DISTANCE, 0));
		SpawnNPC(ROCK_SCRIPT, ROCKC_START, ScriptMode::Legacy); // params: MY_OWNER, FIRE_ROCK
		ROCKC_ID = GetEntityIndex(m_hLastCreated);
	}

	void setup_rockd()
	{
		ROCKD_START = ROCKS_CENTER;
		ROCKD_START += /* TODO: $relpos */ $relpos(Vector3(0, ROCKD_OFS, 0), Vector3(0, MY_DISTANCE, 0));
		SpawnNPC(ROCK_SCRIPT, ROCKD_START, ScriptMode::Legacy); // params: MY_OWNER, FIRE_ROCK
		ROCKD_ID = GetEntityIndex(m_hLastCreated);
	}

	void levitate_noise()
	{
		EmitSound(GetOwner(), 0, SOUND_LEVITATE, 10);
	}

	void rocks_raise()
	{
		RAISE_COUNT += 1;
		if (RAISE_COUNT == RAISE_MAX)
		{
			SPIN_COUNT = ROT_ADJ;
			ROCKS_THROWN = 0;
			rocks_spin();
			spin_noise();
			CURRENT_TARGET = "unset";
			if (NUMBER_ROCKS >= 1)
			{
				ScheduleDelayedEvent(4.5, "find_targets");
			}
			if (NUMBER_ROCKS >= 1)
			{
				ScheduleDelayedEvent(5.0, "rocka_throw");
			}
			CURRENT_TARGET = "unset";
			if (NUMBER_ROCKS >= 2)
			{
				ScheduleDelayedEvent(5.5, "find_targets");
			}
			if (NUMBER_ROCKS >= 2)
			{
				ScheduleDelayedEvent(6.0, "rockb_throw");
			}
			CURRENT_TARGET = "unset";
			if (NUMBER_ROCKS >= 3)
			{
				ScheduleDelayedEvent(6.5, "find_targets");
			}
			if (NUMBER_ROCKS >= 3)
			{
				ScheduleDelayedEvent(7.0, "rockc_throw");
			}
			CURRENT_TARGET = "unset";
			if (NUMBER_ROCKS >= 4)
			{
				ScheduleDelayedEvent(7.5, "find_targets");
			}
			if (NUMBER_ROCKS >= 4)
			{
				ScheduleDelayedEvent(8.0, "rockd_throw");
			}
			ScheduleDelayedEvent(9.5, "find_targets");
			ScheduleDelayedEvent(10.0, "force_all_rock_throw");
		}
		if (!(RAISE_COUNT < RAISE_MAX)) return;
		ScheduleDelayedEvent(0.1, "rocks_raise");
		ROT_ADJ = RAISE_COUNT;
		ROT_ADJ *= 10;
		ROCKS_CV = RAISE_COUNT;
		ROCKS_CV *= MY_JUMP_SIZE;
		if (NUMBER_ROCKS >= 1)
		{
			string ROCKA_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKA_OFS;
			ANG_ADJ += ROT_ADJ;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKA_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKA_ID, ROCKA_POS);
		}
		if (NUMBER_ROCKS >= 2)
		{
			string ROCKB_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKB_OFS;
			ANG_ADJ += ROT_ADJ;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKB_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKB_ID, ROCKB_POS);
		}
		if (NUMBER_ROCKS >= 3)
		{
			string ROCKC_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKC_OFS;
			ANG_ADJ += ROT_ADJ;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKC_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKC_ID, ROCKC_POS);
		}
		if (NUMBER_ROCKS >= 4)
		{
			string ROCKD_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKD_OFS;
			ANG_ADJ += ROT_ADJ;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKD_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKD_ID, ROCKD_POS);
		}
	}

	void spin_noise()
	{
		EmitSound(GetOwner(), 0, SOUND_SPIN, 10);
		if (!(ROCKS_THROWN < NUMBER_ROCKS)) return;
		DUR_SPIN("spin_noise");
	}

	void rocks_spin()
	{
		SPIN_COUNT += 10;
		if (SPIN_COUNT > 359)
		{
			SPIN_COUNT = 0;
		}
		if (ROCKS_THROWN == NUMBER_ROCKS)
		{
			remove_me();
		}
		if (!(ROCKS_THROWN < NUMBER_ROCKS)) return;
		ScheduleDelayedEvent(0.1, "rocks_spin");
		if (((ROCKA_ID !is null)))
		{
			string ROCKA_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKA_OFS;
			ANG_ADJ += SPIN_COUNT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKA_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKA_ID, ROCKA_POS);
		}
		if (((ROCKB_ID !is null)))
		{
			string ROCKB_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKB_OFS;
			ANG_ADJ += SPIN_COUNT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKB_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKB_ID, ROCKB_POS);
		}
		if (((ROCKC_ID !is null)))
		{
			string ROCKC_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKC_OFS;
			ANG_ADJ += SPIN_COUNT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKC_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKC_ID, ROCKC_POS);
		}
		if (((ROCKD_ID !is null)))
		{
			string ROCKD_POS = ROCKS_CENTER;
			string ANG_ADJ = ROCKD_OFS;
			ANG_ADJ += SPIN_COUNT;
			if (ANG_ADJ > 359)
			{
				ANG_ADJ -= 359;
			}
			ROCKD_POS += /* TODO: $relpos */ $relpos(Vector3(0, ANG_ADJ, 0), Vector3(0, MY_DISTANCE, ROCKS_CV));
			SetEntityOrigin(ROCKD_ID, ROCKD_POS);
		}
	}

	void find_targets()
	{
		if ((IsEntityAlive(CURRENT_TARGET))) return;
		CURRENT_TARGET = "unset";
		ROCK_TARGETS = FindEntitiesInSphere("enemy", 1024);
		ScrambleTokens(ROCK_TARGETS, ";");
		for (int i = 0; i < GetTokenCount(ROCK_TARGETS, ";"); i++)
		{
			pick_target();
		}
	}

	void pick_target()
	{
		string CUR_ENT = GetToken(ROCK_TARGETS, i, ";");
		if (!(IsEntityAlive(CUR_ENT))) return;
		if (!(GetRelationship(CUR_ENT) == "enemy")) return;
		CURRENT_TARGET = CUR_ENT;
		LogDebug("Selected_Target GetEntityName(CURRENT_TARGET)");
	}

	void rocka_throw()
	{
		CURRENT_TARGET = "unset";
		find_targets();
		check_targ();
		string TARGET_POS = GetEntityOrigin(CURRENT_TARGET);
		string ROCKA_POS = GetEntityOrigin(ROCKA_ID);
		string TRACE_FIRE = TraceLine(ROCKA_POS, TARGET_POS);
		if (TRACE_FIRE != TARGET_POS)
		{
			ScheduleDelayedEvent(0.5, "rocka_throw");
		}
		else
		{
			ROCKS_THROWN += 1;
			CallExternal(ROCKA_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
	}

	void rockb_throw()
	{
		CURRENT_TARGET = "unset";
		find_targets();
		check_targ();
		string TARGET_POS = GetEntityOrigin(CURRENT_TARGET);
		string ROCKB_POS = GetEntityOrigin(ROCKB_ID);
		string TRACE_FIRE = TraceLine(ROCKB_POS, TARGET_POS);
		if (TRACE_FIRE != TARGET_POS)
		{
			CURRENT_TARGET = "unset";
			find_targets();
			ScheduleDelayedEvent(0.5, "rockb_throw");
		}
		else
		{
			ROCKS_THROWN += 1;
			CallExternal(ROCKB_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
	}

	void rockc_throw()
	{
		CURRENT_TARGET = "unset";
		find_targets();
		check_targ();
		string TARGET_POS = GetEntityOrigin(CURRENT_TARGET);
		string ROCKC_POS = GetEntityOrigin(ROCKC_ID);
		string TRACE_FIRE = TraceLine(ROCKC_POS, TARGET_POS);
		if (TRACE_FIRE != TARGET_POS)
		{
			CURRENT_TARGET = "unset";
			find_targets();
			ScheduleDelayedEvent(0.5, "rockc_throw");
		}
		else
		{
			ROCKS_THROWN += 1;
			CallExternal(ROCKC_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
	}

	void rockd_throw()
	{
		CURRENT_TARGET = "unset";
		find_targets();
		check_targ();
		string TARGET_POS = GetEntityOrigin(CURRENT_TARGET);
		string ROCKD_POS = GetEntityOrigin(ROCKD_ID);
		string TRACE_FIRE = TraceLine(ROCKD_POS, TARGET_POS);
		if (TRACE_FIRE != TARGET_POS)
		{
			CURRENT_TARGET = "unset";
			find_targets();
			ScheduleDelayedEvent(0.5, "rockd_throw");
		}
		else
		{
			ROCKS_THROWN += 1;
			CallExternal(ROCKD_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
	}

	void force_all_rock_throw()
	{
		check_targ();
		if (((ROCKA_ID !is null)))
		{
			CallExternal(ROCKA_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
		if (((ROCKB_ID !is null)))
		{
			CallExternal(ROCKB_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
		if (((ROCKC_ID !is null)))
		{
			CallExternal(ROCKC_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
		if (((ROCKD_ID !is null)))
		{
			CallExternal(ROCKD_ID, "toss_rock", CURRENT_TARGET, MY_BASE_DAMAGE);
		}
		ROCKS_THROWN = NUMBER_ROCKS;
	}

	void remove_me()
	{
		CallExternal(MY_OWNER, "ext_rock_storm_end");
		ScheduleDelayedEvent(0.1, "remove_me2");
	}

	void remove_me2()
	{
		DeleteEntity(GetOwner());
	}

	void check_targ()
	{
		if ((IsEntityAlive(CURRENT_TARGET))) return;
		LogDebug("rock_storm check_targ GetEntityName(CURRENT_TARGET) is invalid , using alternate");
		if ((OWNER_ISPLAYER))
		{
			CURRENT_TARGET = GetEntityProperty(MY_OWNER, "target");
		}
		if (!(OWNER_ISPLAYER))
		{
			CURRENT_TARGET = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		if (!(IsEntityAlive(CURRENT_TARGET)))
		{
			CURRENT_TARGET = GetEntityProperty(MY_OWNER, "scriptvar");
		}
	}

}

}
