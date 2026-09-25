#pragma context server

namespace MS
{

class Lstrike : CGameScript
{
	string CENTER_POINT;
	float DUR_CENTER;
	float DUR_SECONDARY;
	int IS_ACTIVE;
	int LBLAST_CUR_TARG;
	string LBLAST_LOOPCOUNT;
	string LBLAST_TARG1;
	string LBLAST_TARG2;
	string LBLAST_TARG3;
	string LBLAST_TARG4;
	string LBLAST_TARG5;
	string LBLAST_TARG6;
	string LBLAST_TARG7;
	string LBLAST_TARG8;
	string LBLAST_TARG9;
	string LBLAST_TARGETS;
	string MAX_CHILDREN;
	string MY_DMG;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string PVP_MODE;
	int SECONDARY_BEAMS_ON;

	Lstrike()
	{
		DUR_CENTER = 15.0;
		DUR_SECONDARY = 13.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		EmitSound(GetOwner(), 0, "magic/lightning_strike.wav", 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DMG = param2;
		MAX_CHILDREN = param3;
		StoreEntity("ent_expowner");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		PVP_MODE = "game.pvp";
		DropToFloor();
		ScheduleDelayedEvent(0.1, "summon_start");
	}

	void OnSpawn() override
	{
		SetName("Lightning Strike");
		SetInvincible(true);
		SetHealth(1);
		PLAYING_DEAD = 1;
		DropToFloor();
	}

	void summon_start()
	{
		string BEAP_TOP = GetMonsterProperty("origin");
		string BEAM_BOTTOM = GetMonsterProperty("origin");
		BEAM_BOTTOM = "z";
		SetEntityOrigin(GetOwner(), BEAM_BOTTOM);
		string SKY_HEIGHT = /* TODO: $get_sky_height */ $get_sky_height(BEAM_TOP);
		Vector3 BEAM_TOP = Vector3((GetMonsterProperty("origin")).x, (GetMonsterProperty("origin")).y, SKY_HEIGHT);
		Effect("beam", "point", "lgtning.spr", 200, BEAM_BOTTOM, BEAM_TOP, Vector3(255, 255, 0), 255, 100, DUR_CENTER);
		ClientEvent("new", "all", "effects/make_light", BEAM_BOTTOM, 128, Vector3(255, 255, 0), DUR_CENTER);
		CENTER_POINT = BEAM_BOTTOM;
		EmitSound(GetOwner(), 0, "weather/Storm_exclamation.wav", 10);
		IS_ACTIVE = 1;
		LBLAST_CUR_TARG = 0;
		ScheduleDelayedEvent(0.1, "damage_loop");
		ScheduleDelayedEvent(2.0, "start_secondary");
		DUR_CENTER("summon_end");
	}

	void start_secondary()
	{
		// TODO: getents any 1024
		if (getCount > 0)
		{
			LBLAST_LOOPCOUNT = 0;
			LBLAST_TARGETS = 0;
			for (int i = 0; i < getCount; i++)
			{
				lblast_mark_targets();
			}
		}
		SECONDARY_BEAMS_ON = 1;
	}

	void lblast_mark_targets()
	{
		LBLAST_LOOPCOUNT += 1;
		if (LBLAST_LOOPCOUNT == 1)
		{
			string CHECK_ENT = getEnt1;
		}
		if (LBLAST_LOOPCOUNT == 2)
		{
			string CHECK_ENT = getEnt2;
		}
		if (LBLAST_LOOPCOUNT == 3)
		{
			string CHECK_ENT = getEnt3;
		}
		if (LBLAST_LOOPCOUNT == 4)
		{
			string CHECK_ENT = getEnt4;
		}
		if (LBLAST_LOOPCOUNT == 5)
		{
			string CHECK_ENT = getEnt5;
		}
		if (LBLAST_LOOPCOUNT == 6)
		{
			string CHECK_ENT = getEnt6;
		}
		if (LBLAST_LOOPCOUNT == 7)
		{
			string CHECK_ENT = getEnt7;
		}
		if (LBLAST_LOOPCOUNT == 8)
		{
			string CHECK_ENT = getEnt8;
		}
		if (LBLAST_LOOPCOUNT == 9)
		{
			string CHECK_ENT = getEnt9;
		}
		if (!(GetRelationship(CHECK_ENT) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if (PVP_MODE == 0)
			{
			}
			if ((IsValidPlayer(CHECK_ENT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		LBLAST_TARGETS += 1;
		if (!(LBLAST_TARGETS <= MAX_CHILDREN)) return;
		string MBEAM_TARG = GetEntityOrigin(CHECK_ENT);
		string BEAM_GROUND = /* TODO: $get_ground_height */ $get_ground_height(MBEAM_TARG);
		MBEAM_TARG = "z";
		if (LBLAST_TARGETS == 1)
		{
			LBLAST_TARG1 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 2)
		{
			LBLAST_TARG2 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 3)
		{
			LBLAST_TARG3 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 4)
		{
			LBLAST_TARG4 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 5)
		{
			LBLAST_TARG5 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 6)
		{
			LBLAST_TARG6 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 7)
		{
			LBLAST_TARG7 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 8)
		{
			LBLAST_TARG8 = MBEAM_TARG;
		}
		if (LBLAST_TARGETS == 9)
		{
			LBLAST_TARG9 = MBEAM_TARG;
		}
		string SBEAM_SKY = /* TODO: $get_sky_height */ $get_sky_height(MBEAM_TARG);
		string SBEAM_TOP = MBEAM_TARG;
		SBEAM_TOP = "z";
		Effect("beam", "point", "lgtning.spr", 100, MBEAM_TARG, SBEAM_TOP, Vector3(255, 255, 0), 200, 100, DUR_SECONDARY);
		ClientEvent("new", "all", "effects/make_light", MBEAM_TARG, 96, Vector3(255, 255, 0), DUR_SECONDARY);
	}

	void damage_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "damage_loop");
		if ((SECONDARY_BEAMS_ON))
		{
			LBLAST_CUR_TARG += 1;
			if (LBLAST_CUR_TARG == 1)
			{
				if (!((BLAST_CHILD1 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG1, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD1 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 2)
			{
				if (!((BLAST_CHILD2 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG2, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD2 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 3)
			{
				if (!((BLAST_CHILD3 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG3, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD3 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 4)
			{
				if (!((BLAST_CHILD4 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG4, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD5 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 5)
			{
				if (!((BLAST_CHILD5 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG5, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD5 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 6)
			{
				if (!((BLAST_CHILD6 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG6, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD6 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 7)
			{
				if (!((BLAST_CHILD7 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG7, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD7 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 8)
			{
				if (!((BLAST_CHILD8 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG8, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD8 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG == 9)
			{
				if (!((BLAST_CHILD9 !is null)))
				{
				}
				SpawnNPC("monsters/summon/lstrike_child", LBLAST_TARG9, ScriptMode::Legacy); // params: MY_OWNER, MY_DMG, DUR_SECONDARY
				BLAST_CHILD9 = GetEntityIndex(m_hLastCreated);
			}
			if (LBLAST_CUR_TARG > 9)
			{
				SECONDARY_BEAMS_ON = 0;
			}
		}
		DoDamage(GetMonsterProperty("origin"), 128, MY_DMG, 1.0, 0.1);
	}

	void summon_end()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void debug_beam()
	{
		if (param3 == "PARAM3")
		{
			Vector3 BEAM_COLOR = Vector3(255, 0, 255);
		}
		if (param3 != "PARAM3")
		{
			string BEAM_COLOR = param3;
		}
		float BEAM_DURATION = 1.0;
		string BEAM_START = param1;
		if (param2 == "PARAM2")
		{
			string BEAM_END = BEAM_START;
		}
		if (param2 != "PARAM2")
		{
			string BEAM_END = param2;
		}
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "point", "laserbeam.spr", 20, BEAM_START, BEAM_END, BEAM_COLOR, 255, 0.7, BEAM_DURATION);
	}

}

}
