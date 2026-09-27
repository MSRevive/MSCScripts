#pragma context server

namespace MS
{

class BaseSoccer : CGameScript
{
	int AM_DEFENSE;
	int AM_TEAM;
	string BALL_HOME;
	string BALL_ID;
	int BALL_OOMF;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	string BLUE_GOAL_LOC;
	int CHASE_RANGE;
	string DEF_MOVE_RANGE;
	int DRIBBLE_COUNT;
	int GOAL_RAD;
	string LAST_ON_GROUND;
	string NEXT_REGEN;
	string NME_GOAL_LOC;
	int NPC_CHASE_RANGE;
	int NPC_EXTRA_VALIDATIONS;
	int NPC_NO_MOVE;
	int NPC_RANGED;
	string OLD_BALL_ORG;
	string RED_GOAL_LOC;
	string SET_FINAL;
	int SPEED_DECREASED;
	int SPEED_INCREASED;
	string SUSPEND_AI;
	string TEAM_NAME;

	BaseSoccer()
	{
		BALL_ID = FindEntityByName("soccer_ball");
		if ((GetEntityProperty(BALL_ID, "scriptvar")))
		{
			SUSPEND_AI = 1;
		}
		NPC_EXTRA_VALIDATIONS = 1;
		GOAL_RAD = 124;
		CHASE_RANGE = 8000;
		NPC_CHASE_RANGE = 8000;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(2.0, "soccer_finalize");
		ScheduleDelayedEvent(0.5, "soc_spawn_stuck_check");
		SPEED_INCREASED = 0;
		SPEED_DECREASED = 0;
	}

	void soccer_finalize()
	{
		BALL_ID = FindEntityByName("soccer_ball");
		BALL_HOME = GetEntityProperty(BALL_ID, "scriptvar");
		BLUE_GOAL_LOC = FindEntityByName("blue_goal_ref");
		BLUE_GOAL_LOC = GetEntityOrigin(BLUE_GOAL_LOC);
		RED_GOAL_LOC = FindEntityByName("red_goal_ref");
		RED_GOAL_LOC = GetEntityOrigin(RED_GOAL_LOC);
		DEF_MOVE_RANGE = ATTACK_MOVERANGE;
		BALL_OOMF = 0;
		if (AM_TEAM == 1)
		{
			NME_GOAL_LOC = BLUE_GOAL_LOC;
		}
		else
		{
			NME_GOAL_LOC = RED_GOAL_LOC;
		}
		DRIBBLE_COUNT = 0;
		NPC_RANGED = 0;
		NPC_NO_MOVE = 1;
		if (AM_TEAM == 1)
		{
			string MY_NAME = "Red ";
		}
		else
		{
			string MY_NAME = "Blue ";
		}
		string NAME_SUFFIX = "Wingman";
		if ((AM_DEFENSE))
		{
			string NAME_SUFFIX = "Defender";
		}
		if ((AM_LEADER))
		{
			string NAME_SUFFIX = "Leader";
		}
		if ((AM_GOALIE))
		{
			string NAME_SUFFIX = "Goalkeeper";
		}
		MY_NAME += NAME_SUFFIX;
		SetName(MY_NAME);
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Remove ";
		reg.mitem.title += GetEntityName(GetOwner());
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_remove";
		int RESTORE_NORM_OPTION = 0;
		if ((SPEED_INCREASED))
		{
			int RESTORE_NORM_OPTION = 1;
		}
		if ((SPEED_DECREASED))
		{
			int RESTORE_NORM_OPTION = 1;
		}
		if ((RESTORE_NORM_OPTION))
		{
			string reg.mitem.title = "Restore Normal Speed";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_normal";
			string reg.mitem.title = "Set all ";
			reg.mitem.title += TEAM_NAME;
			reg.mitem.title += " Team Normal Speed";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_normal_all";
		}
		if (!(SPEED_INCREASED))
		{
			string reg.mitem.title = "Make Faster";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_faster";
			string reg.mitem.title = "Make All ";
			reg.mitem.title += TEAM_NAME;
			reg.mitem.title += " Team Faster";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_faster_all";
		}
		if (!(SPEED_DECREASED))
		{
			string reg.mitem.title = "Make Slower";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_slower";
			string reg.mitem.title = "Make All ";
			reg.mitem.title += TEAM_NAME;
			reg.mitem.title += " Team Slower";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_slower_all";
		}
	}

	void menu_faster()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " increased speed on a ";
		OUT_MSG += GetEntityName(GetOwner());
		SendInfoMsg("all", "ORC SPEED INCREASED " + OUT_MSG);
		make_faster();
	}

	void menu_faster_all()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " increased speed on all ";
		OUT_MSG += TEAM_NAME;
		OUT_MSG += " Team orcs";
		SendInfoMsg("all", "TEAM SPEED INCREASED " + OUT_MSG);
		make_faster();
		CallExternal("all", "extsorc_make_team_faster", AM_TEAM);
	}

	void extsorc_make_team_faster()
	{
		if (!(AM_TEAM == param1)) return;
		make_faster();
	}

	void make_faster()
	{
		PlayAnim("critical", ANIM_IDLE);
		SPEED_INCREASED = 1;
		SPEED_DECREASED = 0;
		SetAnimMoveSpeed(1.5);
		SetAnimFrameRate(1.5);
		BASE_MOVESPEED = 1.5;
		BASE_FRAMERATE = 1.5;
	}

	void menu_slower()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " reduced speed on a ";
		OUT_MSG += GetEntityName(GetOwner());
		SendInfoMsg("all", "ORC SPEED DECREASED " + OUT_MSG);
		make_slower();
	}

	void menu_slower_all()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " reduced speed on all ";
		OUT_MSG += TEAM_NAME;
		OUT_MSG += " Team orcs";
		SendInfoMsg("all", "TEAM SPEED DECREASED " + OUT_MSG);
		make_slower();
		CallExternal("all", "extsorc_make_team_slower", AM_TEAM);
	}

	void extsorc_make_team_slower()
	{
		if (!(AM_TEAM == param1)) return;
		make_slower();
	}

	void make_slower()
	{
		PlayAnim("critical", ANIM_IDLE);
		SPEED_INCREASED = 0;
		SPEED_DECREASED = 1;
		SetAnimMoveSpeed(0.5);
		SetAnimFrameRate(0.5);
		BASE_MOVESPEED = 0.5;
		BASE_FRAMERATE = 0.5;
	}

	void menu_remove()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, -20000, -10000));
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " removed a ";
		OUT_MSG += GetEntityName(GetOwner());
		OUT_MSG += " from the field.";
		SendInfoMsg("all", "ORC REMOVED FROM FIELD " + OUT_MSG);
		ScheduleDelayedEvent(0.1, "npc_suicide");
	}

	void menu_normal()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " restored normal speed on a ";
		OUT_MSG += GetEntityName(GetOwner());
		SendInfoMsg("all", "ORC SPEED DECREASED " + OUT_MSG);
		make_normal();
	}

	void menu_normal_all()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " restored normal speed on all ";
		OUT_MSG += TEAM_NAME;
		OUT_MSG += " Team orcs";
		SendInfoMsg("all", "TEAM SPEED DECREASED " + OUT_MSG);
		make_normal();
		CallExternal("all", "extsorc_make_team_normal", AM_TEAM);
	}

	void extsorc_make_team_normal()
	{
		if (!(AM_TEAM == param1)) return;
		make_normal();
	}

	void make_normal()
	{
		PlayAnim("critical", ANIM_IDLE);
		SPEED_INCREASED = 0;
		SPEED_DECREASED = 0;
		SetAnimMoveSpeed(1.0);
		SetAnimFrameRate(1.0);
		BASE_MOVESPEED = 1.0;
		BASE_FRAMERATE = 1.0;
	}

	void soc_spawn_stuck_check()
	{
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
		string reg.npcmove.endpos = NPC_HOME_LOC;
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 0, 16));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" <= 0)
		{
			LogDebug("soc_spawn_stuck_check blocked");
			SetEntityOrigin(GetOwner(), Vector3(5000, -5000, -5000));
			ScheduleDelayedEvent(1.0, "soc_spawn_stuck_check");
			if (GetGameTime() > NEXT_BALL_BLOCK_WARN)
			{
				SendInfoMsg("all", "ORC BLOCKED An orc is blocked...");
				NEXT_BALL_BLOCK_WARN = GetGameTime();
				NEXT_BALL_BLOCK_WARN += 10.0;
			}
		}
	}

	void setsoc_blue()
	{
		AM_TEAM = 2;
		SetProp(GetOwner(), "skin", 1);
		TEAM_NAME = "Blue";
	}

	void setsoc_red()
	{
		AM_TEAM = 1;
		SetProp(GetOwner(), "skin", 0);
		TEAM_NAME = "Red";
	}

	void setsoc_goalrad()
	{
		GOAL_RAD = param1;
	}

	void ext_soc_blue_remove()
	{
		if (!(AM_TEAM == 2)) return;
		npc_suicide();
	}

	void ext_soc_red_remove()
	{
		if (!(AM_TEAM == 1)) return;
		npc_suicide();
	}

	void setsoc_def()
	{
		AM_DEFENSE = 1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_REGEN)
		{
			NEXT_REGEN = GetGameTime();
			NEXT_REGEN += 1.0;
			if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
			{
			}
			string GIVE_AMT = GetEntityMaxHealth(GetOwner());
			GIVE_AMT *= 0.05;
			HealEntity(GetOwner(), GIVE_AMT);
		}
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if ((GetEntityProperty(BALL_ID, "scriptvar")))
		{
			SUSPEND_AI = 1;
		}
		else
		{
			string LAST_SUSPEND_PLUS5 = NPC_LAST_SUSPEND_AI;
			LAST_SUSPEND_PLUS5 += 5.0;
			if (GetGameTime() > LAST_SUSPEND_PLUS5)
			{
				npcatk_resume_ai();
			}
		}
		if ((GetEntityProperty(BALL_ID, "scriptvar"))) return;
		if (m_hAttackTarget == "unset")
		{
			if (!(AM_DEFENSE))
			{
				npcatk_settarget(BALL_ID);
			}
		}
		if ((IsOnGround(GetOwner())))
		{
			LAST_ON_GROUND = GetGameTime();
		}
		else
		{
			string LAST_ON_GROUND_PLUS = LAST_ON_GROUND;
			LAST_ON_GROUND_PLUS += 5.0;
			if (GetGameTime() > LAST_ON_GROUND_PLUS)
			{
				LAST_ON_GROUND = GetGameTime();
				LogDebug("in_air_too_long chicken_run");
				chicken_run(Random(3.0, 5.0));
			}
		}
		string BALL_ORG = GetEntityOrigin(BALL_ID);
		if ((AM_DEFENSE))
		{
			string BALL_HOME_X = (BALL_HOME).x;
			string DEST_X = (GetMonsterProperty("movedest.origin")).x;
			if (AM_TEAM == 1)
			{
				if (DEST_X > BALL_HOME_X)
				{
					ATTACK_MOVERANGE = 9999;
					MOVE_RANGE = 9999;
				}
				else
				{
					ATTACK_MOVERANGE = DEF_MOVE_RANGE;
					MOVE_RANGE = DEF_MOVE_RANGE;
				}
			}
			else
			{
				if (DEST_X < BALL_HOME_X)
				{
					ATTACK_MOVERANGE = 9999;
					MOVE_RANGE = 9999;
				}
				else
				{
					ATTACK_MOVERANGE = DEF_MOVE_RANGE;
					MOVE_RANGE = DEF_MOVE_RANGE;
				}
			}
		}
		if ((AM_GOALIE))
		{
			if (Distance(NPC_HOME_LOC, BALL_ORG) > GOAL_RAD)
			{
				string BALL_DIR = (BALL_ORG - NPC_HOME_LOC).Normalize();
				BALL_DIR *= GOAL_RAD;
				string MOVE_DEST = NPC_HOME_LOC;
				MOVE_DEST += BALL_DIR;
				MOVE_DEST = "z";
				SetMoveDest(MOVE_DEST);
			}
			else
			{
				SetMoveDest(BALL_ORG);
			}
			string MY_ORG = GetEntityOrigin(GetOwner());
			string DEST_ORG = GetMonsterProperty("movedest.origin");
			if (Distance(MY_ORG, DEST_ORG) < ATTACK_MOVERANGE)
			{
				string ANG_TO_BALL = /* TODO: $angles3d */ $angles3d(MY_ORG, BALL_ORG);
				SetAngles("face");
			}
		}
	}

	void soc_kickball()
	{
		if (AM_TEAM == 1)
		{
			string TARG_ORG = BLUE_GOAL_LOC;
			string MY_GOAL_LOC = RED_GOAL_LOC;
		}
		else
		{
			string TARG_ORG = RED_GOAL_LOC;
			string MY_GOAL_LOC = BLUE_GOAL_LOC;
		}
		string BALL_ORG = GetEntityOrigin(BALL_ID);
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (!(AM_GOALIE))
		{
			float BALL_FROM_GOAL = Distance(BALL_ORG, TARG_ORG);
			float MY_FROM_GOAL = Distance(MY_ORG, TARG_ORG);
			if (MY_FROM_GOAL < BALL_FROM_GOAL)
			{
				if ((IsOnGround(BALL_ID)))
				{
					if (GetGameTime() > NEXT_JUMP)
					{
					}
					NEXT_JUMP = GetGameTime();
					NEXT_JUMP += Random(1.0, 3.0);
					soc_jump_over_ball();
					int EXIT_SUB = 1;
				}
			}
		}
		else
		{
			float MY_FROM_MY_GOAL = Distance(MY_ORG, MY_GOAL_LOC);
			float BALL_FROM_MY_GOAL = Distance(BALL_ORG, MY_GOAL_LOC);
			if (BALL_FROM_MY_GOAL < MY_FROM_MY_GOAL)
			{
			}
			LogDebug("soc_kickball am_goalie break");
			PlayAnim("once", "break");
			PlayAnim("once", ANIM_SCOOP_BALL);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ANG = /* TODO: $angles */ $angles(BALL_ORG, TARG_ORG);
		if (!(AM_GOALIE))
		{
			string TRACE_START = BALL_ORG;
			TRACE_START += "z";
			string TRACE_END = TARG_ORG;
			TRACE_END += "z";
			string TRACE_DIR = (TRACE_END - TRACE_START).Normalize();
			TRACE_DIR *= 64;
			TRACE_START += TRACE_DIR;
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			int DRIBBLE_CHANCE = 10;
			if ((IsEntityAlive(TRACE_LINE)))
			{
				int DRIBBLE_CHANCE = 75;
				LogDebug("dribble_check GetEntityName(TRACE_LINE)");
			}
			if (RandomInt(1, 100) < DRIBBLE_CHANCE)
			{
				int DO_DRIBBLE = 1;
			}
		}
		float RND_F = Random(200, 400);
		float RND_V = Random(110, 200);
		int RND_LR = 0;
		if ((AM_LEADER))
		{
			RND_F *= 1.5;
			RND_V *= 1.5;
		}
		if ((DO_DRIBBLE))
		{
			DRIBBLE_COUNT += 1;
			if (DRIBBLE_COUNT == 1)
			{
				float RND_LR = Random(-300.0, -100.0);
			}
			if (DRIBBLE_COUNT == 2)
			{
				float RND_LR = Random(100, 300);
				DRIBBLE_COUNT = 0;
			}
			LogDebug("doing_dribble RND_LR");
		}
		string L_HITRANGE = ATTACK_RANGE;
		if ((NPC_VADJSTING))
		{
			int L_HITRANGE = 9999;
		}
		if (!(GetEntityRange(BALL_ID) < L_HITRANGE)) return;
		if (Distance(OLD_BALL_ORG, BALL_ORG) < 50)
		{
			if (!(AM_GOALIE))
			{
			}
			if (BALL_OOMF < 1)
			{
				BALL_OOMF = 1.0;
			}
			BALL_OOMF += 0.2;
			LogDebug("oomf_ball BALL_OOMF");
			RND_V *= BALL_OOMF;
			if (BALL_OOMF > 5)
			{
				LogDebug("ZOMGWTF oomf_ball");
				BALL_OOMF = 0;
				npcatk_flee(BALL_ID, 640, Random(3.5, 6.0));
			}
		}
		else
		{
			BALL_OOMF = 0;
		}
		OLD_BALL_ORG = BALL_ORG;
		CallExternal(BALL_ID, "ext_kicked");
		AddVelocity(BALL_ID, /* TODO: $relvel */ $relvel(Vector3(0, /* TODO: $vec.yaw */ $vec.yaw(TARG_ANG), 0), Vector3(RND_LR, RND_F, RND_V)));
	}

	void npc_selectattack()
	{
		string BALL_ORG = GetEntityOrigin(BALL_ID);
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (AM_TEAM == 1)
		{
			string TARG_ORG = BLUE_GOAL_LOC;
			string MY_GOAL_LOC = RED_GOAL_LOC;
		}
		else
		{
			string TARG_ORG = RED_GOAL_LOC;
			string MY_GOAL_LOC = BLUE_GOAL_LOC;
		}
		if ((AM_GOALIE))
		{
			float BALL_FROM_MY_GOAL = Distance(BALL_ORG, MY_GOAL_LOC);
			float MY_FROM_MY_GOAL = Distance(MY_ORG, MY_GOAL_LOC);
			if (BALL_FROM_MY_GOAL < MY_FROM_MY_GOAL)
			{
				if (Distance(NPC_HOME_LOC, MY_ORG) < GOAL_RAD)
				{
					if ((IsOnGround(BALL_ID)))
					{
						ANIM_ATTACK = ANIM_SCOOP_BALL;
					}
					else
					{
						ANIM_ATTACK = ANIM_KICK;
					}
				}
				else
				{
					ANIM_ATTACK = ANIM_KICK;
				}
			}
			else
			{
				ANIM_ATTACK = ANIM_KICK;
			}
		}
		else
		{
			float BALL_FROM_GOAL = Distance(BALL_ORG, TARG_ORG);
			float MY_FROM_GOAL = Distance(MY_ORG, TARG_ORG);
			if (MY_FROM_GOAL < BALL_FROM_GOAL)
			{
				if ((IsOnGround(BALL_ID)))
				{
					soc_jump_over_ball();
					int EXIT_SUB = 1;
				}
			}
		}
	}

	void extsoc_game_start()
	{
		if ((SET_FINAL))
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_RUN);
			SET_FINAL = 0;
		}
		npcatk_resume_ai();
		if ((AM_DEFENSE)) return;
		if ((AM_GOALIE)) return;
		npcatk_settarget(BALL_ID);
	}

	void extsoc_reset()
	{
		soc_stop_movement();
		npcatk_suspend_ai();
		extsoc_reset_loop();
	}

	void extsoc_reset_loop()
	{
		string CUR_POS = GetEntityOrigin(GetOwner());
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
		SetAngles("face");
		string reg.npcmove.endpos = NPC_HOME_LOC;
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 0, 16));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" <= 0)
		{
			LogDebug("extsoc_reset blocked");
			SetEntityOrigin(GetOwner(), CUR_POS);
			ScheduleDelayedEvent(0.1, "extsoc_reset_loop");
		}
	}

	void extsoc_pause_game()
	{
		soc_stop_movement();
		npcatk_suspend_ai();
	}

	void extsoc_unpause_game()
	{
		extsoc_game_start();
	}

	void extsoc_score()
	{
		soc_stop_movement();
		if (GetEntityProperty(BALL_ID, "scriptvar") == 5)
		{
			int GAME_OVER = 1;
		}
		if (GetEntityProperty(BALL_ID, "scriptvar") == 5)
		{
			int GAME_OVER = 1;
		}
		if ((GAME_OVER))
		{
			SET_FINAL = 1;
		}
		else
		{
			SET_FINAL = 0;
		}
		if (param1 == "red")
		{
			if (AM_TEAM == 1)
			{
				soc_round_win();
			}
			else
			{
				soc_round_lose();
			}
		}
		else
		{
			if (AM_TEAM == 2)
			{
				soc_round_win();
			}
			else
			{
				soc_round_lose();
			}
		}
	}

	void soc_round_win()
	{
		soc_stop_movement();
		if (RandomInt(1, 2) == 1)
		{
			PlayAnim("critical", ANIM_ROUND_WIN1);
			if ((SET_FINAL))
			{
				SetIdleAnim(ANIM_ROUND_WIN1);
				SetMoveAnim(ANIM_ROUND_WIN1);
			}
		}
		else
		{
			PlayAnim("critical", ANIM_ROUND_WIN2);
			if ((SET_FINAL))
			{
				SetIdleAnim(ANIM_ROUND_WIN2);
				SetMoveAnim(ANIM_ROUND_WIN2);
			}
		}
	}

	void soc_round_lose()
	{
		soc_stop_movement();
		if (RandomInt(1, 2) == 1)
		{
			PlayAnim("critical", ANIM_ROUND_LOST1);
			if ((SET_FINAL))
			{
				SetIdleAnim(ANIM_ROUND_LOST1);
				SetMoveAnim(ANIM_ROUND_LOST1);
			}
		}
		else
		{
			PlayAnim("critical", ANIM_ROUND_LOST2);
			if ((SET_FINAL))
			{
				SetIdleAnim(ANIM_ROUND_LOST2);
				SetMoveAnim(ANIM_ROUND_LOST2);
			}
		}
	}

	void soc_jump_over_ball()
	{
		PlayAnim("once", "break");
		npcatk_suspend_ai(1.0);
		SetMoveDest(BALL_ID);
		PlayAnim("critical", ANIM_JUMP);
	}

	void soc_stop_movement()
	{
		SetMoveDest("none");
		SetRoam(false);
	}

	void npcatk_setmovedest()
	{
		if ((IS_FLEEING))
		{
			SetMoveDest(param1);
		}
		if ((IS_FLEEING)) return;
		if ((AM_GOALIE)) return;
		if ((IsEntityAlive(param1)))
		{
			if (param1 == BALL_ID)
			{
			}
			int L_IS_BALL = 1;
			string PARAM1 = GetEntityOrigin(param1);
		}
		if ((L_IS_BALL))
		{
			if (AM_TEAM == 1)
			{
				PARAM1 += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, -40, 0));
			}
			else
			{
				PARAM1 += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 40, 0));
			}
		}
		if ((AM_DEFENSE))
		{
			string BALL_HOME_X = (BALL_HOME).x;
			if ((IsEntityAlive(param1)))
			{
				string DEST_X = GetEntityProperty(param1, "origin.x");
			}
			else
			{
				string DEST_X = (param1).x;
			}
			if (AM_TEAM == 1)
			{
				if (DEST_X > BALL_HOME_X)
				{
					if (GetEntityProperty(BALL_ID, "range2d") < 256)
					{
						int PARAM2 = 9999;
					}
					else
					{
						if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) > 32)
						{
							string PARAM1 = NPC_HOME_LOC;
							int PARAM2 = 16;
						}
						else
						{
							string PARAM1 = BALL_ID;
							int PARAM2 = 9999;
						}
					}
				}
			}
			else
			{
				if (DEST_X < BALL_HOME_X)
				{
					if (GetEntityProperty(BALL_ID, "range2d") < 256)
					{
						int PARAM2 = 9999;
					}
					else
					{
						if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) > 32)
						{
							string PARAM1 = NPC_HOME_LOC;
							int PARAM2 = 16;
						}
						else
						{
							string PARAM1 = BALL_ID;
							int PARAM2 = 9999;
						}
					}
				}
			}
		}
		SetMoveDest(param1);
	}

	void soc_ball_scoop()
	{
		int MADE_GRAB = 0;
		if (GetEntityRange(BALL_ID) < ATTACK_RANGE)
		{
			if ((IsOnGround(BALL_ID)))
			{
			}
			SetEntityOrigin(BALL_ID, /* TODO: $relpos */ $relpos(0, 0, -400));
			SetModelBody(1, 1);
			int MADE_GRAB = 1;
			SetMoveDest(NME_GOAL_LOC);
			npcatk_suspend_ai();
			npcatk_suspend_movement(ANIM_SCOOP_BALL);
		}
		if ((MADE_GRAB)) return;
		PlayAnim("once", "break");
	}

	void soc_ball_release()
	{
		npcatk_resume_movement();
		SetMoveDest(NME_GOAL_LOC);
		SetModelBody(1, 0);
		string BALL_RETURN_ORG = GetEntityOrigin(GetOwner());
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		BALL_RETURN_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, NPC_HALF_WIDTH, NPC_HEIGHT));
		SetEntityOrigin(BALL_ID, BALL_RETURN_ORG);
		SetVelocity(BALL_ID, /* TODO: $relvel */ $relvel(Vector3(0, MY_YAW, 0), Vector3(0, 300, 200)));
		npcatk_resume_ai();
	}

}

}
