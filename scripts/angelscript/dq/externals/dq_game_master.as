#pragma context server

namespace MS
{

class DqGameMaster : CGameScript
{
	int DQ_DEATH_CALLBACK_ARRAY_CREATED;
	string DQ_MONSTER_KILLED_NAME;
	string DQ_MONSTER_KILLED_ORIGIN;

	DqGameMaster()
	{
		DQ_DEATH_CALLBACK_ARRAY_CREATED = 0;
	}

	void gm_dq_add_counter()
	{
		if (!(DQ_DEATH_CALLBACK_ARRAY_CREATED))
		{
			DQ_DEATH_CALLBACK_ARRAY_CREATED = 1;
			array<string> DQ_DEATH_CALLBACK_IDS;
		}
		DQ_DEATH_CALLBACK_IDS.insertLast(param1);
	}

	void gm_dq_perish_counter()
	{
		string L_DEL_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(DQ_DEATH_CALLBACK_IDS, param1);
		if (L_DEL_IDX != -1)
		{
			DQ_DEATH_CALLBACK_IDS.removeAt(L_DEL_IDX);
		}
	}

	void gm_dq_add_death()
	{
		DQ_MONSTER_KILLED_NAME = param1;
		DQ_MONSTER_KILLED_ORIGIN = param2;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(DQ_DEATH_CALLBACK_IDS); i++)
		{
			gm_dq_monster_death_callbacks();
		}
	}

	void gm_dq_monster_death_callbacks()
	{
		CallExternal(/* TODO: $get_array */ $get_array(DQ_DEATH_CALLBACK_IDS, i), "ext_quest_monster_killed");
	}

}

}
