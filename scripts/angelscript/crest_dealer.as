#pragma context server

namespace MS
{

class CrestDealer : CGameScript
{
	string MY_CRESTS;

	void OnSpawn() override
	{
		SetName("Gimmecrest Goblin");
		SetModel("null.mdl");
		SetInvincible(true);
	}

	void game_dynamically_created()
	{
		MY_CRESTS = param2;
		OpenMenu(param1);
	}

	void game_menu_getoptions()
	{
		for (int i = 0; i < GetTokenCount(MY_CRESTS, ";"); i++)
		{
			build_crest_menu();
		}
		ScheduleDelayedEvent(10.0, "end_me");
	}

	void game_menu_cancel()
	{
		end_me();
	}

	void build_crest_menu()
	{
		string L_CREST = GetToken(MY_CRESTS, i, ";");
		string reg.mitem.title = /* TODO: $get_item_table */ $get_item_table(L_CREST, "name");
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "give_crest";
		string reg.mitem.data = L_CREST;
	}

	void give_crest()
	{
		string L_CREST = param2;
		CallExternal(GAME_MASTER, "give_item", GetEntityIndex(param1), L_CREST);
		DeleteEntity(GetOwner());
	}

	void end_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
