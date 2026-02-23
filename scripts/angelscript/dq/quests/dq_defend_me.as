#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqDefendMe : CGameScript
{
	int DQ_MONSTERS_AVAILABLE;
	int DQ_MONSTERS_KILLED;
	string MONSTER_ORIGIN_AMT;

	DqDefendMe()
	{
		const string DQ_DEFEND_ME_DEFENSE_POINT = GetEntityOrigin(GetOwner());
		const string DQ_MONSTER_LIST = QUEST_DATA1;
		const string DQ_MONSTER_LIMIT = GetToken(QUEST_DATA2, 0, ";");
		const string DQ_SELF_ADJUST = GetToken(QUEST_DATA2, 1, ";");
		const string DQ_SPAWN_POINTS = QUEST_DATA3;
		const float DQ_MONSTER_HP_MULT = 0.5;
		const float DQ_MONSTER_XP_MULT = 0.5;
		const float DQ_MONSTER_SPAWN_TIME = 2.0;
		DQ_MONSTERS_AVAILABLE = 5;
		DQ_MONSTERS_KILLED = 0;
	}

	void quest_activate()
	{
		DQ_MONSTER_SPAWN_TIME("populate_area");
		SetInvincible(false);
		SetRace("human");
		if (DQ_SPAWN_POINTS != "random")
		{
			quest_begin_handle_origins();
		}
	}

	void quest_begin_handle_origins()
	{
		array<string> MONSTER_SPAWN_ORIGINS;
		string L_INFO_TARGET_NAME = DQ_SPAWN_POINTS;
		L_INFO_TARGET_NAME += "1";
		string L_INFO_TARGET_ID = FindEntityByName(L_INFO_TARGET_NAME);
		if (((L_INFO_TARGET_ID !is null)))
		{
			quest_handle_info_targets();
		}
		else
		{
			if ((DQ_SPAWN_POINTS).findFirst("(") == 0)
			{
				MONSTER_ORIGIN_AMT = GetTokenCount(DQ_SPAWN_POINTS, ";");
				for (int i = 0; i < MONSTER_ORIGIN_AMT; i++)
				{
					quest_handle_vectors();
				}
			}
			else
			{
				LogDebug("No proper origins were found, defend_me cannot spawn enemies!");
			}
		}
	}

	void quest_handle_info_targets()
	{
		string L_INFO_TARGET_NAME = DQ_SPAWN_POINTS;
		string L_MONSTER_ORIGIN_AMT = MONSTER_ORIGIN_AMT;
		string L_MONSTER_ORIGIN_AMT = int(/* TODO: $math(add) */ L_MONSTER_ORIGIN_AMT);
		L_INFO_TARGET_NAME += L_MONSTER_ORIGIN_AMT;
		string L_INFO_TARGET_ID = FindEntityByName(L_INFO_TARGET_NAME);
		if (((L_INFO_TARGET_ID !is null)))
		{
			MONSTER_SPAWN_ORIGINS.insertLast(GetEntityOrigin(L_INFO_TARGET_ID));
			MONSTER_ORIGIN_AMT = /* TODO: $math(add) */ MONSTER_ORIGIN_AMT;
			ScheduleDelayedEvent(0.1, "quest_handle_info_targets");
		}
	}

	void quest_handle_vectors()
	{
		MONSTER_SPAWN_ORIGINS.insertLast(GetToken(DQ_SPAWN_POINTS, i, ";"));
	}

	void populate_area()
	{
		if (QUEST_MODE == "active")
		{
			if (DQ_MONSTERS_AVAILABLE > 0)
			{
				if (DQ_SPAWN_POINTS == "random")
				{
					string L_R_DIST = Random(128, 256);
					string L_R_YAW = Random(0, 359.99);
					string L_POS = DQ_DEFEND_ME_DEFENSE_POINT;
					L_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_R_YAW, 0), Vector3(0, L_R_DIST, 0));
				}
				else
				{
					string L_IDX = RandomInt(0, /* TODO: $math(subtract) */ /* TODO: $get_array_amt */ $get_array_amt(MONSTER_SPAWN_ORIGINS));
					string L_POS = /* TODO: $get_array */ $get_array(MONSTER_SPAWN_ORIGINS, L_IDX);
				}
				string L_R_SCRIPT = RandomInt(0, /* TODO: $math(subtract) */ GetTokenCount(DQ_MONSTER_LIST, ";"));
				SpawnNPC(GetToken(DQ_MONSTER_LIST, L_R_SCRIPT, ";"), L_POS, ScriptMode::Legacy);
				EFFECT_ME = GetEntityIndex(m_hLastCreated);
				if (DQ_SPAWN_POINTS == "random")
				{
					CallExternal(EFFECT_ME, "as_tele_stuck_check");
				}
				ScheduleDelayedEvent(1.1, "dq_apply_externals");
				DQ_MONSTERS_AVAILABLE = /* TODO: $math(subtract) */ DQ_MONSTERS_AVAILABLE;
			}
			if (CAN_POPULATE_AGAIN <= GetGameTime())
			{
				CAN_POPULATE_AGAIN = /* TODO: $math(add) */ GetGameTime();
				DQ_MONSTER_SPAWN_TIME("populate_area");
			}
		}
	}

	void dq_apply_externals()
	{
		CallExternal(EFFECT_ME, "set_quest_miniboss", 1);
		ApplyEffect(EFFECT_ME, "dq/externals/dq_apply_callback_on_death", GetEntityIndex(GetOwner()));
		if ((DQ_SELF_ADJUST))
		{
			ApplyEffect(EFFECT_ME, "dq/externals/dq_adjust_damage", GetEntityIndex(GetOwner()));
			CallExternal(EFFECT_ME, "set_xp", /* TODO: $math(multiply) */ QUEST_TAKER_MAXHP);
			string L_HEALTH = /* TODO: $math(multiply) */ QUEST_TAKER_MAXHP;
			CallExternal(EFFECT_ME, "ext_set_health", L_HEALTH, L_HEALTH);
		}
	}

	void ext_effected_monster_killed()
	{
		DQ_MONSTERS_KILLED = /* TODO: $math(add) */ DQ_MONSTERS_KILLED;
		DQ_MONSTERS_AVAILABLE = /* TODO: $math(add) */ DQ_MONSTERS_AVAILABLE;
		if (DQ_MONSTERS_KILLED >= DQ_MONSTER_LIMIT)
		{
			quest_finished_check();
		}
		else
		{
			if (CAN_POPULATE_AGAIN < GetGameTime())
			{
				CAN_POPULATE_AGAIN = /* TODO: $math(add) */ GetGameTime();
				DQ_MONSTER_SPAWN_TIME("populate_area");
			}
		}
	}

}

}
