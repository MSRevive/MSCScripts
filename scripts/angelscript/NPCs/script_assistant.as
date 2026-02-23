#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class ScriptAssistant : CGameScript
{
	string ADDED_SUMMON;
	string CHAT_CURRENT_SPEAKER;
	string CVAR_SCRIPTS;
	string DEV_SCRIPTS;
	int DID_INTRO;
	int MAP_SHIELD_ON;
	int MENU_MODE;
	string MENU_TARGET;
	int N_SUMMONS;
	string PLAYER_LIST;
	string SCRIPT_POS;
	int SUMMON_ANG;
	int SUMMON_SCRIPT;
	int WATER_OPEN;

	ScriptAssistant()
	{
		const string CONTROLLER_HEAD_LR = "controller0";
		const string CONTROLLER_HEAD_UD = "controller1";
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
		array<string> PROBLEM_LIST;
		array<string> ARRAY_SUMMONS;
		SUMMON_SCRIPT = 0;
		N_SUMMONS = 0;
		MAP_SHIELD_ON = 1;
		WATER_OPEN = 0;
		SUMMON_ANG = 90;
		const int SUMMON_DIST = 256;
		MENU_MODE = 0;
	}

	void OnSpawn() override
	{
		SetName("Dungeon Master's Assistant");
		SetModel("monsters/venevus.mdl");
		SetWidth(32);
		SetHeight(72);
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetSayTextRange(1024);
		SetProp(GetOwner(), "scale", 0.75);
		CatchSpeech("menu_whoami", "hi");
		CatchSpeech("menu_list_problems", "problem");
		CatchSpeech("menu_map_help", "help");
		CatchSpeech("menu_toggle_water", "water");
		CatchSpeech("menu_toggle_shield", "shield");
		CatchSpeech("summon", "send_menu");
		CatchSpeech("menu_remove_all", "remove");
		ScheduleDelayedEvent(0.1, "scan_for_master");
		ScheduleDelayedEvent(0.05, "check_problems");
	}

	void check_problems()
	{
		string L_CVAR_DEV = GetCvar("ms_dev_mode");
		CVAR_SCRIPTS = GetCvar("ms_dynamicnpc");
		if (!(L_CVAR_DEV))
		{
			PROBLEM_LIST.insertLast("ms_dev_mode is not set to 1 in the listenserver.cfg!");
		}
		if ((CVAR_SCRIPTS).length() < 2)
		{
			PROBLEM_LIST.insertLast("ms_dynamicnpc does not seem to be set in the listenserver.cfg!");
		}
		DEV_SCRIPTS = "";
		for (int i = 0; i < GetTokenCount(CVAR_SCRIPTS, ";"); i++)
		{
			parse_ms_dynamicnpc();
		}
	}

	void scan_for_master()
	{
		if ((DID_INTRO)) return;
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			check_players();
		}
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_master");
	}

	void check_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if ((DID_INTRO)) return;
		if (!(GetEntityRange(CUR_TARG) < 256)) return;
		DID_INTRO = 1;
		CHAT_CURRENT_SPEAKER = CUR_TARG;
		ScheduleDelayedEvent(2.0, "do_intro");
	}

	void do_intro()
	{
		if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) > 0)
		{
			chat_now("Master! Something is wrong!", 2.0, "none", "none", "add_to_que");
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST); i++)
			{
				list_problems();
			}
			if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) > 1)
			{
				chat_now("I'm afraid this will have to be fixed before we can continue.", 4.0, "none", "none", "add_to_que");
			}
			else
			{
				chat_now("These problems will have to be remedied before we can continue.", 4.0, "none", "none", "add_to_que");
			}
		}
		else
		{
			chat_now("Master... We are ready to begin.", 2.0, "none", "none", "add_to_que");
		}
	}

	void list_problems()
	{
		string CUR_PROB = /* TODO: $get_array */ $get_array(PROBLEM_LIST, i);
		LogDebug("list_problems CUR_PROB");
		if (i == 1)
		{
			chat_now("Also...", 1.0, "none", "none", "add_to_que");
		}
		string L_PROB_LEN_RATIO = (CUR_PROB).length();
		if (L_PROB_LEN_RATIO > 60)
		{
			int L_PROB_LEN_RATIO = 60;
		}
		L_PROB_LEN_RATIO /= 60;
		LogDebug("list_problems lineratio L_PROB_LEN_RATIO");
		string L_CHAT_TIME = /* TODO: $ratio */ $ratio(L_PROB_LEN_RATIO, 2.0, 4.5);
		chat_now(CUR_PROB, L_PROB_LEN_RATIO, "none", "none", "add_to_que");
	}

	void parse_ms_dynamicnpc()
	{
		string L_CUR_SCRIPT = GetToken(CVAR_SCRIPTS, i, ";");
		if ((L_CUR_SCRIPT).findFirst("test_scripts") == 0)
		{
			if ((L_CUR_SCRIPT).findFirst(".script") >= 0)
			{
				PROBLEM_LIST.insertLast("A script in ms_dynamicnpc has a .script extention...");
				PROBLEM_LIST.insertLast("...Extentions should not be included in script names.");
				int L_SCRIPT_INVALID = 1;
			}
			if ((L_CUR_SCRIPT).findFirst("\") >= 0)
			{
				PROBLEM_LIST.insertLast("A script in has a back slash (\) in its name - please only use forward slahes (/) - usually under the question mark.");
				int L_SCRIPT_INVALID = 1;
			}
			if (!(L_SCRIPT_INVALID))
			{
			}
			if (DEV_SCRIPTS.length() > 0) DEV_SCRIPTS += ";";
			DEV_SCRIPTS += L_CUR_SCRIPT;
		}
		else
		{
			PROBLEM_LIST.insertLast("There is a script not prefixed with test_scripts/ in ms_dynamicnpc...");
			PROBLEM_LIST.insertLast("I can only summon scripts found in the msc/test_scripts folder.");
		}
	}

	void game_menu_getoptions()
	{
		if (MENU_MODE == 0)
		{
			if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) == 0)
			{
				if ((DEV_SCRIPTS).length() > 12)
				{
					string reg.mitem.title = "[Summon] a creation...";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "menu_summon";
				}
				if (N_SUMMONS > 0)
				{
					string reg.mitem.title = "Remove a creation...";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "menu_remove_specific";
					string reg.mitem.title = "[Remove] all creations.";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "menu_remove_all";
				}
			}
			else
			{
				show_help();
			}
			if (!(WATER_OPEN))
			{
				string reg.mitem.title = "Open the [water] ways.";
			}
			else
			{
				string reg.mitem.title = "Close the [water] ways.";
			}
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_toggle_water";
			if (!(MAP_SHIELD_ON))
			{
				string reg.mitem.title = "Raise the [shield].";
			}
			else
			{
				string reg.mitem.title = "Lower the [shield].";
			}
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_toggle_shield";
			if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) == 0)
			{
				show_help();
			}
		}
		if (MENU_MODE == "summon")
		{
			chat_now("Which of your creations shall I summon?", 4.0, "none", "none", "add_to_que", "clear_que");
			for (int i = 0; i < GetTokenCount(DEV_SCRIPTS, ";"); i++)
			{
				list_summon_options();
			}
			MENU_MODE = 0;
		}
		if (MENU_MODE == "remove_specific")
		{
			chat_now("Which of your creations shall I remove?", 4.0, "none", "none", "add_to_que", "clear_que");
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_SUMMONS); i++)
			{
				list_summons_loop();
			}
			MENU_MODE = 0;
		}
	}

	void list_summons_loop()
	{
		string CUR_IDX = i;
		string CUR_SUM = /* TODO: $get_array */ $get_array(ARRAY_SUMMONS, CUR_IDX);
		if (!(IsEntityAlive(CUR_SUM))) return;
		string reg.mitem.title = GetEntityName(CUR_SUM);
		string reg.mitem.type = "callback";
		string reg.mitem.data = CUR_IDX;
		string reg.mitem.callback = "menu_remove_by_idx";
	}

	void menu_remove_by_idx()
	{
		PlayAnim("critical", "castspell");
		string CUR_SUM = /* TODO: $get_array */ $get_array(ARRAY_SUMMONS, param2);
		SetMoveDest(GetEntityOrigin(CUR_SUM));
		string L_CHAT_TEXT = GetEntityProperty(CUR_SUM, "name.full.capital");
		L_CHAT_TEXT += " has been removed.";
		chat_now(L_CHAT_TEXT, 3.0, "none", "none", "add_to_que", "clear_que");
		ARRAY_SUMMONS[param2] = 0;
		DeleteEntity(CUR_SUM, true); // fade out
		N_SUMMONS -= 1;
	}

	void show_help()
	{
		string reg.mitem.title = "What is this place?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_map_help";
		string reg.mitem.title = "Who are you?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_whoami";
		if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) > 0)
		{
			string reg.mitem.title = "What were the [problems] again?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_list_problems";
		}
	}

	void list_summon_options()
	{
		string CUR_IDX = i;
		string reg.mitem.title = GetToken(DEV_SCRIPTS, CUR_IDX, ";");
		string reg.mitem.type = "callback";
		string reg.mitem.data = GetToken(DEV_SCRIPTS, CUR_IDX, ";");
		string reg.mitem.callback = "menu_summon_script";
	}

	void menu_list_problems()
	{
		chat_clear_que();
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST); i++)
		{
			list_problems();
		}
	}

	void menu_map_help()
	{
		chat_now("This map is for testing your creations, my master!", 3.0, "castspell", "none", "clear_que", "add_to_que");
		chat_now("Here, you can safely summon creatures, and your other creations...", 4.0, "none", "none", "add_to_que");
		chat_now("Scripts you created in the test_scripts/ folder.", 3.0, "none", "none", "add_to_que");
		chat_now("I can summon any such script here, and offer various tools to help you in their testing.", 5.0, "none", "none", "add_to_que");
		explain_cvars();
		if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) > 0)
		{
			chat_now("I could start summoning your creations right now, but alas, there are these [problems]...", 5.0, "none", "none", "add_to_que");
		}
	}

	void menu_whoami()
	{
		chat_now("I, am your humble assistant...", 2.0, "castspell", "none", "clear_que", "add_to_que");
		chat_now("It is my task to aid in the testing of your creations.", 4.0, "none", "none", "add_to_que");
		chat_now("I can summon your creations, remove them, and provide aid in a few other methods of testing.", 4.0, "none", "none", "add_to_que");
		explain_cvars();
		if (/* TODO: $get_array_amt */ $get_array_amt(PROBLEM_LIST) > 0)
		{
			chat_now("I could start assisiting you right now, but alas, there are these [problems]...", 5.0, "none", "none", "add_to_que");
		}
	}

	void explain_cvars()
	{
		chat_now("Such creations must be scripts in the test_scripts/ folder...", 3.0, "none", "none", "add_to_que");
		chat_now("And added to ms_dynamicnpc cvar, set in your listenserver.cfg.", "none", "none", "add_to_que");
		chat_now("You can add multiple creations, by adding their script names, and seperating them by semi-colons (;).", 4.0, "none", "none", "add_to_que");
		chat_now("For instance...", 2.0, "none", "none", "add_to_que");
		chat_now("ms_dynamic_npc test_scripts/test_spider;test_scripts/test_orc", 4.0, "none", "none", "add_to_que");
		chat_now("Lastly, the server must be in developer mode, so ms_dev_mode must be set to 1 in the listenserver.cfg as well.", 5.0, "none", "none", "add_to_que");
	}

	void menu_summon()
	{
		MENU_MODE = "summon";
		MENU_TARGET = param1;
		ScheduleDelayedEvent(0.1, "send_menu");
	}

	void send_menu()
	{
		if (!(IsEntityAlive(MENU_TARGET)))
		{
			MENU_TARGET = GetEntityIndex("ent_lastspoke");
		}
		OpenMenu(MENU_TARGET);
	}

	void menu_summon_script()
	{
		SUMMON_SCRIPT = param2;
		PlayAnim("critical", "castspell");
		face_summon();
		SUMMON_ANG += 90;
		if (SUMMON_ANG > 359)
		{
			SUMMON_ANG = 0;
		}
		MENU_MODE = 0;
	}

	void castspell()
	{
		LogDebug("castspell SUMMON_SCRIPT");
		if (!(SUMMON_SCRIPT != 0)) return;
		SpawnNPC(SUMMON_SCRIPT, SCRIPT_POS, ScriptMode::Legacy);
		SUMMON_SCRIPT = 0;
		N_SUMMONS += 1;
		ClientEvent("new", "all", "effects/sfx_summon_circle", SCRIPT_POS, 3);
		ScheduleDelayedEvent(1.0, "name_summon");
	}

	void name_summon()
	{
		string L_SUMMON_NAME = GetEntityProperty(m_hLastCreated, "name.full.capital");
		string L_CHAT_STR = L_SUMMON_NAME;
		L_CHAT_STR += " has been summoned.";
		chat_now(L_CHAT_STR, 3.0, "none", "none", "add_to_que");
		if ((GetEntityProperty(m_hLastCreated, "scriptvar")))
		{
			if (!(WATER_OPEN))
			{
			}
			chat_now("This appears to be a fish, so I shall open the [water] ways.", 3.0, "none", "none", "add_to_que");
			menu_toggle_water();
			ScheduleDelayedEvent(1.0, "dunk_it");
		}
		AddVelocity(m_hLastCreated, /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, -1000)));
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_SUMMONS) > 1)
		{
			ADDED_SUMMON = 0;
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_SUMMONS); i++)
			{
				add_summon_loop();
			}
			if (!(ADDED_SUMMON))
			{
			}
			ARRAY_SUMMONS.insertLast(GetEntityIndex(m_hLastCreated));
		}
		else
		{
			ARRAY_SUMMONS.insertLast(GetEntityIndex(m_hLastCreated));
		}
	}

	void add_summon_loop()
	{
		if ((ADDED_SUMMON)) return;
		string CUR_SUM = /* TODO: $get_array */ $get_array(ARRAY_SUMMONS, i);
		if ((IsEntityAlive(CUR_SUM))) return;
		ARRAY_SUMMONS[i] = GetEntityIndex(m_hLastCreated);
		ADDED_SUMMON = 1;
	}

	void menu_toggle_shield()
	{
		face_summon();
		PlayAnim("critical", "castspell");
		UseTrigger("twal_shield");
		if ((MAP_SHIELD_ON))
		{
			MAP_SHIELD_ON = 0;
			chat_now("The [shield] is lowered.", 3.0, "none", "none", "add_to_que");
		}
		else
		{
			MAP_SHIELD_ON = 1;
			chat_now("The [shield] is raised.", 3.0, "none", "none", "add_to_que");
		}
	}

	void menu_toggle_water()
	{
		face_summon();
		PlayAnim("critical", "castspell");
		UseTrigger("door_water");
		if ((WATER_OPEN))
		{
			WATER_OPEN = 0;
			chat_now("The [water] ways are sealed.", 3.0, "none", "none", "add_to_que");
		}
		else
		{
			WATER_OPEN = 1;
			chat_now("The [water] ways are opened.", 3.0, "none", "none", "add_to_que");
		}
	}

	void face_summon()
	{
		SCRIPT_POS = GetEntityOrigin(GetOwner());
		SCRIPT_POS += /* TODO: $relpos */ $relpos(Vector3(0, SUMMON_ANG, 0), Vector3(0, SUMMON_DIST, 0));
		SetMoveDest(SCRIPT_POS);
	}

	void menu_remove_all()
	{
		PlayAnim("critical", "castspell");
		face_summon();
		chat_now("All your creations have been removed...", 3.0, "none", "none", "add_to_que");
		N_SUMMONS = 0;
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_SUMMONS) > 1)
		{
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_SUMMONS); i++)
			{
				remove_summons_loop();
			}
		}
		else
		{
			if (/* TODO: $get_array */ $get_array(ARRAY_SUMMONS, 0) != 0)
			{
				DeleteEntity(/* TODO: $get_array */ $get_array(ARRAY_SUMMONS, 0), true); // fade out
			}
			if (/* TODO: $get_array */ $get_array(ARRAY_SUMMONS, 1) != 0)
			{
				DeleteEntity(/* TODO: $get_array */ $get_array(ARRAY_SUMMONS, 1), true); // fade out
			}
			ARRAY_SUMMONS[0] = 0;
			ARRAY_SUMMONS[1] = 0;
		}
	}

	void remove_summons_loop()
	{
		string CUR_SUM = /* TODO: $get_array */ $get_array(ARRAY_SUMMONS, i);
		if (!(IsEntityAlive(CUR_SUM))) return;
		DeleteEntity(CUR_SUM, true); // fade out
		ARRAY_SUMMONS[i] = 0;
	}

	void menu_remove_specific()
	{
		MENU_MODE = "remove_specific";
		MENU_TARGET = param1;
		ScheduleDelayedEvent(0.1, "send_menu");
	}

}

}
