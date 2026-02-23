#pragma context server

namespace MS
{

class BaseAntiStuck : CGameScript
{
	string AS_ATTACKING;
	int AS_CAN_MOVE;
	string AS_FLEE_POINT;
	int AS_HITBACK_FRUST;
	string AS_HITBACK_FRUST_RUNS;
	int AS_IN_RANGE_CLICKS;
	string AS_LAST_HIT;
	string AS_LAST_POS;
	string AS_LAST_POS_SET;
	string AS_LAST_STRIKE;
	int AS_MISS_COUNT;
	string AS_MOVEPROX;
	string AS_NEXT_CHECK;
	string AS_SPAWN_POINT;
	string AS_STARTED;
	string AS_TELE_OUT;
	string AS_TELE_POINT;
	int AS_UNSTUCK_ANG;
	string BAST_DID_INIT;
	string BAST_FIRST_TEST;
	string BAST_FWD;
	string BAST_ROT;
	string BAST_SPAWN_POS;
	string BAST_STUCK_DID_INIT;
	int BAST_TELEPORTING;
	string BAST_VFLOAT;
	string NEXT_HITFRUST_RECORD;
	string NO_SPAWN_STUCK_CHECK;
	int NPC_FORCED_MOVEDEST;
	int STUCK_COUNT;

	BaseAntiStuck()
	{
		const float AS_MAX_ATTACK_TIME = 3.0;
		const float AS_STUCK_FREQ = 0.25;
		const float AS_WIGGLE_DURATION = 2.0;
		const int AS_TELE_THRESH = 10;
		const int AS_CRITICAL_THRESH = 40;
		const int AS_DIST_THRESH = 1;
	}

	void OnSpawn() override
	{
		STUCK_COUNT = 0;
		AS_HITBACK_FRUST = 0;
		AS_UNSTUCK_ANG = 0;
		AS_IN_RANGE_CLICKS = 0;
		AS_MISS_COUNT = 0;
		if ((I_R_PET))
		{
			NO_SPAWN_STUCK_CHECK = 1;
		}
		if ((NO_SPAWN_STUCK_CHECK)) return;
		AS_SPAWN_POINT = GetMonsterProperty("origin");
		ScheduleDelayedEvent(1.0, "as_check_spawn_stuck");
	}

	void as_check_spawn_stuck()
	{
		AS_MOVEPROX = GetMonsterProperty("moveprox");
		if ((NO_SPAWN_STUCK_CHECK)) return;
	}

	void as_tell_allies_move()
	{
		string CUR_TARG = GetToken(AS_ALLY_LIST, i, ";");
		if (GetRelationship(GetOwner()) == "ally")
		{
			string L_AS_MOVEPROX = AS_MOVEPROX;
			L_AS_MOVEPROX /= 3;
			if (GetEntityRange(CUR_TARG) < L_AS_MOVEPROX)
			{
			}
			AS_TELE_OUT = 1;
			CallExternal(CUR_TARG, "as_ally_stuck_so_move", AS_SPAWN_POINT);
		}
		if (!(NPC_NO_AUTO_ACTIVATE))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			cycle_up("spawned_near_player");
		}
	}

	void as_tele_out()
	{
		if ((param2).findFirst(PARAM) == 0)
		{
			AS_TELE_POINT = GetEntityOrigin(GetOwner());
		}
		else
		{
			AS_TELE_POINT = param2;
		}
		string L_SCAN_RANGE = AS_MOVEPROX;
		L_SCAN_RANGE *= 2;
		// svplaysound: emitsound ent_me $get(ent_me,origin) AS_MOVEPROX PARAM1 danger L_SCAN_RANGE
		EmitSound(GetOwner(), GetEntityOrigin(GetOwner()), AS_MOVEPROX, param1, "danger", L_SCAN_RANGE);
		SetEntityOrigin(GetOwner(), Vector3(20000, 10000, -10000));
		PARAM1("as_tele_return");
	}

	void as_tele_return()
	{
		LogDebug("as_tele_return AS_TELE_POINT");
		SetEntityOrigin(GetOwner(), AS_TELE_POINT);
		ScheduleDelayedEvent(0.5, "as_check_spawn_stuck");
	}

	void as_ally_stuck_so_move()
	{
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai(3.0, "allystuck");
		}
		NPC_FORCED_MOVEDEST = 1;
		Vector3 TARGET_ORG = Vector3(0, 0, 0);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		npcatk_setmovedest(/* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)), 1);
		AS_FLEE_POINT = param1;
		ScheduleDelayedEvent(0.1, "as_flee_nudge");
	}

	void as_flee_nudge()
	{
		Vector3 TARGET_ORG = Vector3(0, 0, 0);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 200, 0)));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(AS_STARTED))
		{
			string L_SPAWN_TIME = NPC_SPAWN_TIME;
			L_SPAWN_TIME += 5.0;
			if (GetGameTime() > L_SPAWN_TIME)
			{
			}
			AS_STARTED = 1;
		}
		else
		{
			npcatk_anti_stuck();
		}
	}

	void npcatk_anti_stuck()
	{
		string GAME_TIME = GetGameTime();
		if (!(GAME_TIME > AS_NEXT_CHECK)) return;
		if ((NO_STUCK_CHECKS))
		{
			AS_LAST_POS_SET = 0;
			AS_NEXT_CHECK = GAME_TIME;
			AS_NEXT_CHECK += 3.0;
		}
		if ((NO_STUCK_CHECKS)) return;
		AS_NEXT_CHECK = GAME_TIME;
		AS_NEXT_CHECK += AS_STUCK_FREQ;
		if (!(NEW_AI))
		{
			string TARG_CHECK = HUNT_LASTTARGET;
		}
		else
		{
			string TARG_CHECK = m_hAttackTarget;
		}
		if (!(IsEntityAlive(TARG_CHECK))) return;
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		string LAST_ATK = AS_ATTACKING;
		LAST_ATK += AS_MAX_ATTACK_TIME;
		if (TARG_RANGE < ATTACK_HITRANGE)
		{
			int IN_RANGE = 1;
			AS_IN_RANGE_CLICKS += 1;
		}
		else
		{
			AS_IN_RANGE_CLICKS = 0;
		}
		if (AS_MISS_COUNT > 3)
		{
			if (!(NPC_RANGED))
			{
			}
			if ((IN_RANGE))
			{
			}
			if (GAME_TIME < LAST_ATK)
			{
			}
			LogDebug("anti-stuck can t reach)");
			chicken_run(1.0);
			AS_MISS_COUNT = 0;
		}
		if (!(GAME_TIME > LAST_ATK)) return;
		if ((I_R_FROZEN)) return;
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if ((NPC_WINKED_OUT)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(NPC_RANGED))
		{
			if ((IsEntityAlive(m_hAttackTarget)))
			{
				if (TARG_RANGE < ATTACK_RANGE)
				{
					int EXIT_SUB = 1;
				}
				if (TARG_RANGE < ATTACK_MOVERANGE)
				{
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
		}
		else
		{
			if ((NPC_CANSEE_TARGET))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (!(Distance(MY_ORG, GetMonsterProperty("movedest.origin")) >= GetMonsterProperty("movedest.prox"))) return;
		if (Distance(AS_LAST_POS, MY_ORG) < AS_DIST_THRESH)
		{
			if ((AS_LAST_POS_SET))
			{
			}
			LogDebug("anti-stuck no progress");
			STUCK_COUNT += 1;
			if (STUCK_COUNT >= 1)
			{
			}
			if (!(AS_FIRST_STUCK))
			{
				LogDebug("base_anti_stuck - first stuck");
				AS_FIRST_STUCK = 1;
				string L_ORG = GetEntityOrigin(GetOwner());
				string L_TESTPOS = L_ORG;
				SetEntityOrigin(GetOwner(), L_TESTPOS);
				string reg.npcmove.endpos = L_TESTPOS;
				reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 16, 0));
				int reg.npcmove.testonly = 1;
				NpcMove(GetOwner());
				if ("game.ret.npcmove.dist" == 0)
				{
					BAST_SPAWNCHECK = 1;
					as_tele_stuck_check();
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if ((AS_CUSTOM_UNSTUCK))
			{
				npc_stuck();
			}
			else
			{
				chicken_run(Random(0.5, 1.0));
			}
		}
		else
		{
			STUCK_COUNT = 0;
		}
		AS_LAST_POS = MY_ORG;
		AS_LAST_POS_SET = 1;
		if (STUCK_COUNT == AS_TELE_THRESH)
		{
			LogDebug("anti-stuck tele");
			if (!(I_R_PET))
			{
				ext_wink_out(MY_ORG, Random(4, 5));
			}
			STUCK_COUNT += 1;
		}
		if (!(STUCK_COUNT >= AS_CRITICAL_THRESH)) return;
		LogDebug("anti-stuck critical! tele home");
		if (!(I_R_PET))
		{
			ext_wink_out(NPC_SPAWN_LOC, Random(4, 5));
		}
		STUCK_COUNT = 0;
	}

	void npc_selectattack()
	{
		AS_ATTACKING = GetGameTime();
	}

	void game_dynamically_created()
	{
		NO_SPAWN_STUCK_CHECK = 1;
		if (!(AS_SUMMON_TELE_CHECK)) return;
		as_tele_stuck_check();
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		AS_LAST_HIT = GetGameTime();
		AS_MISS_COUNT = 0;
	}

	void game_dodamage()
	{
		if ((NO_STUCK_CHECKS)) return;
		if ((SUSPEND_AI)) return;
		if (!(param1))
		{
			AS_MISS_COUNT += 1;
		}
		else
		{
			AS_MISS_COUNT = 0;
			AS_HITBACK_FRUST = 0;
			AS_HITBACK_FRUST_RUNS = 0;
		}
		AS_LAST_STRIKE = GetGameTime();
	}

	void OnDamage(int damage) override
	{
		if ((NO_STUCK_CHECKS)) return;
		if ((SUSPEND_AI)) return;
		if (GetGameTime() > AS_ATTACKING)
		{
			if (GetGameTime() > NEXT_HITFRUST_RECORD)
			{
			}
			NEXT_HITFRUST_RECORD = GetGameTime();
			NEXT_HITFRUST_RECORD += 1.0;
			AS_HITBACK_FRUST += 1;
		}
		if (AS_HITBACK_FRUST >= 7)
		{
			string LS_PLUS5 = AS_LAST_STRIKE;
			LS_PLUS5 += 5.0;
			if (GetGameTime() > AS_LAST_STRIKE)
			{
			}
			AS_HITBACK_FRUST = 0;
			AS_HITBACK_FRUST_RUNS += 1;
			float MAX_RUN_TIME = 3.0;
			MAX_RUN_TIME *= AS_HITBACK_FRUST_RUNS;
			chicken_run(Random(1.0, MAX_RUN_TIME));
			LogDebug("anti-stuck hitback frust");
		}
	}

	void game_stuck()
	{
		LogDebug("game_stuck");
		if (!(G_DEVELOPER_MODE)) return;
		EmitSound(GetOwner(), 0, "amb/quest1.wav", 10);
	}

	void npcatk_setmovedest()
	{
		if (!(NPC_NO_AI)) return;
		SetMoveDest(param1);
	}

	void as_check_can_move()
	{
		AS_CAN_MOVE = 0;
		string reg.npcmove.endpos = GetEntityOrigin(GetOwner());
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 2));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" > 0)
		{
			AS_CAN_MOVE = 1;
		}
		if ((AS_CAN_MOVE)) return;
		string reg.npcmove.endpos = GetEntityOrigin(GetOwner());
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 2, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" > 0)
		{
			AS_CAN_MOVE = 1;
		}
		if ((AS_CAN_MOVE)) return;
		string reg.npcmove.endpos = GetEntityOrigin(GetOwner());
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 2));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" > 0)
		{
			AS_CAN_MOVE = 1;
		}
		if ((AS_CAN_MOVE)) return;
		string reg.npcmove.endpos = GetEntityOrigin(GetOwner());
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -2));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" > 0)
		{
			AS_CAN_MOVE = 1;
		}
		if ((AS_CAN_MOVE)) return;
		string reg.npcmove.endpos = GetEntityOrigin(GetOwner());
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, -2, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" > 0)
		{
			AS_CAN_MOVE = 1;
		}
		if ((AS_CAN_MOVE)) return;
	}

	void as_tele_stuck_check()
	{
		if (!(BAST_STUCK_DID_INIT))
		{
			BAST_STUCK_DID_INIT = 1;
			BAST_FIRST_TEST = 1;
			BAST_ROT = 0;
			BAST_FWD = 0;
			BAST_VFLOAT = 0;
			BAST_SPAWN_POS = GetEntityOrigin(GetOwner());
			if ((GetEntityProperty(GetOwner(), "fly")))
			{
				BAST_MOB_HEIGHT_ADJ = GetEntityHeight(GetOwner());
				BAST_MOB_HEIGHT_ADJ *= 1.1;
			}
		}
		string L_TESTPOS = BAST_SPAWN_POS;
		string L_VADJ = BAST_MOB_HEIGHT_ADJ;
		L_VADJ += BAST_VFLOAT;
		L_TESTPOS += /* TODO: $relpos */ $relpos(Vector3(0, BAST_ROT, 0), Vector3(0, BAST_FWD, BAST_VFLOAT));
		if ((G_DEVELOPER_MODE))
		{
			string L_TESTPOS_ADJ = L_TESTPOS;
			L_TESTPOS_ADJ += "z";
			Effect("beam", "point", "lgtning.spr", 20, L_TESTPOS, L_TESTPOS_ADJ, Vector3(255, 0, 255), 200, 0, 0.1);
		}
		SetEntityOrigin(GetOwner(), L_TESTPOS);
		string reg.npcmove.endpos = L_TESTPOS;
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 16, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner());
		if ("game.ret.npcmove.dist" == 0)
		{
			LogDebug("as_tele_stuck_check stuck @ BAST_FWD BAST_MOB_HEIGHT_ADJ L_TESTPOS");
			BAST_ROT += 15;
			BAST_FWD += 4;
			BAST_VFLOAT += 2;
			if (BAST_VFLOAT > 64)
			{
				BAST_VFLOAT = -64;
			}
			if (BAST_ROT > 359)
			{
				BAST_ROT = 0;
			}
			SetEntityOrigin(GetOwner(), BAST_SPAWN_POS);
			if (BAST_FWD < 640)
			{
				BAST_FIRST_TEST = 0;
				ScheduleDelayedEvent(0.1, "as_tele_stuck_check");
			}
			else
			{
				if ((BAST_SPAWNCHECK))
				{
					BAST_SPAWNCHECK = 0;
					return;
				}
				BAST_STUCK_DID_INIT = 0;
				BAST_PLAYER_LIST = "BAST_PLAYER_LIST";
				as_tele_to_player_loop();
			}
		}
		else
		{
			BAST_STUCK_DID_INIT = 0;
			STUCK_COUNT = 0;
			if (!(BAST_FIRST_TEST))
			{
			}
			SetEntityOrigin(GetOwner(), L_TESTPOS);
		}
	}

	void as_tele_to_player_loop()
	{
		BAST_TELEPORTING = 1;
		if (GetPlayerCount() == 0)
		{
			LogDebug("as_tele_to_player_loop noplayers");
			ScheduleDelayedEvent(20.0, "as_tele_to_player_loop");
			BAST_DID_INIT = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(BAST_DID_INIT))
		{
			LogDebug("as_tele_to_player_loop init");
			BAST_DID_INIT = 1;
			BAST_SPAWN_POS = GetEntityOrigin(GetOwner());
			if ((param1).findFirst(PARAM) == 0)
			{
				GetAllPlayers(BAST_PLAYER_LIST);
				BAST_PLAYER_LIST = /* TODO: $sort_entlist */ $sort_entlist(BAST_PLAYER_LIST, "range");
				BAST_TEST_PLAYER = GetToken(BAST_PLAYER_LIST, 0, ";");
			}
			else
			{
				BAST_TEST_PLAYER = param1;
			}
			if ((GetEntityProperty(GetOwner(), "fly")))
			{
				BAST_MOB_HEIGHT_ADJ = GetEntityHeight(GetOwner());
				BAST_MOB_HEIGHT_ADJ *= 1.1;
			}
			LogDebug("as_tele_to_player_loop init selecttarget GetEntityName(param1)");
		}
		BAST_ROT += 5;
		if (BAST_ROT > 359)
		{
			BAST_ROT = 0;
		}
		if ((NPC_TELEHUNT))
		{
			BAST_ROT = Random(0, 359.99);
		}
		string L_DIST = GetEntityWidth(GetOwner());
		L_DIST *= 2;
		if (L_DIST < 48)
		{
			int L_DIST = 48;
		}
		if ((NPC_TELEHUNT))
		{
			if ((NPC_RANGED))
			{
			}
			if ((NPC_BATTLE_ALLY))
			{
				if ((IsValidPlayer(BAST_TEST_PLAYER)))
				{
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			string L_DIST = Random(384, 768);
		}
		string L_TELE_POINT = GetEntityOrigin(BAST_TEST_PLAYER);
		L_TELE_POINT += /* TODO: $relpos */ $relpos(Vector3(0, BAST_ROT, 0), Vector3(0, L_DIST, BAST_MOB_HEIGHT_ADJ));
		if ((G_DEVELOPER_MODE))
		{
			string L_TELE_POINT_ADJ = L_TELE_POINT;
			L_TEST_POS_ADJ += "z";
			Effect("beam", "point", "lgtning.spr", 20, L_TELE_POINT, L_TELE_POINT_ADJ, Vector3(255, 0, 255), 200, 0, 0.1);
		}
		SetEntityOrigin(GetOwner(), L_TELE_POINT);
		string reg.npcmove.endpos = L_TELE_POINT;
		string L_MY_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_ANG, 0), Vector3(-16, 0, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner());
		if ("game.ret.npcmove.dist" == 0)
		{
			LogDebug("as_tele_to_player_loop stuck @ GetEntityName(BAST_TEST_PLAYER) L_DIST BAST_MOB_HEIGHT_ADJ L_TELE_POINT");
			SetEntityOrigin(GetOwner(), BAST_SPAWN_POS);
			if (!(IsEntityAlive(BAST_TEST_PLAYER)))
			{
				BAST_DID_INIT = 0;
				if ((NPC_TELEHUNT))
				{
					BAST_TELEPORTING = 0;
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			ScheduleDelayedEvent(0.1, "as_tele_to_player_loop");
		}
		else
		{
			LogDebug("as_tele_to_player_loop success , exiting");
			STUCK_COUNT = 0;
			BAST_DID_INIT = 0;
			BAST_TELEPORTING = 0;
			SetEntityOrigin(GetOwner(), L_TELE_POINT);
			if ((NPC_TELEHUNTER_FX))
			{
				if (NPC_TELEHUNTER_FX == 1)
				{
					string L_SCALE1 = GetEntityHeight(GetOwner());
					if (L_SCALE1 > 256)
					{
						int L_SCALE1 = 256;
					}
					string L_SCALE_RATIO = L_SCALE1;
					L_SCALE_RATIO /= 256;
					string L_SCALE1 = /* TODO: $ratio */ $ratio(L_SCALE_RATIO, 0.5, 3.0);
					string L_SCALE2 = /* TODO: $ratio */ $ratio(L_SCALE_RATIO, 1.0, 6.0);
					string L_LIGHT_RAD1 = /* TODO: $ratio */ $ratio(L_SCALE_RATIO, 64, 256);
					string L_LIGHT_RAD2 = /* TODO: $ratio */ $ratio(L_SCALE_RATIO, 128, 512);
					LogDebug("as_tele_to_player_loop L_SCALE_RATIO");
					ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", BAST_SPAWN_POS, "xflare1.spr", 20, L_SCALE1, Vector3(255, 255, 255), L_LIGHT_RAD1, "magic/teleport.wav");
					ClientEvent("new", "all", "effects/sfx_sprite_in_fancy", GetEntityOrigin(GetOwner()), "xflare1.spr", 20, L_SCALE2, Vector3(255, 255, 255), L_LIGHT_RAD2, "magic/spawn.wav");
				}
				else
				{
					if (NPC_TELEHUNTER_FX == 2)
					{
					}
					else
					{
						if (NPC_TELEHUNTER_FX > 2)
						{
							npc_teleport_fx(BAST_SPAWN_POS, GetEntityOrigin(GetOwner()));
						}
					}
				}
			}
			else
			{
				EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
			}
			npcatk_settarget(BAST_TEST_PLAYER);
			npc_teleported();
		}
	}

}

}
