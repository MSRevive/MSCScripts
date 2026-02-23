#pragma context server

namespace MS
{

class BaseSorcFriendly : CGameScript
{
	string AM_HUMILIATED;
	int BFSORC_DID_TELE;
	string BFSORC_GOING_TELE;
	int BFSORC_MOVE_TELE;
	float CYCLE_TIME;
	int FOLLOW_PLR_DIST;
	string FOLLOW_PLR_ID;
	string FPLAYER_LIST;
	int FSORC_DMG_POINTS;
	string FSORC_HIT_BY_BOSS;
	int FSORC_ON;
	float FSORC_TELE_HOME_DELAY;
	string FWD_JUMP_STR;
	int F_AS_UNSTUCK_ANG;
	int F_STUCK_COUNT;
	string NEXT_FAS_CHECK;
	string NEXT_FOLLOW_CHECK;
	string NEXT_REGEN;
	string NEXT_SORCJUMP;
	string NEXT_TEAM_ALERT;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_NO_PLAYER_DMG;
	string OLD_DIST;
	int REWARD_MODE;
	string SBOSS_ID;
	string SBOSS_ORG;
	string SETUP_QUALIFICATIONS;
	string SORC_FINAL_TELEDEST;
	string TC_HALF_AVG_DMG_PTS;
	int TC_QUAL_PLAYERS;
	string T_LEADER_ID;
	string T_SECOND_ID;
	string T_SHAMAN_ID;
	string UP_SORCJUMP_STR;
	int USER_QUALIFIES;
	int WAIT_MODE;
	string WAIT_POINT;
	string ZOMBIE_ID;

	BaseSorcFriendly()
	{
		NPC_NO_PLAYER_DMG = 1;
		const int NPC_BATTLE_ALLY = 1;
		const int NPC_FIGHTS_NPCS = 1;
		FOLLOW_PLR_DIST = 128;
		SetSayTextRange(4096);
		NO_STUCK_CHECKS = 1;
		FSORC_DMG_POINTS = 0;
		NPC_ALLY_RESPONSE_RANGE = 4096;
		const Vector3 TO_SBOSS_TELE_POINT = Vector3(512, 128, -16);
		F_STUCK_COUNT = 0;
		F_AS_UNSTUCK_ANG = 0;
		const int FSORC_DMG_REQ = 0;
	}

	void ext_fsorc_init()
	{
		FSORC_ON = 1;
	}

	void OnPostSpawn() override
	{
		SetMenuAutoOpen(0);
		ScheduleDelayedEvent(2.0, "fix_step_size");
	}

	void fix_step_size()
	{
		SetStepSize(48);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (!(FSORC_ON)) return;
		string GAME_TIME = GetGameTime();
		CYCLE_TIME = 0.1;
		if (m_hAttackTarget != "unset")
		{
			NO_STUCK_CHECKS = 0;
			if (!(WAIT_MODE))
			{
			}
			if (GAME_TIME > NEXT_TEAM_ALERT)
			{
			}
			NEXT_TEAM_ALERT = GAME_TIME;
			NEXT_TEAM_ALERT += 10.0;
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
				NPCATK_TARGET = "unset";
			}
			else
			{
				do_team_alert();
			}
		}
		if (!(m_hAttackTarget == "unset")) return;
		if (GAME_TIME > NEXT_FAS_CHECK)
		{
			NEXT_FAS_CHECK = GetGameTime();
			NEXT_FAS_CHECK += 0.5;
			fsorc_friendly_stuck_check();
		}
		if ((SUSPEND_AI)) return;
		if ((BFSORC_MOVE_TELE))
		{
			if (!(BFSORC_DID_TELE))
			{
			}
			if (!(BFSORC_GOING_TELE))
			{
			}
			string MY_ORG = GetEntityOrigin(GetOwner());
			if (Distance(MY_ORG, TO_SBOSS_TELE_POINT) < 600)
			{
			}
			BFSORC_GOING_TELE = 1;
			NO_STUCK_CHECKS = 0;
			fsorc_wait(TO_SBOSS_TELE_POINT);
		}
		if (GAME_TIME > NEXT_REGEN)
		{
			if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
			{
			}
			string REGEN_AMT = GetEntityMaxHealth(GetOwner());
			REGEN_AMT *= 0.1;
			HealEntity(GetOwner(), REGEN_AMT);
			NEXT_REGEN = GAME_TIME;
			NEXT_REGEN += 1.0;
		}
		if (!(GetPlayerCount() > 0)) return;
		if (GAME_TIME > NEXT_FOLLOW_CHECK)
		{
			int FIND_NEW_FOLLOW = 1;
		}
		if (!(IsEntityAlive(FOLLOW_PLR_ID)))
		{
			int FIND_NEW_FOLLOW = 1;
		}
		if ((FIND_NEW_FOLLOW))
		{
			NEXT_FOLLOW_CHECK = GAME_TIME;
			NEXT_FOLLOW_CHECK += 10.0;
			FPLAYER_LIST = 0;
			GetAllPlayers(FPLAYER_LIST);
			FPLAYER_LIST = /* TODO: $sort_entlist */ $sort_entlist(FPLAYER_LIST, "range");
			FOLLOW_PLR_ID = GetToken(FPLAYER_LIST, 0, ";");
		}
		if (GetEntityRange(FOLLOW_PLR_ID) > 200)
		{
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			SetMoveAnim(ANIM_WALK);
		}
		if (!(WAIT_MODE))
		{
			if (GetEntityRange(FOLLOW_PLR_ID) > 42)
			{
				SetMoveDest(FOLLOW_PLR_ID);
			}
			else
			{
				SetMoveDest(FOLLOW_PLR_ID);
			}
		}
		if ((WAIT_MODE))
		{
			SetMoveDest(WAIT_POINT);
		}
		if (!(GAME_TIME > NEXT_SORCJUMP)) return;
		LogDebug("jumprange SORC_MAX_JUMP_RANGE ANIM_SORCJUMP");
		if (!(GetEntityRange(FOLLOW_PLR_ID) < SORC_MAX_JUMP_RANGE)) return;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string TARG_Z = GetEntityProperty(FOLLOW_PLR_ID, "origin.z");
		TARG_Z -= 38;
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		if (Z_DIFF > ATTACK_RANGE)
		{
			sorc_hop_friendly(Z_DIFF);
			int EXIT_SUB = 1;
			NEXT_SORCJUMP = GAME_TIME;
			NEXT_SORCJUMP += FREQ_SORCJUMP;
		}
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		NEXT_REGEN = GetGameTime();
		NEXT_REGEN += 20.0;
	}

	void bfsorc_follow_close()
	{
		FOLLOW_PLR_DIST = 60;
	}

	void bfsorc_follow_normal()
	{
		FOLLOW_PLR_DIST = 128;
	}

	void sorc_hop_friendly()
	{
		EmitSound(GetOwner(), 0, "monsters/orc/attack1.wav", 10);
		UP_SORCJUMP_STR = param1;
		if (UP_SORCJUMP_STR > 100)
		{
			ScheduleDelayedEvent(0.5, "push_forward");
		}
		UP_SORCJUMP_STR *= 5;
		npcatk_suspend_ai(1.0);
		FWD_JUMP_STR = GetEntityRange(FOLLOW_PLR_ID);
		PlayAnim("critical", ANIM_SORCJUMP);
		ScheduleDelayedEvent(0.1, "sorc_jump_boost");
	}

	void push_forward()
	{
		SetMoveDest(FOLLOW_PLR_ID);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 110, 0));
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string GROUND_POS = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		MY_Z -= GROUND_POS;
		if (!(MY_Z > 20)) return;
		ScheduleDelayedEvent(0.1, "push_forward");
	}

	void fsorc_wait()
	{
		WAIT_MODE = 1;
		WAIT_POINT = param1;
	}

	void fsorc_unwait()
	{
		WAIT_MODE = 0;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		FSORC_DMG_POINTS += param2;
		if (FSORC_DMG_POINTS > 10000)
		{
			FSORC_DMG_POINTS = 10000;
		}
	}

	void OnDamage(int damage) override
	{
		if (param1 == SBOSS_ID)
		{
			FSORC_HIT_BY_BOSS = 1;
		}
		if (GetEntityRange(SBOSS_ID) < 256)
		{
			FSORC_HIT_BY_BOSS = 1;
		}
	}

	void fsorc_zombie_alert()
	{
		SetMoveAnim(ANIM_RUN);
		ZOMBIE_ID = param1;
		npcatk_settarget(ZOMBIE_ID);
		NPCATK_TARGET = ZOMBIE_ID;
		SetMoveDest(ZOMBIE_ID);
	}

	void ext_shadowform_boss()
	{
		SBOSS_ID = FindEntityByName("shadowform_boss");
		SBOSS_ORG = GetEntityOrigin(L_SBOSS_ID);
	}

	void fsorc_move_tele()
	{
		BFSORC_MOVE_TELE = 1;
	}

	void fsorc_did_tele()
	{
		BFSORC_DID_TELE = 1;
		BFSORC_MOVE_TELE = 0;
		ScheduleDelayedEvent(1.0, "fsorc_unwait");
	}

	void got_team_alert()
	{
		if ((WAIT_MODE)) return;
		if (!(m_hAttackTarget == "unset")) return;
		npcatk_settarget(m_hAttackTarget);
	}

	void do_team_alert()
	{
		T_SHAMAN_ID = FindEntityByName("fsorc_shaman");
		T_LEADER_ID = FindEntityByName("fsorc_leader");
		T_SECOND_ID = FindEntityByName("fsorc_second");
		if ((IsEntityAlive(T_SHAMAN_ID)))
		{
			if (T_SHAMAN_ID != GetEntityIndex(GetOwner()))
			{
			}
			CallExternal(T_SHAMAN_ID, "got_team_alert", m_hAttackTarget);
		}
		if ((IsEntityAlive(T_LEADER_ID)))
		{
			if (T_LEADER_ID != GetEntityIndex(GetOwner()))
			{
			}
			CallExternal(T_LEADER_ID, "got_team_alert", m_hAttackTarget);
		}
		if ((IsEntityAlive(T_SECOND_ID)))
		{
			if (T_SECOND_ID != GetEntityIndex(GetOwner()))
			{
			}
			CallExternal(T_SECOND_ID, "got_team_alert", m_hAttackTarget);
		}
	}

	void fsorc_friendly_stuck_check()
	{
		string MY_ORG = GetEntityOrigin(GetOwner());
		string MY_DEST = GetMonsterProperty("movedest.origin");
		string CUR_DIST = Distance(MY_ORG, MY_DEST);
		if (!(CUR_DIST >= GetMonsterProperty("movedest.prox"))) return;
		if (CUR_DIST >= OLD_DIST)
		{
			if (OLD_DIST != 0)
			{
			}
			F_STUCK_COUNT += 1;
		}
		else
		{
			F_STUCK_COUNT = 0;
			F_AS_UNSTUCK_ANG = Random(-15.0, 15.0);
			OLD_DIST = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		OLD_DIST = CUR_DIST;
		if (F_STUCK_COUNT > 1)
		{
			LogDebug("fsorc_friendly_stuck_check no_progress");
			string MOVE_DEST = MY_ORG;
			npcatk_suspend_ai(Random(0.5, 1.0));
			F_AS_UNSTUCK_ANG += 36;
			if (F_AS_UNSTUCK_ANG > 359)
			{
				F_AS_UNSTUCK_ANG = 0;
			}
			string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			MY_YAW += F_AS_UNSTUCK_ANG;
			if (MY_YAW > 359)
			{
				MY_YAW = 0;
			}
			MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 200, 0));
			SetMoveDest(MOVE_DEST);
			F_STUCK_COUNT = 0;
		}
	}

	void ext_boss_dead()
	{
		REWARD_MODE = 1;
		FOLLOW_PLR_DIST = 9999;
		SetMenuAutoOpen(1);
	}

	void reward_test()
	{
		FSORC_HIT_BY_BOSS = 1;
		FSORC_DMG_POINTS = 99999;
		ext_boss_dead();
	}

	void game_menu_getoptions()
	{
		if (!(REWARD_MODE)) return;
		if (FSORC_DMG_POINTS < FSORC_DMG_REQ)
		{
			AM_HUMILIATED = 1;
		}
		if (!(FSORC_HIT_BY_BOSS))
		{
			AM_HUMILIATED = 1;
		}
		if ((AM_HUMILIATED))
		{
			string reg.mitem.title = "Humiliated";
			string reg.mitem.type = "disabled";
			chat_now("Seeing my humiliation, being saved by humans, without my having lifted a finger to save myself, should be payment enough.", 3.0, "neigh", "add_to_que");
			ScheduleDelayedEvent(6.0, "ready_to_go");
		}
		if ((AM_HUMILIATED)) return;
		if (!(SETUP_QUALIFICATIONS))
		{
			SETUP_QUALIFICATIONS = 1;
			check_qualify();
		}
		string USER_PTS = GetEntityProperty(param1, "scriptvar");
		USER_QUALIFIES = 0;
		if (USER_PTS >= TC_HALF_AVG_DMG_PTS)
		{
			USER_QUALIFIES = 1;
		}
		LogDebug("check_qualify req: TC_HALF_AVG_DMG_PTS has USER_PTS [ USER_QUALIFIES ]");
		if ((USER_QUALIFIES))
		{
			give_reward_options(GetEntityIndex(param1));
		}
		else
		{
			chat_now("I would reward you, but I find your performance as a warrior, wanting.", 3.0, "neigh", "add_to_que");
		}
	}

	void check_qualify()
	{
		TC_QUAL_PLAYERS = 0;
		GetAllPlayers(TC_QUAL_PLAYERS);
		for (int i = 0; i < GetTokenCount(TC_QUAL_PLAYERS, ";"); i++)
		{
			tc_get_averages();
		}
		TC_AVG_DMG_PTS /= GetPlayerCount();
		TC_HALF_AVG_DMG_PTS = TC_AVG_DMG_PTS;
		TC_HALF_AVG_DMG_PTS *= 0.5;
	}

	void tc_get_averages()
	{
		string CUR_PLAYER = GetToken(TC_QUAL_PLAYERS, i, ";");
		TC_AVG_DMG_PTS += GetEntityProperty(CUR_PLAYER, "scriptvar");
	}

	void ready_to_go()
	{
		SetMenuAutoOpen(0);
		REWARD_MODE = 0;
		ready_to_go_comment();
		FSORC_TELE_HOME_DELAY("tele_home");
	}

	void tele_home()
	{
		string REPULSE_AOE = GetMonsterProperty("moveprox");
		REPULSE_AOE *= 1.5;
		SORC_FINAL_TELEDEST = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_repulse_burst", SORC_FINAL_TELEDEST, REPULSE_AOE, 1.0);
		npcatk_suspend_ai();
		DeleteEntity(GetOwner(), true); // fade out
	}

	void ready_to_go_comment()
	{
		T_SHAMAN_ID = FindEntityByName("fsorc_shaman");
		T_LEADER_ID = FindEntityByName("fsorc_leader");
		T_SECOND_ID = FindEntityByName("fsorc_second");
		FSORC_TELE_HOME_DELAY = 3.0;
		if (T_SHAMAN_ID == GetEntityIndex(GetOwner()))
		{
			FSORC_TELE_HOME_DELAY = 7.0;
			chat_now("With the beast slain dead, we may now return home...", 3.0, "add_to_que");
			chat_now("Maybe the Great Father Torkalath was wrong to forsake your kind.", 3.0, "warcry", "add_to_que");
		}
		if (T_LEADER_ID == GetEntityIndex(GetOwner()))
		{
			chat_now("The tale of your bravery shall not go untold among the Shadahar.", 3.0, "warcry", "add_to_que");
		}
		if (T_SECOND_ID == GetEntityIndex(GetOwner()))
		{
			chat_now("Thank you, once more, mighty warriors.", 3.0, "warcry", "add_to_que");
		}
	}

}

}
