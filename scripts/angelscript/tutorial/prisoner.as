#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Prisoner : CGameScript
{
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEP9;
	int CHAT_STEPS;
	int DID_ORC_REACTION;
	int GET_YE_TORCH;
	int GOT_YE_TORCH;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string PLAYER_ID;
	int PLAYING_DEAD;
	int SAID_GREETING;
	int SAID_WALL;
	int WALL_BROKEN;

	Prisoner()
	{
		const string NPC_MODEL = "npc/femhuman2.mdl";
		NO_JOB = 1;
		NO_RUMOR = 1;
		NO_HAIL = 1;
		const string SOUND_BECKON = "npc/vs_nwncomf4_say.wav";
		const string SOUND_HI = "npc/vs_nwncomf4_hi.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(5.0, 10.0));
		if (!(SAID_GREETING))
		{
			EmitSound(GetOwner(), 0, SOUND_BECKON, 10);
			bchat_mouth_move();
		}
		if (!(BUSY_CHATTING))
		{
		}
		string CHECK_ORCS = FindEntitiesInSphere("enemy", 256);
		if (CHECK_ORCS != "none")
		{
		}
		string NEAREST_NME = GetToken(CHECK_ORCS, 0, ";");
		if (GetEntityRace(NEAREST_NME) == "orc")
		{
		}
		SetMoveDest(NEAREST_NME);
	}

	void OnSpawn() override
	{
		SetName("Kyra");
		SetHealth(1);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("human");
		PLAYING_DEAD = 1;
		SetModel(NPC_MODEL);
		SetModelBody(0, 0);
		SetIdleAnim("idle1");
		SetWidth(30);
		SetHeight(96);
		SetSayTextRange(1024);
		CatchSpeech("say_hi", "hail");
		// TODO: UNCONVERTED: menu.autopen 1
		if (!(true)) return;
		ScheduleDelayedEvent(0.1, "face_player");
	}

	void face_player()
	{
		ScheduleDelayedEvent(1.0, "face_player");
		GetAllPlayers(TOKEN_LIST);
		PLAYER_ID = GetToken(TOKEN_LIST, 0, ";");
		if ((IsEntityAlive(PLAYER_ID)))
		{
			face_speaker(PLAYER_ID);
		}
		if (GetEntityRange(PLAYER_ID) < 96)
		{
			if (!(SAID_GREETING))
			{
			}
			player_greeting();
		}
	}

	void game_menu_getoptions()
	{
		if ((BUSY_CHATTING)) return;
		if (!(GET_YE_TORCH)) return;
		if ((GOT_YE_TORCH)) return;
		string reg.mitem.title = "Ask for torch";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_torch";
		face_speaker(GetEntityIndex(param1));
	}

	void say_torch()
	{
		string TORCH_RECIPIENT = param1;
		if (!(IsValidPlayer(param1)))
		{
			string PARAM1 = GetEntityIndex("ent_lastspoke");
		}
		PlayAnim("critical", "give_shot");
		// TODO: offer TORCH_RECIPIENT item_torch
		GOT_YE_TORCH = 1;
		CHAT_STEPS = 5;
		CHAT_STEP = 0;
		CHAT_STEP1 = "Here, you can have it. Maybe you can light it.";
		CHAT_STEP2 = "Great! That's better.";
		CHAT_STEP3 = "I was feeling around the walls here";
		CHAT_STEP4 = "One area was missing a stone, and made a hollow noise when I knocked on it.";
		CHAT_STEP5 = "Find it, and give it a whack with that torch!";
		chat_loop();
		NO_HAIL = 0;
	}

	void say_hi()
	{
		if (!(WALL_BROKEN))
		{
			SayText("You have the torch , Adventurer. Find the weak spot.");
		}
		else
		{
			SayText("Hurry! They will notice soon!");
		}
	}

	void player_greeting()
	{
		CHAT_STEPS = 9;
		CHAT_STEP = 0;
		CHAT_STEP1 = "Hello, Adventurer!";
		CHAT_STEP2 = "You've been out for quite a while.";
		CHAT_STEP3 = "I woke up a few minutes ago, with you on the other side of the cell.";
		CHAT_STEP4 = "We're in a holding cell, as you can see.";
		CHAT_STEP5 = "Last I saw were bandits before I was clocked on the head.";
		CHAT_STEP6 = "I overheard the guards speaking about an Orc invasion.";
		CHAT_STEP7 = "It's the perfect time to escape!";
		CHAT_STEP8 = "It's so dark in here!";
		CHAT_STEP9 = "I found this torch in a corner, but I can't seem to light it!";
		chat_loop();
		CatchSpeech("say_torch", "torch");
		GET_YE_TORCH = 1;
		SAID_GREETING = 1;
		EmitSound(GetOwner(), 0, SOUND_HI, 10);
	}

	void chat_loop()
	{
		convo_anim();
		if (CHAT_STEP == 9)
		{
			SendInfoMsg("all", "Communication Press the use key (Default e) on Kyra to bring up her chat menu.");
			ScheduleDelayedEvent(10.0, "summon_orcs");
		}
	}

	void summon_orcs()
	{
		UseTrigger("orc_attack");
		ScheduleDelayedEvent(1.0, "orc_reaction");
	}

	void wall_broken()
	{
		WALL_BROKEN = 1;
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(5.0, "wall_broken");
		}
		if ((BUSY_CHATTING)) return;
		if ((SAID_WALL)) return;
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		CHAT_STEP1 = "Great job! Now we can get out of here.";
		CHAT_STEP2 = "Though I think I'll hold back for now";
		CHAT_STEP3 = "I'll distract them so you can escape.";
		CHAT_STEP4 = "Go on! I'll be fine!";
		chat_loop();
		SAID_WALL = 1;
	}

	void orc_reaction()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(5.0, "orc_reaction");
		}
		if ((BUSY_CHATTING)) return;
		if ((DID_ORC_REACTION)) return;
		DID_ORC_REACTION = 1;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		SetMoveDest(Vector3(2300, 3360, MY_Z));
		PlayAnim("critical", "fear1");
		SayText("By the gods! The orcs are attacking!");
	}

}

}
