#pragma context server

#include "monsters/debug.as"

namespace MS
{

class SoccerBall : CGameScript
{
	string ADJ_PITCH;
	string AM_BOUNCY;
	int AM_HOME;
	string ATK_ANG;
	string ATK_ID;
	string BALL_WEIGHTS;
	string BLUE_SCORE_TOKENS;
	int COUNT_DOWN;
	string COUNT_DOWN_ABORT;
	string COUNT_DOWN_EVENT;
	string CUR_TOKEN_LIST;
	string DEST_POINTS;
	int GAME_PAUSED;
	int GAME_STARTED;
	string GAME_WON;
	int HOME_REPEAT;
	int IS_SOCCER_BALL;
	int NEXT_BALL_WEIGHT;
	string NEXT_IDLE_SOUND;
	int NPC_ATTACK_INVULN;
	string NPC_HOME_LOC;
	int POINTS_BLUE;
	int POINTS_RED;
	string RED_SCORE_TOKENS;
	int SB_BLUE0;
	int SB_BLUE1;
	int SB_BLUE2;
	int SB_BLUE3;
	int SB_BLUE4;
	int SB_BLUE5;
	int SB_RED0;
	int SB_RED1;
	int SB_RED2;
	int SB_RED3;
	int SB_RED4;
	int SB_RED5;
	int SENSE_RANGE;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_IDLE4;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STRUCK4;
	string SOUND_STRUCK5;
	string SOUND_STRUCK6;
	string TRACK_TARGET;
	string TWAL_TEAM_SUFFIX;

	SoccerBall()
	{
		NPC_ATTACK_INVULN = 1;
		POINTS_RED = 0;
		POINTS_BLUE = 0;
		BALL_WEIGHTS = "0.1;0.25;0.5;1.0;2.0";
		NEXT_BALL_WEIGHT = 4;
		IS_SOCCER_BALL = 1;
		SENSE_RANGE = 128;
		SB_BLUE0 = 0;
		SB_BLUE1 = 0;
		SB_BLUE2 = 0;
		SB_BLUE3 = 0;
		SB_BLUE4 = 0;
		SB_BLUE5 = 0;
		BLUE_SCORE_TOKENS = "0;0;0;0;0;0";
		RED_SCORE_TOKENS = "0;0;0;0;0;0";
		SB_RED0 = 0;
		SB_RED1 = 0;
		SB_RED2 = 0;
		SB_RED3 = 0;
		SB_RED4 = 0;
		SB_RED5 = 0;
		SOUND_IDLE1 = "houndeye/he_idle4.wav";
		SOUND_IDLE2 = "houndeye/he_pain1.wav";
		SOUND_IDLE3 = "houndeye/he_pain3.wav";
		SOUND_IDLE4 = "houndeye/he_alert2.wav";
		SOUND_STRUCK1 = "houndeye/he_die1.wav";
		SOUND_STRUCK2 = "houndeye/he_die2.wav";
		SOUND_STRUCK3 = "houndeye/he_pain2.wav";
		SOUND_STRUCK4 = "houndeye/he_pain4.wav";
		SOUND_STRUCK5 = "houndeye/he_pain5.wav";
		SOUND_STRUCK6 = "houndeye/he_alert3.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if (GetEntitySpeed(GetOwner()) > 50)
		{
			PlayAnim("once", "spin_horizontal_slow");
		}
		if (GetEntitySpeed(GetOwner()) > 200)
		{
			PlayAnim("once", "spin_horizontal_fast");
		}
		if ((IsEntityAlive(TRACK_TARGET)))
		{
		}
		if (GetEntityRange(TRACK_TARGET) < SENSE_RANGE)
		{
			if (GetEntitySpeed(GetOwner()) > 0)
			{
				ADJ_PITCH = -1.1;
				SetProp(GetOwner(), "controller0", ADJ_PITCH);
			}
			if (GetEntitySpeed(GetOwner()) == 0)
			{
			}
			SetMoveDest(TRACK_TARGET);
			string TARG_ORG = GetEntityOrigin(TRACK_TARGET);
			string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(GetMonsterProperty("origin"), TARG_ORG);
			ANG_TO_TARG = "x";
			ADJ_PITCH = (ANG_TO_TARG).x;
			ADJ_PITCH += 20;
			if (ADJ_PITCH > -1.1)
			{
				ADJ_PITCH = -1.1;
			}
			SetProp(GetOwner(), "controller0", ADJ_PITCH);
			if (GetGameTime() > NEXT_IDLE_SOUND)
			{
			}
			NEXT_IDLE_SOUND = GetGameTime();
			NEXT_IDLE_SOUND += Random(20.0, 30.0);
			PlayAnim("once", "idle_scared");
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4};
			EmitSound(GetOwner(), 4, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (ADJ_PITCH > -1.1)
			{
				ADJ_PITCH -= 0.1;
			}
			if (ADJ_PITCH < -1.1)
			{
				ADJ_PITCH += 0.1;
			}
			if (GetEntitySpeed(GetOwner()) > 0)
			{
				ADJ_PITCH = -1.1;
			}
			SetProp(GetOwner(), "controller0", ADJ_PITCH);
		}
	}

	void OnSpawn() override
	{
		SetName("Soccer Ball");
		SetModel("soccer/soccer_ball.mdl");
		SetWidth(32);
		SetHeight(38);
		SetName("soccer_ball");
		SetHearingSensitivity(2);
		SetGravity(1.0);
		if (!(true)) return;
		SetRace("hated");
		SetHealth(1);
		ADJ_PITCH = -1.1;
		SetIdleAnim("idle_standard");
		SetMoveAnim("idle_standard");
		SetSayTextRange(4096);
		SetMonsterClip(1);
		SetMenuAutoOpen(1);
		GAME_PAUSED = 1;
		SetNoPush(true);
		ScheduleDelayedEvent(0.1, "get_home_pos");
		ScheduleDelayedEvent(1.0, "update_scoreboards");
	}

	void get_home_pos()
	{
		SetGlobalVar("G_CHRISTMAS_MODE", 0);
		NPC_HOME_LOC = GetEntityOrigin(GetOwner());
		PlayAnim("critical", "idle_standard");
		NEXT_IDLE_SOUND = GetGameTime();
		NEXT_IDLE_SOUND += Random(20.0, 30.0);
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(GetEntityRange(LAST_HEARD) < SENSE_RANGE)) return;
		TRACK_TARGET = LAST_HEARD;
	}

	void OnDamage(int damage) override
	{
		if ((GAME_PAUSED))
		{
			if (!(GAME_STARTED))
			{
				SendInfoMsg(param1, "CLICK THE BALL TO BEGIN Click USE on the ball to begin the game...");
			}
			SendColoredMessage(param1, "Ball not yet in play...");
		}
		AM_HOME = 0;
		SetDamage("hit");
		SetDamage("dmg");
		return;
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5, SOUND_STRUCK6
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5, SOUND_STRUCK6};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ATK_ID = param1;
		ATK_ANG = GetEntityProperty(param1, "viewangles");
		ScheduleDelayedEvent(0.1, "adj_vel");
	}

	void ext_kicked()
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5, SOUND_STRUCK6
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5, SOUND_STRUCK6};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void adj_vel()
	{
		if (!(IsValidPlayer(param1))) return;
		string MY_VEL = GetEntityVelocity(GetOwner());
		ATK_ANG = "x";
		MY_VEL = /* TODO: $relvel */ $relvel(ATK_ANG, MY_VEL);
		SetVelocity(GetOwner(), MY_VEL);
	}

	void game_menu_getoptions()
	{
		if (!(GAME_STARTED))
		{
			string reg.mitem.title = "BEGIN GAME!";
			string reg.mitem.type = "callback";
			int reg.mitem.data = 1;
			string reg.mitem.callback = "soc_game_begin";
		}
		string BALL_WEIGHT_MENU = "Set ball weight to ";
		BALL_WEIGHT_MENU += GetToken(BALL_WEIGHTS, NEXT_BALL_WEIGHT, ";");
		string reg.mitem.title = BALL_WEIGHT_MENU;
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_weight";
		if (!(AM_BOUNCY))
		{
			string reg.mitem.title = "Bouncy Ball";
			string reg.mitem.type = "callback";
			int reg.mitem.data = 1;
			string reg.mitem.callback = "set_bouncy";
		}
		else
		{
			string reg.mitem.title = "Less Bouncy";
			string reg.mitem.type = "callback";
			int reg.mitem.data = 0;
			string reg.mitem.callback = "set_bouncy";
		}
		string reg.mitem.title = "Move Ball Home";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "reset_ball";
		if (POINTS_RED != 0)
		{
			int OPT_RESET_SCORES = 1;
		}
		if (POINTS_BLUE != 0)
		{
			int OPT_RESET_SCORES = 1;
		}
		if ((OPT_RESET_SCORES))
		{
			string reg.mitem.title = "Reset Scores";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "reset_scores";
		}
		if ((G_DEVELOPER_MODE))
		{
			string reg.mitem.title = "DELETE BALL";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_dev_delete";
		}
		if (!(GAME_STARTED)) return;
		if (!(GAME_PAUSED))
		{
			string reg.mitem.title = "Call Timeout";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "call_timeout";
		}
		else
		{
			if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
			{
				int SORCS_ACTIVE = 1;
			}
			if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
			{
				int SORCS_ACTIVE = 1;
			}
			if ((SORCS_ACTIVE))
			{
				string reg.mitem.title = "Reset Positions";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "reset_sorcs";
			}
			string reg.mitem.title = "Call Time In";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "call_timein";
		}
	}

	void menu_dev_delete()
	{
		DeleteEntity(GetOwner());
	}

	void reset_sorcs()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " reset sorc positions";
		SendInfoMsg("all", "SORCS RESET " + OUT_MSG);
		CallExternal("all", "extsoc_reset");
	}

	void call_timeout()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " called time out";
		SendInfoMsg("all", "TIME OUT! " + OUT_MSG);
		CallExternal("all", "ext_soccer_timeout");
		pause_game();
	}

	void call_timein()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " called time in";
		SendInfoMsg("all", "TIME IN! " + OUT_MSG);
		CallExternal("all", "ext_soccer_timein");
		unpause_game();
	}

	void reset_ball()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " sent the ball home";
		SendInfoMsg("all", "BALL RESET " + OUT_MSG);
		AM_HOME = 0;
		SetEntityOrigin(GetOwner(), Vector3(5000, 5000, -5000));
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		SetProp(GetOwner(), "velocity", Vector3(0, 0, 0));
		HOME_REPEAT = 1;
		move_ball_home();
	}

	void reset_scores()
	{
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " reset the scores";
		SendInfoMsg("all", "SCORES RESET " + OUT_MSG);
		POINTS_BLUE = 0;
		POINTS_RED = 0;
		update_scoreboards();
	}

	void set_weight()
	{
		SetGravity(GetToken(BALL_WEIGHTS, NEXT_BALL_WEIGHT, ";"));
		string OUT_MSG = GetEntityName(param1);
		OUT_MSG += " changed ball weight to ";
		OUT_MSG += GetToken(BALL_WEIGHTS, NEXT_BALL_WEIGHT, ";");
		SendInfoMsg("all", "BALL WEIGHT CHANGE " + OUT_MSG);
		NEXT_BALL_WEIGHT += 1;
		if (NEXT_BALL_WEIGHT >= GetTokenCount(BALL_WEIGHTS, ";"))
		{
			NEXT_BALL_WEIGHT = 0;
		}
	}

	void set_bouncy()
	{
		string BOUNCY_ON = param2;
		if ((BOUNCY_ON))
		{
			AM_BOUNCY = 1;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " made the ball bouncier!";
			SendInfoMsg("all", "BOUNCY BALL " + OUT_MSG);
			SetProp(GetOwner(), "movetype", 10);
		}
		else
		{
			AM_BOUNCY = 0;
			string OUT_MSG = GetEntityName(param1);
			OUT_MSG += " restored the ball to normal.";
			SendInfoMsg("all", "NOT SO BOUNCY BALL " + OUT_MSG);
			SetProp(GetOwner(), "movetype", 4);
		}
	}

	void ext_blue_scores_goal()
	{
		POINTS_BLUE += 1;
		update_scoreboards();
		CallExternal("players", "extsoc_show_scores", POINTS_RED, POINTS_BLUE);
		do_goal("blue");
	}

	void ext_red_scores_goal()
	{
		POINTS_RED += 1;
		update_scoreboards();
		CallExternal("players", "extsoc_show_scores", POINTS_RED, POINTS_BLUE);
		do_goal("red");
	}

	void do_goal()
	{
		SetEntityOrigin(GetOwner(), Vector3(5000, 5000, -5000));
		pause_game();
		CallExternal("all", "extsoc_score", StringToLower(param1));
		string OUT_MSG = "RED: ";
		OUT_MSG += int(POINTS_RED);
		OUT_MSG += " BLUE: ";
		OUT_MSG += int(POINTS_BLUE);
		if (param1 == "red")
		{
			SendInfoMsg("all", "RED SCORES " + OUT_MSG);
		}
		if (param1 == "blue")
		{
			SendInfoMsg("all", "BLUE SCORES " + OUT_MSG);
		}
		if (POINTS_RED == 5)
		{
			do_game_win(1);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (POINTS_BLUE == 5)
		{
			do_game_win(2);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(3.0, "resume_after_score1");
	}

	void resume_after_score1()
	{
		CallExternal("all", "extsoc_reset");
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			UseTrigger("spawn_red_team");
		}
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			UseTrigger("spawn_blue_team");
		}
		ScheduleDelayedEvent(5.0, "resume_after_score2");
		COUNT_DOWN = 5;
		COUNT_DOWN_EVENT = "unpause_game";
		do_countdown();
		AM_HOME = 0;
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		SetProp(GetOwner(), "velocity", Vector3(0, 0, 0));
		move_ball_home();
	}

	void do_countdown()
	{
		if (COUNT_DOWN > 1)
		{
			ScheduleDelayedEvent(1.0, "do_countdown");
		}
		if (!(AM_HOME))
		{
			move_ball_home();
			COUNT_DOWN_ABORT = 1;
			COUNT_DOWN = 5;
		}
		else
		{
			COUNT_DOWN_ABORT = 0;
		}
		if ((COUNT_DOWN_ABORT)) return;
		CallExternal("players", "ext_hud_icon", int(COUNT_DOWN), "cnt", 40, 0, 20, 30, 0.75);
		int OUT_MSG = int(COUNT_DOWN);
		OUT_MSG += "...";
		SendInfoMessageToAll("green " + OUT_MSG);
		COUNT_DOWN -= 1;
		if (COUNT_DOWN <= 0)
		{
			COUNT_DOWN_EVENT();
		}
	}

	void resume_after_score2()
	{
		if ((AM_HOME))
		{
			COUNT_DOWN_ABORT = 0;
		}
		else
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
			SetProp(GetOwner(), "velocity", Vector3(0, 0, 0));
			move_ball_home();
			COUNT_DOWN_ABORT = 1;
			COUNT_DOWN = 5;
			ScheduleDelayedEvent(0.1, "resume_after_score2");
		}
	}

	void move_ball_home()
	{
		string CUR_POS = GetEntityOrigin(GetOwner());
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
		string reg.npcmove.endpos = NPC_HOME_LOC;
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 0, 16));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), m_hAttackTarget);
		if ("game.ret.npcmove.dist" <= 0)
		{
			LogDebug("extsoc_reset blocked");
			SetEntityOrigin(GetOwner(), CUR_POS);
			if ((HOME_REPEAT))
			{
				ScheduleDelayedEvent(0.1, "move_ball_home");
			}
			if (GetGameTime() > NEXT_BALL_BLOCK_WARN)
			{
				SendInfoMsg("all", "BALL BLOCKED Please step away from the ball spawn...");
				NEXT_BALL_BLOCK_WARN = GetGameTime();
				NEXT_BALL_BLOCK_WARN += 10.0;
			}
		}
		else
		{
			HOME_REPEAT = 0;
			AM_HOME = 1;
		}
	}

	void pause_game()
	{
		GAME_PAUSED = 1;
		SetNoPush(true);
		CallExternal("all", "extsoc_pause_game");
	}

	void unpause_game()
	{
		GAME_PAUSED = 0;
		SetNoPush(false);
		CallExternal("all", "extsoc_unpause_game");
	}

	void soc_game_begin()
	{
		POINTS_RED = 0;
		POINTS_BLUE = 0;
		update_scoreboards();
		if ((GAME_WON))
		{
			CallExternal("all", "extsoc_reset");
			GAME_WON = 0;
		}
		GAME_STARTED = 1;
		ScheduleDelayedEvent(1.0, "soc_game_begin2");
	}

	void soc_game_begin2()
	{
		COUNT_DOWN = 5;
		COUNT_DOWN_EVENT = "unpause_game";
		do_countdown();
	}

	void do_game_win()
	{
		GAME_STARTED = 0;
		GAME_WON = 1;
		HOME_REPEAT = 1;
		move_ball_home();
	}

	void ext_say_scores()
	{
		CallExternal("players", "extsoc_show_scores", POINTS_RED, POINTS_BLUE);
	}

	void ext_send_menu()
	{
		OpenMenu(param1);
	}

	void update_scoreboards()
	{
		LogDebug("update_scoreboards blue_before: BLUE_SCORE_TOKENS");
		TWAL_TEAM_SUFFIX = "blue";
		DEST_POINTS = POINTS_BLUE;
		CUR_TOKEN_LIST = BLUE_SCORE_TOKENS;
		for (int i = 0; i < GetTokenCount(BLUE_SCORE_TOKENS, ";"); i++)
		{
			update_twals();
		}
		BLUE_SCORE_TOKENS = CUR_TOKEN_LIST;
		LogDebug("update_scoreboards blue_after: BLUE_SCORE_TOKENS");
		LogDebug("update_scoreboards red_before: RED_SCORE_TOKENS");
		TWAL_TEAM_SUFFIX = "red";
		DEST_POINTS = POINTS_RED;
		CUR_TOKEN_LIST = RED_SCORE_TOKENS;
		for (int i = 0; i < GetTokenCount(RED_SCORE_TOKENS, ";"); i++)
		{
			update_twals();
		}
		RED_SCORE_TOKENS = CUR_TOKEN_LIST;
		LogDebug("update_scoreboards red_after: RED_SCORE_TOKENS");
	}

	void update_twals()
	{
		int CUR_IDX = int(i);
		string TWAL_NAME = "twal_score_";
		TWAL_NAME += TWAL_TEAM_SUFFIX;
		TWAL_NAME += CUR_IDX;
		if (CUR_IDX == DEST_POINTS)
		{
			if (GetToken(CUR_TOKEN_LIST, CUR_IDX, ";") == 0)
			{
				SetToken(CUR_TOKEN_LIST, CUR_IDX, 1, ";");
				UseTrigger(TWAL_NAME);
				LogDebug("turning TWAL_NAME on [ CUR_TOKEN_LIST ]");
			}
		}
		else
		{
			if (GetToken(CUR_TOKEN_LIST, CUR_IDX, ";") == 1)
			{
				SetToken(CUR_TOKEN_LIST, CUR_IDX, 0, ";");
				UseTrigger(TWAL_NAME);
				LogDebug("turning TWAL_NAME off [ CUR_TOKEN_LIST ]");
			}
		}
	}

}

}
