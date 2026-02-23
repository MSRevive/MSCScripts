#pragma context server

namespace MS
{

class BaseChatArray : CGameScript
{
	int CHAT_ABORT;
	string CHAT_ANIMS_ANAME;
	string CHAT_BUSY;
	string CHAT_CURRENT_SPEAKER;
	string CHAT_DELAYS_ANAME;
	string CHAT_END_MOVE_MOUTH;
	string CHAT_END_TIME;
	string CHAT_EVENTS_ANAME;
	int CHAT_IGNORE_WHILE_BUSY;
	string CHAT_LAST_USED_MENU;
	string CHAT_LINES_ANAME;
	int CHAT_MENU_ON;
	string CHAT_QUE_ACTIVE;
	string CHAT_SEQUENCE;
	string CHAT_SOUNDS_ANAME;
	string CHAT_SPOOL_OUT_ALL_COUNT;
	int CHAT_SPOOL_OUT_COUNT;
	string DUMP_CONVO;
	int HAS_BASE_CHAT_ARRAY_INCLUDE;

	BaseChatArray()
	{
		const string CHAT_CONV_ANIMS = "converse2;converse1;talkleft;talkright;lean;pondering;pondering2;pondering3;";
		HAS_BASE_CHAT_ARRAY_INCLUDE = 1;
		const int CHAT_NEVER_INTERRUPT = 0;
		const int CHAT_USE_BUSY_MESSAGE = 1;
		const int CHAT_USE_CONV_ANIMS = 1;
		const int CHAT_MOVE_MOUTH = 1;
		const int CHAT_NO_CLOSE_MOUTH = 0;
		const int CHAT_AUTO_FACE = 1;
		const int CHAT_FACE_ON_USE = 1;
		const int CHAT_MENU_ENABLE = 1;
		const int CHAT_RESET_ON_NEW = 0;
		CHAT_IGNORE_WHILE_BUSY = 0;
		const string CHAT_PLAYANIM_STYLE = "critical";
		CHAT_MENU_ON = 1;
		const int CHAT_AUTO_HAIL = 0;
		const int CHAT_AUTO_JOB = 0;
		const int CHAT_AUTO_RUMOR = 0;
		const int CHAT_MAX_LINE_LEN = 192;
		const float CHAT_DELAY = 4.0;
		CHAT_CURRENT_SPEAKER = "none";
	}

	void OnSpawn() override
	{
		SetMenuAutoOpen(CHAT_MENU_ENABLE);
		if ((CHAT_AUTO_HAIL))
		{
			CatchSpeech("say_hi", "hail");
		}
		if ((CHAT_AUTO_JOB))
		{
			CatchSpeech("say_job", "job");
		}
		if ((CHAT_AUTO_RUMOR))
		{
			CatchSpeech("say_rumor", "rumour");
		}
		array<string> CONVO_QUE_LINES;
		array<string> CONVO_QUE_DELAYS;
		array<string> CONVO_QUE_ANIMS;
		array<string> CONVO_QUE_EVENTS;
		array<string> CONVO_QUE_SOUNDS;
	}

	void game_menu_getoptions()
	{
		CHAT_CURRENT_SPEAKER = param1;
		CHAT_LAST_USED_MENU = param1;
		if ((CHAT_FACE_ON_USE))
		{
			SetMoveDest(param1);
		}
		if (!(CHAT_MENU_ON)) return;
		if ((CHAT_AUTO_HAIL))
		{
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
		}
		if ((CHAT_AUTO_JOB))
		{
			string reg.mitem.title = "Ask about Jobs";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
		if ((CHAT_AUTO_RUMOR))
		{
			string reg.mitem.title = "Ask about Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rumor";
		}
	}

	void chat_add_text()
	{
		string CONVO_NAME = param1;
		string CONVO_DELAYS = CONVO_NAME;
		CONVO_DELAYS += "_DELAYS";
		string CONVO_ANIMS = CONVO_NAME;
		CONVO_ANIMS += "_ANIMS";
		string CONVO_EVENTS = CONVO_NAME;
		CONVO_EVENTS += "_EVENTS";
		string CONVO_SOUNDS = CONVO_NAME;
		CONVO_SOUNDS += "_SOUNDS";
		string CONV_ARRAY_EXISTS = /* TODO: $get_array */ $get_array(param1, 0);
		if ((CONV_ARRAY_EXISTS).findFirst("[ERROR_NO_ARRAY]") >= 0)
		{
			LogDebug("chat_add_text creating new array for CONVO_NAME");
			array<string> CONVO_NAME;
			array<string> CONVO_DELAYS;
			array<string> CONVO_ANIMS;
			array<string> CONVO_EVENTS;
			array<string> CONVO_SOUNDS;
		}
		string L_CHAT_TEXT = param2;
		string L_CHAT_DELAY = param3;
		if ((L_CHAT_DELAY).findFirst("PARAM") == 0)
		{
			string L_CHAT_DELAY = CHAT_DELAY;
		}
		string L_CHAT_ANIM = param4;
		if ((L_CHAT_ANIM).findFirst("PARAM") == 0)
		{
			string L_CHAT_ANIM = "none";
		}
		string L_CHAT_EVENT = param5;
		if ((L_CHAT_EVENT).findFirst("PARAM") == 0)
		{
			string L_CHAT_EVENT = "none";
		}
		string L_CHAT_SOUND = "none";
		if ((param3).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param3;
		}
		if ((param4).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param4;
		}
		if ((param5).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param5;
		}
		if ((param6).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param6;
		}
		if ((param7).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param7;
		}
		if ((param8).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param8;
		}
		if (L_CHAT_SOUND != "none")
		{
			string L_SOUND_LENGTH = (L_CHAT_SOUND).length();
			L_SOUND_LENGTH -= 6;
			string L_CHAT_SOUND = (L_CHAT_SOUND).substr((L_CHAT_SOUND).length() - L_SOUND_LENGTH);
			LogDebug("chat_add_text SOUND: L_CHAT_SOUND");
		}
		CONVO_NAME.insertLast(L_CHAT_TEXT);
		CONVO_DELAYS.insertLast(L_CHAT_DELAY);
		CONVO_ANIMS.insertLast(L_CHAT_ANIM);
		CONVO_EVENTS.insertLast(L_CHAT_EVENT);
		CONVO_SOUNDS.insertLast(L_CHAT_SOUND);
		string ARRAY_IDX = /* TODO: $get_array_amt */ $get_array_amt(CONVO_NAME);
		ARRAY_IDX -= 1;
		string DBG_TXT = /* TODO: $get_array */ $get_array(CONVO_NAME, ARRAY_IDX);
		LogDebug("chat_add_text final PARAM1 step ARRAY_IDX txt[ (DBG_TXT).substr(0, 11) ] del /* TODO: $get_array */ $get_array(CONVO_DELAYS, ARRAY_IDX) anim /* TODO: $get_array */ $get_array(CONVO_ANIMS, ARRAY_IDX) event /* TODO: $get_array */ $get_array(CONVO_EVENTS, ARRAY_IDX)");
	}

	void chat_start_sequence()
	{
		LogDebug("chat_start_sequence PARAM1 PARAM2");
		if (param2 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if (param3 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if (param4 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if (param2 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if (param3 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if (param4 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if ((CHAT_RESET_ON_NEW))
		{
			int CLEAR_QUE = 1;
		}
		if ((CHAT_AUTO_FACE))
		{
			if (!(CHAT_TEMP_NO_AUTO_FACE))
			{
			}
			chat_face_speaker();
		}
		CHAT_ABORT = 0;
		string CONVO_NAME = param1;
		string CONV_ARRAY_EXISTS = /* TODO: $get_array */ $get_array(param1, 0);
		if ((CONV_ARRAY_EXISTS).findFirst("[ERROR_NO_ARRAY]") >= 0)
		{
			SayText("[error] conversation CONVO_NAME does not exist!");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(ADD_TO_QUE))
		{
			if ((CHAT_BUSY))
			{
			}
			if ((CLEAR_QUE))
			{
				npc_chat_was_busy("started_new");
			}
			if (!(CLEAR_QUE))
			{
			}
			if ((CHAT_IGNORE_WHILE_BUSY))
			{
				LogDebug("chat_start_sequence: Attempted to start new chat PARAM1 while already in conversation and ignore flag set");
				npc_chat_was_busy("ignored");
				int EXIT_SUB = 1;
			}
			else
			{
				npc_chat_was_busy("added");
			}
		}
		if ((EXIT_SUB)) return;
		if ((CLEAR_QUE))
		{
			chat_clear_que("chat_start_sequence");
		}
		if (param2 == "prioritize")
		{
			CHAT_IGNORE_WHILE_BUSY = 1;
		}
		if (param3 == "prioritize")
		{
			CHAT_IGNORE_WHILE_BUSY = 1;
		}
		if (param4 == "prioritize")
		{
			CHAT_IGNORE_WHILE_BUSY = 1;
		}
		if ((CHAT_NEVER_INTERRUPT))
		{
			CHAT_IGNORE_WHILE_BUSY = 1;
		}
		CHAT_SEQUENCE = CONVO_NAME;
		CHAT_LINES_ANAME = CONVO_NAME;
		CHAT_DELAYS_ANAME = CONVO_NAME;
		CHAT_DELAYS_ANAME += "_DELAYS";
		CHAT_ANIMS_ANAME = CONVO_NAME;
		CHAT_ANIMS_ANAME += "_ANIMS";
		CHAT_EVENTS_ANAME = CONVO_NAME;
		CHAT_EVENTS_ANAME += "_EVENTS";
		CHAT_SOUNDS_ANAME = CONVO_NAME;
		CHAT_SOUNDS_ANAME += "_SOUNDS";
		LogDebug("requesting_que /* TODO: $get_array_amt */ $get_array_amt(CHAT_LINES_ANAME) lines");
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(CHAT_LINES_ANAME); i++)
		{
			chat_add_to_que();
		}
		if (!(CHAT_QUE_ACTIVE))
		{
			CHAT_QUE_ACTIVE = 1;
			chat_cycle_que();
		}
	}

	void chat_convo_anim()
	{
		string N_ANIMS = GetTokenCount(CHAT_CONV_ANIMS, ";");
		N_ANIMS -= 1;
		string RND_ANIM = RandomInt(0, N_ANIMS);
		PlayAnim("CHAT_PLAYANIM_STYLE", GetToken(CHAT_CONV_ANIMS, RND_ANIM, ";"));
	}

	void chat_move_mouth()
	{
		if ((param1).findFirst("PARAM") == 0)
		{
			int DO_NADDA = 1;
		}
		else
		{
			CHAT_END_MOVE_MOUTH = GetGameTime();
			CHAT_END_MOVE_MOUTH += param1;
			CHAT_END_MOVE_MOUTH -= 1.0;
			LogDebug("bchat_auto_mouth_move PARAM1");
		}
		if (GetGameTime() < CHAT_END_MOVE_MOUTH)
		{
			string RND_SAY = "[";
			string M_TIME = Random(0.1, 0.3);
			RND_SAY += M_TIME;
			RND_SAY += "]";
			Say("RND_SAY");
			M_TIME += 0.1;
			M_TIME("chat_close_mouth");
			M_TIME += 0.1;
			M_TIME("chat_move_mouth");
		}
	}

	void chat_close_mouth()
	{
		if ((CHAT_NO_CLOSE_MOUTH)) return;
		SetProp(GetOwner(), "controller1", 0);
	}

	void chat_open_mouth()
	{
		SetProp(GetOwner(), "controller1", -1);
	}

	void chat_face_speaker()
	{
		if (param1 != "PARAM1")
		{
			CHAT_CURRENT_SPEAKER = param1;
		}
		else
		{
			chat_find_speaker_id();
		}
		SetMoveDest(CHAT_CURRENT_SPEAKER);
	}

	void chat_find_speaker_id()
	{
		string L_LAST_SPOKE = GetEntityIndex("ent_lastspoke");
		if ((IsEntityAlive(L_LAST_SPOKE)))
		{
			if (GetEntityRange(L_LAST_SPOKE) < 512)
			{
			}
			CHAT_CURRENT_SPEAKER = L_LAST_SPOKE;
		}
		else
		{
			if ((IsEntityAlive(CHAT_LAST_USED_MENU)))
			{
				if (GetEntityRange(CHAT_LAST_USED_MENU) < 512)
				{
				}
				CHAT_CURRENT_SPEAKER = CHAT_LAST_USED_MENU;
			}
			else
			{
				if (!(IsEntityAlive(CHAT_CURRENT_SPEAKER)))
				{
					LogDebug("failed to find speaker , wild guess");
					CHAT_CURRENT_SPEAKER = /* TODO: $get_insphere */ $get_insphere("player", 512);
				}
				else
				{
					if (!(IsEntityAlive(CHAT_CURRENT_SPEAKER)))
					{
						GetAllPlayers(PLAYER_LIST);
						CHAT_CURRENT_SPEAKER = GetToken(PLAYER_LIST, 0, ";");
					}
				}
			}
		}
	}

	void chat_now()
	{
		if ((param2).findFirst(PARAM) == 0)
		{
			string L_LINE_LENGTH = (param1).length();
			if (L_LINE_LENGTH > 100)
			{
				// TODO: UNCONVERTED: if ( L_LINE_LENGTH > 100 ) L_LINE_LENGTH 100
			}
			string L_LINE_RATIO = L_LINE_LENGTH;
			L_LINE_RATIO /= 100;
			string PARAM2 = /* TODO: $ratio */ $ratio(L_LINE_RATIO, 1.5, 6.0);
		}
		if (param2 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if (param3 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if (param4 == "clear_que")
		{
			int CLEAR_QUE = 1;
		}
		if ((CHAT_RESET_ON_NEW))
		{
			int CLEAR_QUE = 1;
		}
		if (param2 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if (param3 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if (param4 == "add_to_que")
		{
			int ADD_TO_QUE = 1;
		}
		if (param2 == "add_to_que")
		{
			string PARAM2 = "PARAM";
		}
		if (param3 == "add_to_que")
		{
			string PARAM3 = "PARAM";
		}
		if (param4 == "add_to_que")
		{
			string PARAM4 = "PARAM";
		}
		if (param2 == "clear_que")
		{
			string PARAM2 = "PARAM";
		}
		if (param3 == "clear_que")
		{
			string PARAM3 = "PARAM";
		}
		if (param4 == "clear_que")
		{
			string PARAM4 = "PARAM";
		}
		string L_CHAT_SOUND = "none";
		if ((param3).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param3;
		}
		if ((param4).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param4;
		}
		if ((param5).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param5;
		}
		if ((param6).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param6;
		}
		if ((param7).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param7;
		}
		if ((param8).findFirst("sound:") == 0)
		{
			string L_CHAT_SOUND = param8;
		}
		if (L_CHAT_SOUND != "none")
		{
			string L_SOUND_LENGTH = (L_CHAT_SOUND).length();
			L_SOUND_LENGTH -= 6;
			string L_CHAT_SOUND = (L_CHAT_SOUND).substr(6, L_SOUND_LENGTH);
			LogDebug("L_CHAT_SOUND");
		}
		if ((CHAT_AUTO_FACE))
		{
			if (!(CHAT_TEMP_NO_AUTO_FACE))
			{
			}
			chat_face_speaker();
		}
		if (!(ADD_TO_QUE))
		{
			if ((CHAT_BUSY))
			{
			}
			if ((CLEAR_QUE))
			{
				npc_chat_was_busy("started_new");
			}
			if (!(CLEAR_QUE))
			{
			}
			if ((CHAT_IGNORE_WHILE_BUSY))
			{
				LogDebug("chat_now: Attempted to start new chat PARAM1 while already in conversation and Ignore flag set");
				npc_chat_was_busy("ignored");
				int EXIT_SUB = 1;
			}
			else
			{
				npc_chat_was_busy("added");
			}
		}
		if ((EXIT_SUB)) return;
		if ((CLEAR_QUE))
		{
			chat_clear_que("chat_now");
		}
		string L_CHAT_TEXT = param1;
		string L_CHAT_DELAY = param2;
		if ((L_CHAT_DELAY).findFirst("PARAM") == 0)
		{
			string L_CHAT_DELAY = CHAT_DELAY;
		}
		string L_CHAT_ANIM = param3;
		if ((L_CHAT_ANIM).findFirst("PARAM") == 0)
		{
			string L_CHAT_ANIM = "none";
		}
		string L_CHAT_EVENT = param4;
		if ((L_CHAT_EVENT).findFirst("PARAM") == 0)
		{
			string L_CHAT_EVENT = "none";
		}
		CONVO_QUE_LINES.insertLast(L_CHAT_TEXT);
		CONVO_QUE_DELAYS.insertLast(L_CHAT_DELAY);
		CONVO_QUE_ANIMS.insertLast(L_CHAT_ANIM);
		CONVO_QUE_EVENTS.insertLast(L_CHAT_EVENT);
		CONVO_QUE_SOUNDS.insertLast(L_CHAT_SOUND);
		if (!(CHAT_QUE_ACTIVE))
		{
			CHAT_QUE_ACTIVE = 1;
			chat_cycle_que();
		}
	}

	void chat_pause()
	{
		CHAT_QUE_ACTIVE = 0;
	}

	void chat_resume()
	{
		if (!(CHAT_QUE_ACTIVE))
		{
			CHAT_QUE_ACTIVE = 1;
			chat_cycle_que();
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(CHAT_BUSY)) return;
		chat_pause();
	}

	void ext_dump_chat()
	{
		DUMP_CONVO = param1;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(DUMP_CONVO); i++)
		{
			dump_chat();
		}
	}

	void dump_chat()
	{
		string CUR_IDX = i;
		string CUR_LINES_ANAME = DUMP_CONVO;
		string CUR_DELAYS = DUMP_CONVO;
		CUR_DELAYS += _DELAYS;
		string CUR_ANIMS = DUMP_CONVO;
		CUR_ANIMS += "_ANIMS";
		string CUR_EVENTS = DUMP_CONVO;
		CUR_EVENTS += "_EVENTS";
		string CUR_SOUNDS = DUMP_CONVO;
		CUR_SOUNDS += "_SOUNDS";
		string CUR_TEXT = /* TODO: $get_array */ $get_array(CUR_LINES_ANAME, CUR_IDX);
		string CUR_DELAY = /* TODO: $get_array */ $get_array(CUR_DELAYS, CUR_IDX);
		string CUR_ANIM = /* TODO: $get_array */ $get_array(CUR_ANIMS, CUR_IDX);
		string CUR_EVENT = /* TODO: $get_array */ $get_array(CUR_EVENTS, CUR_IDX);
		string CUR_SOUND = /* TODO: $get_array */ $get_array(CUR_SOUNDS, CUR_IDX);
		LogDebug("dump DUMP_CONVO # CUR_IDX txt[ (CUR_TEXT).substr(0, 11) ] del CUR_DELAY anim CUR_ANIM evt CUR_EVENT snd CUR_SOUND");
	}

	void chat_add_to_que()
	{
		string CUR_IDX = i;
		string CUR_LINE = /* TODO: $get_array */ $get_array(CHAT_LINES_ANAME, CUR_IDX);
		string CUR_DELAY = /* TODO: $get_array */ $get_array(CHAT_DELAYS_ANAME, CUR_IDX);
		string CUR_ANIM = /* TODO: $get_array */ $get_array(CHAT_ANIMS_ANAME, CUR_IDX);
		string CUR_EVENT = /* TODO: $get_array */ $get_array(CHAT_EVENTS_ANAME, CUR_IDX);
		string CUR_SOUND = /* TODO: $get_array */ $get_array(CHAT_SOUNDS_ANAME, CUR_IDX);
		LogDebug("chat_add_to_que: CUR_IDX [ (CUR_LINE).substr(0, 20) ... ]");
		CONVO_QUE_LINES.insertLast(CUR_LINE);
		CONVO_QUE_DELAYS.insertLast(CUR_DELAY);
		CONVO_QUE_ANIMS.insertLast(CUR_ANIM);
		CONVO_QUE_EVENTS.insertLast(CUR_EVENT);
		CONVO_QUE_SOUNDS.insertLast(CUR_SOUND);
	}

	void chat_clear_que()
	{
		LogDebug("chat_clear_que called from PARAM1");
		CHAT_SPOOL_OUT_ALL_COUNT = /* TODO: $get_array_amt */ $get_array_amt(CONVO_QUE_LINES);
		chat_clear_que_loop();
	}

	void chat_clear_que_loop()
	{
		CHAT_SPOOL_OUT_COUNT = 0;
		spool_out_line();
		CHAT_SPOOL_OUT_ALL_COUNT -= 1;
		if (!(CHAT_SPOOL_OUT_ALL_COUNT > 0)) return;
		ScheduleDelayedEvent(0.26, "chat_clear_que_loop");
	}

	void chat_cycle_que()
	{
		if (!(CHAT_QUE_ACTIVE)) return;
		if (/* TODO: $get_array_amt */ $get_array_amt(CONVO_QUE_LINES) == 0)
		{
			CHAT_BUSY = 0;
			CHAT_QUE_ACTIVE = 0;
			CHAT_IGNORE_WHILE_BUSY = 0;
			int EXIT_SUB = 1;
		}
		else
		{
			string CUR_DELAY = /* TODO: $get_array */ $get_array(CONVO_QUE_DELAYS, 0);
			CHAT_END_TIME = GetGameTime();
			CHAT_END_TIME += CUR_DELAY;
			string L_CHAT_END_PLUS = CUR_DELAY;
			L_CHAT_END_PLUS += 0.1;
			if (L_CHAT_END_PLUS < 1)
			{
				float L_CHAT_END_PLUS = 1.0;
			}
			L_CHAT_END_PLUS("chat_cycle_que");
		}
		if ((EXIT_SUB)) return;
		string CUR_DELAY = /* TODO: $get_array */ $get_array(CONVO_QUE_DELAYS, 0);
		CHAT_END_TIME = GetGameTime();
		CHAT_END_TIME += CUR_DELAY;
		if ((G_DEVELOPER_MODE))
		{
			string L_CUR_TEXT = /* TODO: $get_array */ $get_array(CONVO_QUE_LINES, 0);
			string L_CUR_DELAY = /* TODO: $get_array */ $get_array(CONVO_QUE_DELAYS, 0);
			string L_CUR_ANIM = /* TODO: $get_array */ $get_array(CONVO_QUE_ANIMS, 0);
			string L_CUR_EVENT = /* TODO: $get_array */ $get_array(CONVO_QUE_EVENTS, 0);
			string L_CUR_SOUND = /* TODO: $get_array */ $get_array(CONVO_QUE_SOUNDS, 0);
			LogDebug("chat_cycle_que line# /* TODO: $get_array_amt */ $get_array_amt(CONVO_QUE_LINES) txt [ (L_CUR_TEXT).substr(0, 11) ] delay L_CUR_DELAY anim L_CUR_ANIM evnt L_CUR_EVENT snd L_CUR_SOUND");
		}
		string CUR_LINE = /* TODO: $get_array */ $get_array(CONVO_QUE_LINES, 0);
		string CUR_LEN = (CUR_LINE).length();
		CUR_LEN += (GetMonsterProperty("name")).length();
		CUR_LEN += 6;
		if (CUR_LEN < CHAT_MAX_LINE_LEN)
		{
			SayText("CUR_LINE");
		}
		else
		{
			SayText("[ERROR: LINE TOO LONG!] [ CHAT_LINES_ANAME int(CUR_LEN) / int(CHAT_MAX_LINE_LEN) ]");
		}
		CHAT_BUSY = 1;
		string CUR_ANIM = /* TODO: $get_array */ $get_array(CONVO_QUE_ANIMS, 0);
		if (CUR_ANIM != "none")
		{
			if (CUR_ANIM != "no_convo")
			{
				PlayAnim("CHAT_PLAYANIM_STYLE", CUR_ANIM);
			}
		}
		else
		{
			if ((CHAT_USE_CONV_ANIMS))
			{
			}
			chat_convo_anim();
		}
		string CUR_SOUND = /* TODO: $get_array */ $get_array(CONVO_QUE_SOUNDS, 0);
		if (CUR_SOUND != "none")
		{
			EmitSound(GetOwner(), 0, CUR_SOUND, 10);
		}
		string CUR_EVENT = /* TODO: $get_array */ $get_array(CONVO_QUE_EVENTS, 0);
		if (CUR_EVENT != "none")
		{
			LogDebug("calling chat_event CUR_EVENT");
			if ((CUR_EVENT).findFirst("!") == 0)
			{
				string LEN_CUR_EVENT = (CUR_EVENT).length();
				LEN_CUR_EVENT -= 1;
				string CUR_EVENT = (CUR_EVENT).substr((CUR_EVENT).length() - LEN_CUR_EVENT);
				CUR_EVENT();
			}
			else
			{
				CUR_DELAY(CUR_EVENT);
			}
		}
		if ((CHAT_MOVE_MOUTH))
		{
			chat_move_mouth(CUR_DELAY);
		}
		CHAT_SPOOL_OUT_COUNT = 0;
		spool_out_line();
	}

	void spool_out_line()
	{
		CHAT_SPOOL_OUT_COUNT += 1;
		if (CHAT_SPOOL_OUT_COUNT == 1)
		{
			CONVO_QUE_LINES.removeAt(0);
		}
		if (CHAT_SPOOL_OUT_COUNT == 2)
		{
			CONVO_QUE_DELAYS.removeAt(0);
		}
		if (CHAT_SPOOL_OUT_COUNT == 3)
		{
			CONVO_QUE_ANIMS.removeAt(0);
		}
		if (CHAT_SPOOL_OUT_COUNT == 4)
		{
			CONVO_QUE_EVENTS.removeAt(0);
		}
		if (CHAT_SPOOL_OUT_COUNT == 5)
		{
			CONVO_QUE_SOUNDS.removeAt(0);
		}
		if (!(CHAT_SPOOL_OUT_COUNT < 5)) return;
		ScheduleDelayedEvent(0.05, "spool_out_line");
	}

	void npc_chat_was_busy()
	{
		LogDebug("npc_chat_was_busy PARAM1");
		if (!(CHAT_USE_BUSY_MESSAGE)) return;
		if (!(param1 == "ignored")) return;
		chat_busy_message();
	}

	void chat_busy_message()
	{
		if (!(IsEntityAlive(CHAT_CURRENT_SPEAKER)))
		{
			chat_find_speaker_id();
		}
		SendColoredMessage(CHAT_CURRENT_SPEAKER, "It would be polite to wait until GetEntityName(GetOwner()) has finished speaking.");
	}

}

}
