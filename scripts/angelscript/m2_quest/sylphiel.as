#pragma context server

#include "monsters/base_chat_array.as"
#include "monsters/debug.as"

namespace MS
{

class Sylphiel : CGameScript
{
	int ALL_QUESTS_DONE;
	string ANIM_IDLE;
	string ANIM_WALK;
	string CHAT_CURRENT_SPEAKER;
	int CHAT_TEMP_NO_AUTO_FACE;
	string CHECK_PACING;
	string CIRCLE_ACTIVE;
	string COMPLAIN_BLOCKED;
	string COOKING_POT_ID;
	string COOK_COMPLAIN;
	int COUNT_APPLE;
	int COUNT_LADEL;
	int COUNT_MEAD;
	int COUNT_PEPPER;
	int COUNT_SALT;
	string DID_FIRST_HELP;
	int DID_HELP;
	int DID_INTRO;
	int DO_THANK;
	string LAST_GAVE_SOUP;
	string LOCKED_PLAYER;
	int MENU_ENABLE_HELP;
	string MY_ID;
	string NEXT_ATTACK;
	string NEXT_PACE;
	string NPCATK_TARGET;
	int NPC_NO_PLAYER_DMG;
	int QUEST_COMPLETE;
	int QUEST_ENABLED;
	string QUEST_PLAYER;
	int QUEST_SOUP_COMPLETE;
	string SECOND_QUEST_INPROGRESS;
	int SECOND_QUEST_OFFERED;
	string SECOND_QUEST_READY;
	string SOUP_LIST;
	int SOUP_READY;
	string WASTING_MY_TIME;

	Sylphiel()
	{
		NPC_NO_PLAYER_DMG = 1;
		const string ANIM_BLUSH = "anim_blush";
		const string ANIM_RANT = "anim_rant";
		QUEST_SOUP_COMPLETE = 0;
		COUNT_APPLE = 0;
		const int MAX_APPLE = 5;
		COUNT_SALT = 0;
		const int MAX_SALT = 1;
		COUNT_PEPPER = 0;
		const int MAX_PEPPER = 1;
		COUNT_MEAD = 0;
		const int MAX_MEAD = 5;
		COUNT_LADEL = 0;
		const int MAX_LADEL = 1;
		const string QCODE_APPLE = "ap";
		const string QCODE_SALT = "bs";
		const string QCODE_PEPPER = "bp";
		const string QCODE_MEAD = "km";
		const string QCODE_LADEL = "la";
		const string ANIM_BLUSH = "anim_blush";
		const string ANIM_RAGE = "anim_rage";
		const string ANIM_RAGE_WALK = "anim_rage_walk";
		const string ANIM_VICTORY = "wave";
		const string ANIM_COOK = "keypad";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		SOUP_LIST = "";
		const Vector3 POS_SECOND_QUEST = Vector3(-888, -536, -544);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		if ((CHECK_PACING))
		{
			if (!(QUEST_COMPLETE))
			{
			}
			if (!(SECOND_QUEST_READY))
			{
			}
			if (!(SECOND_QUEST_INPROGRESS))
			{
			}
			if (!(SECOND_QUEST_OFFERED))
			{
			}
			if (GetGameTime() > NEXT_PACE)
			{
			}
			GetAllPlayers(PLAYER_LIST);
			string SORT_PLAYERS = /* TODO: $sort_entlist */ $sort_entlist(PLAYER_LIST, "range");
			string TEST_PLAYER = GetToken(SORT_PLAYERS, 0, ";");
			if (GetEntityRange(TEST_PLAYER) > 256)
			{
			}
			if (!(CIRCLE_ACTIVE))
			{
			}
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_WALK);
			CIRCLE_ACTIVE = 1;
			circle_pot();
		}
		else
		{
			SetIdleAnim(ANIM_IDLE);
		}
		if ((false))
		{
		}
		NPCATK_TARGET = GetEntityIndex(m_hLastSeen);
		if (GetEntityRange(m_hAttackTarget) < 128)
		{
		}
		stop_circle();
		NEXT_PACE = GetGameTime();
		NEXT_PACE += 30.0;
		SetMoveDest(m_hAttackTarget);
		do_attack();
	}

	void OnSpawn() override
	{
		SetName("Sylphiel");
		SetName("sylphiel");
		SetRace("human");
		SetWidth(32);
		SetHeight(72);
		SetRoam(false);
		SetModel("npc/human2.mdl");
		SetInvincible(true);
		SetNoPush(true);
		LOCKED_PLAYER = "none";
		GetAllPlayers(PLAYER_LIST);
		SetSayTextRange(1024);
		ScheduleDelayedEvent(3.0, "scan_for_players");
		ScheduleDelayedEvent(2.0, "get_pot_id");
		CIRCLE_ACTIVE = 1;
		ScheduleDelayedEvent(3.0, "circle_pot");
	}

	void game_precache()
	{
		Precache("m2_quest/pot");
	}

	void get_pot_id()
	{
		COOKING_POT_ID = FindEntityByName("cooking_pot");
	}

	void game_dynamically_created()
	{
		ScheduleDelayedEvent(0.1, "setup_debug_pot");
	}

	void setup_debug_pot()
	{
		string POT_ORG = GetEntityOrigin(GetOwner());
		POT_ORG += "x";
		SpawnNPC("m2_quest/pot", POT_ORG, ScriptMode::Legacy);
	}

	void scan_for_players()
	{
		SetMoveAnim(ANIM_RAGE_WALK);
		SetIdleAnim(ANIM_RAGE_WALK);
		LogDebug("scan_for_players");
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
		GetAllPlayers(PLAYER_LIST);
		if (LOCKED_PLAYER == "none")
		{
			int FIND_NEW_LOCK = 1;
		}
		if (!((LOCKED_PLAYER !is null)))
		{
			int FIND_NEW_LOCK = 1;
		}
		if (GetEntityRange(LOCKED_PLAYER) > 512)
		{
			int FIND_NEW_LOCK = 1;
		}
		if (!(FIND_NEW_LOCK)) return;
		string SORT_PLAYERS = /* TODO: $sort_entlist */ $sort_entlist(PLAYER_LIST, "range");
		string TEST_PLAYER = GetToken(SORT_PLAYERS, 0, ";");
		if (!(GetEntityRange(TEST_PLAYER) < 64)) return;
		LOCKED_PLAYER = TEST_PLAYER;
		if ((DID_INTRO)) return;
		SetIdleAnim(ANIM_IDLE);
		DID_INTRO = 1;
		CHAT_CURRENT_SPEAKER = LOCKED_PLAYER;
		do_intro();
	}

	void stop_circle()
	{
		if ((CIRCLE_ACTIVE))
		{
			SetIdleAnim(ANIM_IDLE);
		}
		CIRCLE_ACTIVE = 0;
	}

	void do_intro()
	{
		CHAT_TEMP_NO_AUTO_FACE = 1;
		CIRCLE_ACTIVE = 1;
		chat_now("By the blood of the gods! Those damn goblins!", 1.0, "none", "none", "clear_que", "add_to_que", "sound:voices/m2_quest/sylphiel_cuss.wav");
		chat_now("May The Lost take their filthy little souls!", 4.0, ANIM_RAGE, "do_intro2", "add_to_que", "sound:voices/m2_quest/sylphiel_rage.wav");
	}

	void do_intro2()
	{
		stop_circle();
		PlayAnim("once", "break");
		SetMoveDest(LOCKED_PLAYER);
		chat_now("Oh, sorry...", 2.0, ANIM_BLUSH, "do_intro3", "add_to_que", "sound:voices/m2_quest/sylphiel_hi.wav");
		chat_now("Didn't mean for anyone to actually hear that.", 3.0, "lean", "none", "add_to_que");
		chat_now("Hey! Don't I know you from the Edana Inn?", 3.0, "pondering", "move_closer", "add_to_que");
		if (GetPlayerCount() > 1)
		{
			chat_now("You're adventurers, aren't you? Maybe you could [help] me?", 3.0, "pondering3", !"hold_for_help", "add_to_que");
		}
		else
		{
			chat_now("You're an adventurer, aren't you? Maybe you could [help] me?", 3.0, "pondering3", !"hold_for_help", "add_to_que");
		}
	}

	void move_closer()
	{
		EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_help.wav", 10);
		SetMoveDest(LOCKED_PLAYER);
	}

	void hold_for_help()
	{
		MENU_ENABLE_HELP = 1;
		SetMoveAnim("pondering3");
		SetIdleAnim("pondering3");
		CatchSpeech("menu_help", "help");
	}

	void game_menu_getoptions()
	{
		if (!(DID_INTRO))
		{
			SetIdleAnim(ANIM_IDLE);
			DID_INTRO = 1;
			CHAT_CURRENT_SPEAKER = param1;
			LOCKED_PLAYER = param1;
			do_intro();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(DID_INTRO)) return;
		CHAT_CURRENT_SPEAKER = param1;
		LOCKED_PLAYER = param1;
		if ((CIRCLE_ACTIVE))
		{
			stop_circle();
			NEXT_PACE = GetGameTime();
			NEXT_PACE += 30.0;
		}
		if (!(DOING_SOUP))
		{
			SetMoveDest(LOCKED_PLAYER);
		}
		if ((ALL_QUESTS_DONE))
		{
			chat_now("Thanks for all the help! I'll see you in town in a few days.", 3.0, "none", "none", "add_to_que");
		}
		if ((SOUP_READY))
		{
			stop_circle();
			string L_PLR_INDEX = GetEntityIndex(param1);
			LogDebug("game_menu_getoptions L_PLR_INDEX vs SOUP_LIST vs FindToken(SOUP_LIST, L_PLR_INDEX, ";")");
			if (FindToken(SOUP_LIST, L_PLR_INDEX, ";") == -1)
			{
			}
			string reg.mitem.title = "(Get soup)";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_get_soup";
		}
		if ((SECOND_QUEST_READY))
		{
			stop_circle();
			string reg.mitem.title = "One other thing?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_help";
		}
		if ((QUEST_COMPLETE)) return;
		if ((SECOND_QUEST_READY)) return;
		if ((SECOND_QUEST_INPROGRESS)) return;
		if ((SECOND_QUEST_OFFERED)) return;
		QUEST_PLAYER = param1;
		if ((MENU_ENABLE_HELP))
		{
			string reg.mitem.title = "How can I help?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_help";
		}
		if (!(DID_FIRST_HELP)) return;
		tally_quest_items(GetEntityIndex(param1));
		if ((QUEST_ENABLED))
		{
			CHECK_PACING = 1;
			string reg.mitem.title = "Golden Apples (";
			reg.mitem.title += int(COUNT_APPLE);
			reg.mitem.title += "/";
			reg.mitem.title += int(MAX_APPLE);
			reg.mitem.title += ")";
			if (COUNT_APPLE >= MAX_APPLE)
			{
				string reg.mitem.type = "green";
			}
			else
			{
				string reg.mitem.type = "disabled";
			}
			string reg.mitem.title = "Bag of Salt (";
			reg.mitem.title += int(COUNT_SALT);
			reg.mitem.title += "/";
			reg.mitem.title += int(MAX_SALT);
			reg.mitem.title += ")";
			if (COUNT_SALT >= MAX_SALT)
			{
				string reg.mitem.type = "green";
			}
			else
			{
				string reg.mitem.type = "disabled";
			}
			string reg.mitem.title = "Bag of Pepper (";
			reg.mitem.title += int(COUNT_PEPPER);
			reg.mitem.title += "/";
			reg.mitem.title += int(MAX_PEPPER);
			reg.mitem.title += ")";
			if (COUNT_PEPPER >= MAX_PEPPER)
			{
				string reg.mitem.type = "green";
			}
			else
			{
				string reg.mitem.type = "disabled";
			}
			string reg.mitem.title = "Barrel of Honeymead (";
			reg.mitem.title += int(COUNT_MEAD);
			reg.mitem.title += "/";
			reg.mitem.title += int(MAX_MEAD);
			reg.mitem.title += ")";
			if (COUNT_MEAD >= MAX_MEAD)
			{
				string reg.mitem.type = "green";
			}
			else
			{
				string reg.mitem.type = "disabled";
			}
			string reg.mitem.title = "Ladel (";
			reg.mitem.title += int(COUNT_LADEL);
			reg.mitem.title += "/";
			reg.mitem.title += int(MAX_LADEL);
			reg.mitem.title += ")";
			if (COUNT_LADEL >= MAX_LADEL)
			{
				string reg.mitem.type = "green";
			}
			else
			{
				string reg.mitem.type = "disabled";
			}
		}
	}

	void menu_help()
	{
		if ((ALL_QUESTS_DONE)) return;
		if ((IsValidPlayer(param1)))
		{
			CHAT_CURRENT_SPEAKER = param1;
			LOCKED_PLAYER = param1;
		}
		else
		{
			CHAT_CURRENT_SPEAKER = GetEntityIndex("ent_lastspoke");
			LOCKED_PLAYER = CHAT_CURRENT_SPEAKER;
		}
		if ((SECOND_QUEST_READY))
		{
			SECOND_QUEST_READY = 0;
			SECOND_QUEST_INPROGRESS = 1;
			chat_now("My grams, as you might guess by all the weird stuff on these shelves, was a bit of an alchemist.", 4.0, "converse1", "none", "add_to_que");
			chat_now("She passed on, just a bit ago, and I came here to maybe, try my hand at it...", 4.0, "none", "none", "add_to_que");
			chat_now("But there's a lot of secrets in this old house, and I'm a little afraid of what I might find...", 4.0, "lean", "none", "add_to_que");
			chat_now("Over here, for instance...", 2.0, "no_convo", "second_quest_show", "add_to_que");
		}
		if ((SECOND_QUEST_READY)) return;
		if ((SECOND_QUEST_INPROGRESS)) return;
		if (!(DID_FIRST_HELP))
		{
			WASTING_MY_TIME = -2;
			DID_FIRST_HELP = 1;
		}
		if ((DID_HELP))
		{
			chat_now("Just bring me these items, and we'll be golden.", 4.0, "pondering3", "none", "add_to_que", "sound:voices/m2_quest/sylphiel_help.wav");
			ScheduleDelayedEvent(0.1, "send_menu");
		}
		if ((DID_HELP)) return;
		enable_quest();
		chat_now("I came here, to my grand's house, to put together some of her special stew, for the inn.", 4.0, "converse1", "none", "add_to_que");
		chat_now("But I must have left the place unlocked on my last visit, as those damned goblins have been in here.", 3.0, "none", "none", "add_to_que");
		chat_now("The little green thieves went and pilfered all my ingredients!", 4.0, "none", "none", "add_to_que");
		chat_now("If you can track them down, and get my stuff back, maybe I can give you a free sample!", 5.0, "none", "none", "add_to_que");
		chat_now("Plus I'll have some more, when I get back to town.", 3.0, "pondering", "none", "add_to_que");
		chat_now("I need five of granny's golden apples, a sack of pepper, a sack of salt, and some honeymead.", 6.0, "none", "none", "add_to_que");
		chat_now("Waddya say ya help ol Sylphiel out, aye? Just find the ingredients and bring them back here.", 6.0, "pondering3", "none", "add_to_que");
		DID_HELP = 1;
	}

	void send_menu()
	{
		OpenMenu(LOCKED_PLAYER);
	}

	void enable_quest()
	{
		QUEST_ENABLED = 1;
	}

	void tally_quest_items()
	{
		DO_THANK = 0;
		MY_ID = GetEntityIndex(GetOwner());
		QUEST_PLAYER = param1;
		check_quest_items(QCODE_APPLE);
		check_quest_items(QCODE_SALT);
		check_quest_items(QCODE_PEPPER);
		check_quest_items(QCODE_MEAD);
		check_quest_items(QCODE_LADEL);
		int L_QUEST_COMPLETE = 1;
		if (COUNT_APPLE < MAX_APPLE)
		{
			int L_QUEST_COMPLETE = 0;
		}
		if (COUNT_SALT < MAX_SALT)
		{
			int L_QUEST_COMPLETE = 0;
		}
		if (COUNT_PEPPER < MAX_PEPPER)
		{
			int L_QUEST_COMPLETE = 0;
		}
		if (COUNT_MEAD < MAX_MEAD)
		{
			int L_QUEST_COMPLETE = 0;
		}
		if (COUNT_LADEL < MAX_LADEL)
		{
			int L_QUEST_COMPLETE = 0;
		}
		if ((DO_THANK))
		{
			WASTING_MY_TIME = 0;
			if (!(L_QUEST_COMPLETE))
			{
			}
			THANK_INDEX += 1;
			if (THANK_INDEX == 1)
			{
				chat_now("Thank you for that.", 1.0, "none", "none", "add_to_que");
				EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_thanks1.wav", 10);
			}
			if (THANK_INDEX == 2)
			{
				THANK_INDEX = 0;
				chat_now("I appreciate it.", 1.0, "none", "none", "add_to_que");
				EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_thanks2.wav", 10);
			}
		}
		else
		{
			if (!(L_QUEST_COMPLETE))
			{
			}
			WASTING_MY_TIME += 1;
			if (WASTING_MY_TIME > 1)
			{
				chat_now("You're wasting time... Get going!", 2.0, "pondering3", "none", "add_to_que", "sound:voices/m2_quest/sylphiel_impatient.wav");
				WASTING_MY_TIME = 0;
			}
		}
		if (!(L_QUEST_COMPLETE)) return;
		QUEST_COMPLETE = 1;
		CHECK_PACING = 0;
		stop_circle();
		SetIdleAnim(ANIM_IDLE);
		ScheduleDelayedEvent(1.0, "do_soup");
	}

	void check_quest_items()
	{
		string L_CODE = param1;
		CallExternal(GAME_MASTER, "ext_check_quest_item", L_CODE, MY_ID);
	}

	void ext_receive_quest_item()
	{
		if (param1 == QCODE_APPLE)
		{
			COUNT_APPLE += 1;
		}
		if (param1 == QCODE_SALT)
		{
			COUNT_SALT += 1;
		}
		if (param1 == QCODE_PEPPER)
		{
			COUNT_PEPPER += 1;
		}
		if (param1 == QCODE_MEAD)
		{
			COUNT_MEAD += 1;
		}
		if (param1 == QCODE_LADEL)
		{
			COUNT_LADEL += 1;
		}
		DO_THANK = 1;
	}

	void do_soup()
	{
		SetMoveDest(QUEST_PLAYER);
		chat_now("That's the way! All right!", 2.0, ANIM_VICTORY, "none", "add_to_que", "clear_que", "sound:voices/m2_quest/sylphiel_victory1.wav");
		chat_now("Haha! Alright, let's get cooking!", 2.0, "no_convo", "do_cook_loop", "add_to_que", "sound:voices/m2_quest/sylphiel_victory2.wav");
		COOK_COMPLAIN = GetGameTime();
		COOK_COMPLAIN += 10.0;
	}

	void do_cook_loop()
	{
		SetMoveAnim(ANIM_WALK);
		SetMoveDest(COOKING_POT_ID);
		string POT_ORG = GetEntityOrigin(COOKING_POT_ID);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string POT_DIST = Distance2D(MY_ORG, POT_ORG);
		LogDebug("do_cook_loop POT_DIST");
		if (POT_DIST > 32)
		{
			Random(1_0, 2_0)("do_cook_loop");
			if (GetGameTime() > COOK_COMPLAIN)
			{
				COOK_COMPLAIN = GetGameTime();
				COOK_COMPLAIN += 10.0;
				SayText("Stand aside, you're between me and my pot!");
				EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_blocked.wav", 10);
			}
		}
		else
		{
			do_soup2();
		}
	}

	void do_soup2()
	{
		SetMoveDest(COOKING_POT_ID);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_COOK);
		CallExternal(COOKING_POT_ID, "ext_cooking");
		ScheduleDelayedEvent(6.0, "soups_on");
	}

	void soups_on()
	{
		chat_now("Alright, I'm done with this...", 2.0, ANIM_COOK, "none", "clear_que", "add_to_que", "sound:voices/m2_quest/sylphiel_done.wav");
		chat_now("Gather here, form up, and get your soup!", 3.0, "no_convo", "soups_on2", "add_to_que", "sound:voices/m2_quest/sylphiel_soupson.wav");
	}

	void soups_on2()
	{
		PlayAnim("once", "break");
		SetMoveDest(LOCKED_PLAYER);
		SOUP_READY = 1;
	}

	void circle_pot()
	{
		if ((CIRCLE_ACTIVE))
		{
			string WANDER_POINT = GetEntityOrigin(COOKING_POT_ID);
			string ANGLE_TO_NPC = /* TODO: $angles */ $angles(WANDER_POINT, GetMonsterProperty("origin"));
			string MY_ORG = GetEntityOrigin(GetOwner());
			ANGLE_TO_NPC += 60.0;
			if (ANGLE_TO_NPC > 359.99)
			{
				ANGLE_TO_NPC -= 359.99;
			}
			WANDER_POINT += /* TODO: $relpos */ $relpos(Vector3(0, ANGLE_TO_NPC, 0), Vector3(0, 32, 0));
			SetMoveDest(WANDER_POINT);
			ScheduleDelayedEvent(1.0, "circle_pot");
		}
	}

	void menu_get_soup()
	{
		if (SOUP_LIST.length() > 0) SOUP_LIST += ";";
		SOUP_LIST += GetEntityIndex(param1);
		// TODO: offer PARAM1 mana_soup
		string L_QUEST_COUNT = GetPlayerQuestData(param1, "sy");
		L_QUEST_COUNT += 1;
		SetPlayerQuestData(param1, "sy");
		ShowHelpTip(param1, "generic", "Sylphiel's Soup", "Provides full health and three minutes of rapid mana regeneration");
		PlayAnim("once", "push_button");
		chat_now("There ya go, one free sample of Sylphee's delicious soup!", 2.0, "none", "none", "add_to_que");
		LAST_GAVE_SOUP = param1;
		string L_NSOUPS = GetTokenCount(SOUP_LIST, ";");
		L_NSOUPS += 1;
		if (L_NSOUPS >= "game.playersnb")
		{
			ScheduleDelayedEvent(2.0, "second_quest_start");
		}
		if ((SECOND_QUEST_OFFERED)) return;
		ScheduleDelayedEvent(90.0, "second_quest_start");
	}

	void second_quest_start()
	{
		if ((SECOND_QUEST_OFFERED)) return;
		SECOND_QUEST_OFFERED = 1;
		SECOND_QUEST_READY = 1;
		SetMoveDest(LAST_GAVE_SOUP);
		chat_now("Listen... There is one other little thing you can [help] me with, if you're interested.", 4.0, "ponder", "none", "add_to_que", "sound:voices/m2_quest/sylphiel_hey_listen.wav");
	}

	void second_quest_show()
	{
		PlayAnim("once", "break");
		SetMoveAnim("walk");
		SetMoveDest(POS_SECOND_QUEST);
		COMPLAIN_BLOCKED = GetGameTime();
		COMPLAIN_BLOCKED += 10.0;
		ScheduleDelayedEvent(1.0, "second_quest_show_loop");
	}

	void second_quest_show_loop()
	{
		string MY_POS = GetEntityOrigin(GetOwner());
		if (Distance(MY_POS, POS_SECOND_QUEST) > 8)
		{
			SetMoveDest(POS_SECOND_QUEST);
			Random(1_0, 2_0)("second_quest_show_loop");
			if (GetGameTime() > COMPLAIN_BLOCKED)
			{
				COMPLAIN_BLOCKED = GetGameTime();
				COMPLAIN_BLOCKED += 10.0;
				chat_now("Stand aside, you're in my way...", 1.0, "pondering3", "none", "add_to_que", "sound:voices/m2_quest/sylphiel_blocked.wav");
			}
		}
		else
		{
			second_quest_show2();
		}
	}

	void second_quest_show2()
	{
		SetAngles("face");
		UseTrigger("spawn_sylph_reward");
		chat_now("Have a look behind here...", 3.0, "buysoda", "second_quest_open_secret", "add_to_que", "sound:voices/m2_quest/sylphiel_lookhere.wav");
		chat_now("Search this carefully... I just want to be sure it's safe - but if you find anything, it's yours.", 4.0, "ponder", "none", "add_to_que", "sound:voices/m2_quest/sylphiel_secrets.wav");
	}

	void second_quest_open_secret()
	{
		SetAngles("face");
		UseTrigger("door_syph1");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		NPCATK_TARGET = GetEntityIndex(m_hLastStruck);
		SetMoveDest(m_hAttackTarget);
		do_attack();
		NEXT_PACE = GetGameTime();
		NEXT_PACE += 30.0;
	}

	void do_attack()
	{
		if (!(GetGameTime() > NEXT_ATTACK)) return;
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 3.0;
		if (RandomInt(1, 2) == 1)
		{
			chat_now("Bring it on!", 2.0, "seeya", "none", "add_to_que");
			EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_attacked.wav", 10);
		}
		else
		{
			chat_now("You're messing with more trouble than you can handle!", 2.0, "seeya", "none", "add_to_que");
			EmitSound(GetOwner(), 0, "voices/m2_quest/sylphiel_warn.wav", 10);
		}
		ScheduleDelayedEvent(2.0, "fake_frame_attack");
	}

	void fake_frame_attack()
	{
		DoDamage(m_hAttackTarget, 64, 2, 1.0, "blunt");
	}

	void ext_saw_chest()
	{
		chat_now("Oh, will you look at that, a sinister looking chest...", 4.0, "pondering", "none", "add_to_que");
		chat_now("Eh, just, take it. I don't even want to know what's in there.", 4.0, "none", "none", "add_to_que");
		chat_now("...and I'm also not going to ask what's kept that candle burning all this time.", 4.0, "none", "none", "add_to_que");
		chat_now("*sigh* It's just so typical of grams, having something like this.", 4.0, "pondering3", "none", "add_to_que");
		ALL_QUESTS_DONE = 1;
	}

	void npc_suicide()
	{
		if (param1 == "only_bad")
		{
			DeleteEntity(GetOwner());
		}
	}

}

}
