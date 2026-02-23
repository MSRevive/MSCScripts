#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Headguard : CGameScript
{
	int BUSY_CHATTING;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	string GUARD_LOOP;
	int GuardQuestFinished;
	string LAST_SPOKE_TO;
	string PLAYER_NEAR;
	string PLAYER_SPLOTTED;
	int StartGuardQuest;

	Headguard()
	{
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.0);
		if ("GuardQuest" == 0)
		{
			GetAllPlayers(PLAYER_SUSPECTS);
			PLAYER_NEAR = 0;
			GUARD_LOOP = 0;
			for (int i = 0; i < GetTokenCount(PLAYER_SUSPECTS, ";"); i++)
			{
				check_near();
			}
			if ((PLAYER_NEAR))
			{
			}
			if (LAST_SPOKE_TO != PLAYER_SPLOTTED)
			{
			}
			SetMoveDest(PLAYER_SPLOTTED);
			SetSayTextRange(512);
			SayText("You there! STOP!");
			LAST_SPOKE_TO = PLAYER_SPLOTTED;
		}
	}

	void OnSpawn() override
	{
		SetHealth(300);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Head Guard");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetIdleAnim("c1a0_catwalkidle");
		SetMoveAnim("walk");
		CatchSpeech("say_sus", "suspicious");
		CatchSpeech("say_help", "help");
		StartGuardQuest = 0;
		GuardQuestFinished = 0;
	}

	void game_menu_getoptions()
	{
		if (StartGuardQuest == 1)
		{
			if ((ItemExists(param1, "drink_mead")))
			{
				string reg.mitem.title = "Show Note";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "drink_mead";
				string reg.mitem.callback = "hand_note";
			}
		}
	}

	void check_near()
	{
		string CUR_PLAYER = GetToken(PLAYER_SUSPECTS, GUARD_LOOP, ";");
		if (GetEntityRange(CUR_PLAYER) < 256)
		{
			PLAYER_NEAR = 1;
			PLAYER_SPLOTTED = CUR_PLAYER;
		}
		GUARD_LOOP += 1;
	}

	void say_hi()
	{
		if (GuardQuestFinished == 0)
		{
			SayText("You there! Have you seen anyone [suspicious] around the city?");
		}
		if (GuardQuestFinished == 1)
		{
			SayText("Thanks for your help , adventurer.");
		}
	}

	void say_sus()
	{
		CHAT_STEPS = 3;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "I'm investigating a report of a mysterious individual sneaking around the city in the dead of night.";
		CHAT_STEP2 = "I've questioned many walking the streets at that time and have no leads.";
		CHAT_STEP3 = "You seem like a resourceful adventurer.  How would you like to [help] me?";
		chat_loop();
	}

	void say_help()
	{
		CHAT_STEPS = 3;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Since the investigation seems to be at a standstill, we should start from the beginning.";
		CHAT_STEP2 = "Drayke, who lives opposite the fountain, made the report.";
		CHAT_STEP3 = "See him and inquire about any further details which could help us.";
		chat_loop();
		UseTrigger("questdoordrayke");
		StartGuardQuest = 1;
	}

	void hand_note()
	{
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "What's this?";
		CHAT_STEP2 = "This letter is signed by a 'Rudolf'.";
		CHAT_STEP3 = "Find this person and inquire about Drayke's whereabouts.";
		CHAT_STEP4 = "Ask around if you can't find him yourself.";
		chat_loop();
	}

}

}
