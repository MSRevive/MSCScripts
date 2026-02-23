#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqKillTarget : CGameScript
{
	string QUEST_INFO_TARGET_ID;
	string QUEST_INFO_TARGET_YAW;
	string QUEST_MONSTER_ID;
	string QUEST_MONSTER_SPAWN_POINT;

	DqKillTarget()
	{
		const string QUEST_MONSTER_SCRIPT = GetToken(QUEST_DATA1, 0, ";");
		const string QUEST_MONSTER_NAME = GetToken(QUEST_DATA1, 1, ";");
		const string QUEST_INFO_TARGET_NAME = QUEST_DATA2;
		const string DQ_SELF_ADJUST = QUEST_DATA3;
		const string DQ_MONSTER_PARAMS = QUEST_DATA4;
		const int QUEST_TARGET_HP_MULT = 5;
		const int QUEST_TARGET_XP_MULT = 2;
		QUEST_INFO_TARGET_YAW = Vector3(0, 0, 0);
	}

	void quest_activate()
	{
		if (((FindEntityByName(QUEST_INFO_TARGET_NAME) !is null)))
		{
			QUEST_INFO_TARGET_ID = FindEntityByName(QUEST_INFO_TARGET_NAME);
			QUEST_MONSTER_SPAWN_POINT = GetEntityOrigin(QUEST_INFO_TARGET_ID);
			QUEST_INFO_TARGET_YAW = GetEntityProperty(QUEST_INFO_TARGET_ID, "angles.yaw");
		}
		else
		{
			QUEST_MONSTER_SPAWN_POINT = QUEST_INFO_TARGET_NAME;
		}
		if ((DQ_MONSTER_PARAMS))
		{
			SpawnNPC(QUEST_MONSTER_SCRIPT, QUEST_MONSTER_SPAWN_POINT, ScriptMode::Legacy); // params: "addparams", DQ_MONSTER_PARAMS
		}
		else
		{
			SpawnNPC(QUEST_MONSTER_SCRIPT, QUEST_MONSTER_SPAWN_POINT, ScriptMode::Legacy);
		}
		QUEST_MONSTER_ID = GetEntityIndex(m_hLastCreated);
		CallExternal(QUEST_MONSTER_ID, "ext_setangle", Vector3(0, QUEST_INFO_TARGET_YAW, 0));
		CallExternal(QUEST_MONSTER_ID, "set_name", QUEST_MONSTER_NAME);
		CallExternal(QUEST_MONSTER_ID, "make_boss");
		CallExternal(QUEST_MONSTER_ID, "set_quest_miniboss", 1);
		ScheduleDelayedEvent(1.1, "dq_apply_externals");
	}

	void dq_apply_externals()
	{
		ApplyEffect(QUEST_MONSTER_ID, "dq/externals/dq_apply_callback_on_death", GetEntityIndex(GetOwner()));
		if ((DQ_SELF_ADJUST))
		{
			ApplyEffect(QUEST_MONSTER_ID, "dq/externals/dq_adjust_damage");
			string L_QUEST_MONSTER_HP = /* TODO: $math(multiply) */ QUEST_TAKER_MAXHP;
			CallExternal(QUEST_MONSTER_ID, "ext_set_health", L_QUEST_MONSTER_HP, L_QUEST_MONSTER_HP);
			string L_QUEST_MONSTER_XP = /* TODO: $math(multiply) */ QUEST_TAKER_MAXHP;
			CallExternal(QUEST_MONSTER_ID, "set_xp", L_QUEST_MONSTER_XP);
		}
	}

	void ext_effected_monster_killed()
	{
		quest_finished_check();
	}

}

}
