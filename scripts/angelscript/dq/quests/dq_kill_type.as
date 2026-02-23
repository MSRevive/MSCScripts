#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqKillType : CGameScript
{
	int DQ_KILLED;
	string DQ_KILL_NUM;

	DqKillType()
	{
		DQ_KILL_NUM = GetToken(QUEST_DATA1, 0, ";");
		const string DQ_KILL_WHO = StringToLower(GetToken(QUEST_DATA1, 1, ";"));
		DQ_KILLED = 0;
	}

	void quest_activate()
	{
		CallExternal(GAME_MASTER, "gm_dq_add_counter", GetEntityIndex(GetOwner()));
	}

	void ext_quest_monster_killed()
	{
		string L_MONSTER_KILLED_NAME = StringToLower(GetEntityProperty(GAME_MASTER, "scriptvar"));
		if ((L_MONSTER_KILLED_NAME).findFirst(DQ_KILL_WHO) >= 0)
		{
			do_the_monster_killed_bit();
		}
		else
		{
			if (DQ_KILL_WHO == "all")
			{
				do_the_monster_killed_bit();
			}
		}
	}

	void do_the_monster_killed_bit()
	{
		DQ_KILLED = /* TODO: $math(add) */ DQ_KILLED;
		if (DQ_KILLED >= DQ_KILL_NUM)
		{
			quest_finished();
			CallExternal(GAME_MASTER, "gm_dq_perish_counter", GetEntityIndex(GetOwner()));
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "gm_dq_perish_counter", GetEntityIndex(GetOwner()));
	}

}

}
