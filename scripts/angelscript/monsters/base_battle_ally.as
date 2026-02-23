#pragma context server

namespace MS
{

class BaseBattleAlly : CGameScript
{
	int ALLY_AS_UNSTUCK_ANG;
	int ALLY_FOLLOW_ON;
	int ALLY_FOLLOW_PLR_DIST;
	string ALLY_FOLLOW_PLR_ID;
	string ALLY_FPLAYER_LIST;
	string ALLY_FWD_JUMP_STR;
	int ALLY_IS_LEADER;
	string ALLY_JUMP_STR;
	string ALLY_NEXT_FAS_CHECK;
	string ALLY_NEXT_FOLLOW_CHECK;
	string ALLY_NEXT_REGEN;
	string ALLY_OLD_DIST;
	int ALLY_STUCK_COUNT;
	float CYCLE_TIME;
	int NO_STUCK_CHECKS;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_BATTLE_ALLY;
	int NPC_NO_PLAYER_DMG;

	BaseBattleAlly()
	{
		NPC_NO_PLAYER_DMG = 1;
		NPC_BATTLE_ALLY = 1;
		const int NPC_FIGHTS_NPCS = 1;
		SetSayTextRange(2048);
		NO_STUCK_CHECKS = 1;
		const string AI_NO_TARGET_STRING = "unset";
		NPC_ALLY_RESPONSE_RANGE = 4096;
		const int ALLY_MIN_DISTANCE = 42;
		const int ALLY_FOLLOW_CLOSE_DIST = 60;
		const int ALLY_FOLLOW_NORM_DIST = 128;
		const int ALLY_MOVE_AWAY_DIST = 64;
		ALLY_FOLLOW_PLR_DIST = 128;
		const float ALLY_REGEN_RATIO = 0.1;
		const int ALLY_MAX_JUMP_RANGE = 600;
		const string FREQ_ALLYJUMP = Random(4.0, 5.0);
		ALLY_STUCK_COUNT = 0;
		ALLY_AS_UNSTUCK_ANG = 0;
		const string ANIM_ALLY_JUMP = "jump";
		const string SOUND_ALLY_JUMP = "monsters/orc/attack1.wav";
		const int ALLY_JUMP_THRESHOLD = 150;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (!(ALLY_FOLLOW_ON)) return;
		string GAME_TIME = GetGameTime();
		CYCLE_TIME = 0.1;
		if (!(m_hAttackTarget == AI_NO_TARGET_STRING)) return;
		if (GAME_TIME > ALLY_NEXT_FAS_CHECK)
		{
			if ((IsEntityAlive(ALLY_FOLLOW_PLR_ID)))
			{
			}
			ALLY_NEXT_FAS_CHECK = GAME_TIME;
			ALLY_NEXT_FAS_CHECK += 0.5;
			ally_stuck_check();
		}
		if (GAME_TIME > ALLY_NEXT_REGEN)
		{
			if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
			{
			}
			string ALLY_REGEN_AMT = GetEntityMaxHealth(GetOwner());
			ALLY_REGEN_AMT *= ALLY_REGEN_RATIO;
			HealEntity(GetOwner(), ALLY_REGEN_AMT);
			ALLY_NEXT_REGEN = GAME_TIME;
			ALLY_NEXT_REGEN += 1.0;
		}
		if ((SUSPEND_AI)) return;
		if (!(GetPlayerCount() > 0)) return;
		if (GAME_TIME > ALLY_NEXT_FOLLOW_CHECK)
		{
			int FIND_NEW_FOLLOW = 1;
		}
		if (!(IsEntityAlive(ALLY_FOLLOW_PLR_ID)))
		{
			int FIND_NEW_FOLLOW = 1;
		}
		if ((FIND_NEW_FOLLOW))
		{
			if ("game.playersnb" > 0)
			{
			}
			ALLY_NEXT_FOLLOW_CHECK = GAME_TIME;
			ALLY_NEXT_FOLLOW_CHECK += 10.0;
			ALLY_FPLAYER_LIST = 0;
			GetAllPlayers(ALLY_FPLAYER_LIST);
			ALLY_FPLAYER_LIST = /* TODO: $sort_entlist */ $sort_entlist(ALLY_FPLAYER_LIST, "range");
			ALLY_FOLLOW_PLR_ID = GetToken(ALLY_FPLAYER_LIST, 0, ";");
		}
		if (!(IsEntityAlive(ALLY_FOLLOW_PLR_ID))) return;
		string L_ALLY_RANGE = GetEntityRange(ALLY_FOLLOW_PLR_ID);
		string L_ALLY_ORG = GetEntityOrigin(ALLY_FOLLOW_PLR_ID);
		int L_ALLY_RUN_RANGE = 200;
		if ((ALLY_IS_LEADER))
		{
			string L_ORG = GetEntityOrigin(GetOwner());
			string L_ALLY_RANGE = Distance(L_ORG, ALLY_LEADER_DEST);
			string L_ALLY_ORG = ALLY_LEADER_DEST;
			int L_ALLY_RUN_RANGE = 64;
		}
		if (GAME_TIME > NEXT_ALLYJUMP)
		{
			if (L_ALLY_RANGE < ALLY_MAX_JUMP_RANGE)
			{
			}
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARG_Z = (L_ALLY_ORG).z;
			if (!(ALLY_IS_LEADER))
			{
				TARG_Z -= 38;
			}
			string Z_DIFF = TARG_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > ALLY_JUMP_THRESHOLD)
			{
				ally_hop(Z_DIFF);
				NEXT_ALLYJUMP = GAME_TIME;
				NEXT_ALLYJUMP += FREQ_ALLYJUMP;
			}
		}
		if (L_ALLY_RANGE > L_ALLY_RUN_RANGE)
		{
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			SetMoveAnim(ANIM_WALK);
		}
		if (GetEntityRange(ALLY_FOLLOW_PLR_ID) > ALLY_MIN_DISTANCE)
		{
			if (!(ALLY_IS_LEADER))
			{
				SetMoveDest(ALLY_FOLLOW_PLR_ID);
			}
			else
			{
				if (GetGameTime() > ALLY_NEXT_LEADER_UPDATE)
				{
					ALLY_NEXT_LEADER_UPDATE = GetGameTime();
					ALLY_NEXT_LEADER_UPDATE += 0.5;
					string L_MOVE_DEST = GetEntityOrigin(ALLY_FOLLOW_PLR_ID);
					string L_TRACE_START = L_MOVE_DEST;
					string L_PLR_VIEW = GetEntityProperty(ALLY_FOLLOW_PLR_ID, "viewangles");
					L_MOVE_DEST += /* TODO: $relpos */ $relpos(L_PLR_VIEW, Vector3(0, 640, 0));
					string L_MOVE_DEST = TraceLine(L_TRACE_START, L_MOVE_DEST);
					L_MOVE_DEST = "z";
					string L_MY_WIDTH = GetEntityWidth(GetOwner());
					SetMoveDest(L_MOVE_DEST);
					ALLY_LEADER_DEST = L_MOVE_DEST;
					string L_ORG = GetEntityOrigin(GetOwner());
					if (Distance(L_MOVE_DEST, L_ORG) <= L_MY_WIDTH)
					{
						SetAngles("face.y");
					}
					if ((G_DEVELOPER_MODE))
					{
						string L_BEAM_Z = L_MOVE_DEST;
						L_BEAM_Z += "z";
						Effect("beam", "point", "lgtning.spr", 20, L_MOVE_DEST, L_BEAM_Z, Vector3(255, 0, 255), 200, 0, 0.2);
					}
				}
			}
		}
		else
		{
			SetMoveDest(ALLY_FOLLOW_PLR_ID);
		}
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		ALLY_NEXT_REGEN = GetGameTime();
		ALLY_NEXT_REGEN += 20.0;
	}

	void ally_follow_close()
	{
		ALLY_FOLLOW_PLR_DIST = ALLY_FOLLOW_CLOSE_DIST;
	}

	void ally_follow_normal()
	{
		ALLY_FOLLOW_PLR_DIST = ALLY_FOLLOW_NORM_DIST;
	}

	void ally_hop()
	{
		LogDebug("ally_hop");
		EmitSound(GetOwner(), 0, SOUND_ALLY_JUMP, 10);
		ALLY_JUMP_STR = param1;
		if (ALLY_JUMP_STR > 100)
		{
			ScheduleDelayedEvent(0.5, "ally_push_forward");
		}
		ALLY_JUMP_STR *= 5;
		npcatk_suspend_ai(1.0);
		if (!(ALLY_IS_LEADER))
		{
			ALLY_FWD_JUMP_STR = GetEntityRange(ALLY_FOLLOW_PLR_ID);
		}
		else
		{
			string L_ORG = GetEntityOrigin(GetOwner());
			ALLY_FWD_JUMP_STR = Distance(L_ORG, ALLY_LEADER_DEST);
			LogDebug("ally_hop fwd ALLY_FWD_JUMP_STR");
		}
		PlayAnim("critical", ANIM_ALLY_JUMP);
		ScheduleDelayedEvent(0.1, "ally_jump_boost");
	}

	void ally_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, ALLY_FWD_JUMP_STR, ALLY_JUMP_STR));
	}

	void ally_push_forward()
	{
		if (!(ALLY_IS_LEADER))
		{
			SetMoveDest(ALLY_FOLLOW_PLR_ID);
		}
		else
		{
			SetMoveDest(ALLY_LEADER_DEST);
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 110, 0));
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string GROUND_POS = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		MY_Z -= GROUND_POS;
		if (!(MY_Z > 20)) return;
		ScheduleDelayedEvent(0.1, "ally_push_forward");
	}

	void ally_stuck_check()
	{
		string MY_ORG = GetEntityOrigin(GetOwner());
		string MY_DEST = GetMonsterProperty("movedest.origin");
		string CUR_DIST = Distance(MY_ORG, MY_DEST);
		if (!(CUR_DIST >= GetMonsterProperty("movedest.prox"))) return;
		if (CUR_DIST >= ALLY_OLD_DIST)
		{
			if (ALLY_OLD_DIST != 0)
			{
			}
			ALLY_STUCK_COUNT += 1;
		}
		else
		{
			ALLY_STUCK_COUNT = 0;
			ALLY_AS_UNSTUCK_ANG = Random(-15.0, 15.0);
			ALLY_OLD_DIST = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ALLY_OLD_DIST = CUR_DIST;
		if (ALLY_STUCK_COUNT > 1)
		{
			LogDebug("fsorc_friendly_stuck_check no_progress");
			string MOVE_DEST = MY_ORG;
			npcatk_suspend_ai(Random(0.5, 1.0));
			ALLY_AS_UNSTUCK_ANG += 36;
			if (ALLY_AS_UNSTUCK_ANG > 359)
			{
				ALLY_AS_UNSTUCK_ANG = 0;
			}
			string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			MY_YAW += ALLY_AS_UNSTUCK_ANG;
			if (MY_YAW > 359)
			{
				MY_YAW = 0;
			}
			MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 200, 0));
			SetMoveDest(MOVE_DEST);
			ALLY_STUCK_COUNT = 0;
		}
	}

	void set_leader()
	{
		ALLY_IS_LEADER = 1;
		ALLY_FOLLOW_ON = 1;
		if (param1 == 0)
		{
			ALLY_IS_LEADER = 0;
		}
	}

	void set_follower()
	{
		ALLY_FOLLOW_ON = 1;
	}

}

}
