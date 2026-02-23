#pragma context server

namespace MS
{

class DqGenericReward : CGameScript
{
	int USING_GENERIC_REWARD;

	DqGenericReward()
	{
		USING_GENERIC_REWARD = 1;
		array<string> A_QUEST_PARTICIPANTS;
	}

	void quest_activate()
	{
		if ((QUEST_REWARD_ALL))
		{
			string L_PLAYERS = "";
			GetAllPlayers(L_PLAYERS);
			for (int i = 0; i < GetTokenCount(L_PLAYERS, ";"); i++)
			{
				get_quest_participants_loop(L_PLAYERS);
			}
		}
	}

	void quest_taker_updated()
	{
		if (!(QUEST_REWARD_ALL))
		{
			string L_ARRAY_AMT = /* TODO: $get_array_amt */ $get_array_amt(A_QUEST_PARTICIPANTS);
			if (L_ARRAY_AMT > 0)
			{
				for (int i = 0; i < L_ARRAY_AMT; i++)
				{
					clear_array_loop();
				}
			}
			add_quest_participant(QUEST_TAKER);
		}
	}

	void quest_complete()
	{
		string L_PLAYER = param1;
		string L_PLAYER_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(A_QUEST_PARTICIPANTS, L_PLAYER);
		if (L_PLAYER_IDX != -1)
		{
			A_QUEST_PARTICIPANTS.removeAt(L_PLAYER_IDX);
			if (!(QUEST_REWARD_ALL))
			{
				if (!(QUEST_REWARD_TAKEN))
				{
					QUEST_REWARD_TAKEN = 1;
					quest_reward(L_PLAYER);
				}
			}
			else
			{
				quest_reward(L_PLAYER);
			}
		}
	}

	void quest_reward()
	{
		string L_PLAYER = param1;
		if (QUEST_REWARD_TYPE == "map")
		{
			UseTrigger(QUEST_REWARD_EVENT);
		}
		else
		{
			if (QUEST_REWARD_TYPE == "script")
			{
				QUEST_REWARD_EVENT(L_PLAYER);
			}
			else
			{
				if (QUEST_REWARD_TYPE == "gm")
				{
					CallExternal(GAME_MASTER, "QUEST_REWARD_EVENT", L_PLAYER);
				}
			}
		}
		if (/* TODO: $get_array_amt */ $get_array_amt(A_QUEST_PARTICIPANTS) == 0)
		{
			SetMenuAutoOpen(0);
			delete_fade_me();
		}
	}

	void game_menu_getoptions()
	{
		string L_PLAYER = param1;
		if (QUEST_MODE == QUEST_COMPLETE)
		{
			if (!(QUEST_REWARD_ALL))
			{
				if (!(QUEST_REWARD_TAKEN))
				{
					if (L_PLAYER == QUEST_TAKER)
					{
						build_quest_complete_menu(L_PLAYER);
					}
				}
			}
			else
			{
				if (/* TODO: $get_arrayfind */ $get_arrayfind(A_QUEST_PARTICIPANTS, L_PLAYER_ID) != -1)
				{
					build_quest_complete_menu(L_PLAYER);
				}
			}
		}
	}

	void get_quest_participants_loop()
	{
		string L_PLAYER = GetToken(param1, i, ";");
		add_quest_participant(L_PLAYER);
	}

	void add_quest_participant()
	{
		string L_PLAYER = param1;
		A_QUEST_PARTICIPANTS.insertLast(L_PLAYER);
	}

	void build_quest_complete_menu()
	{
		string L_PLAYER_ID = param1;
		string reg.mitem.title = QUEST_COMPLETE_TEXT;
		string reg.mitem.type = "callback";
		string reg.mitem.data = L_PLAYER_ID;
		string reg.mitem.callback = "quest_complete";
	}

	void clear_array_loop()
	{
		A_QUEST_PARTICIPANTS.removeAt(0);
	}

}

}
