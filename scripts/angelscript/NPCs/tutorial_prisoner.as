#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class TutorialPrisoner : CGameScript
{
	int GET_YE_TORCH;
	int GOT_YE_TORCH;
	int NO_JOB;
	int NO_RUMOR;
	int SAID_GREETING;
	int WALL_BROKEN;

	TutorialPrisoner()
	{
		const string NPC_MODEL = "npc/femhuman2.mdl";
		const string ANIM_IDLE = "idle1";
		const string ANIM_WALK = "idle1";
		Precache(NPC_MODEL);
		NO_JOB = 1;
		NO_RUMOR = 1;
		GOT_YE_TORCH = 0;
	}

	void OnSpawn() override
	{
		SetName("Kyra");
		SetHealth(1);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("beloved");
		SetModel(NPC_MODEL);
		SetModelBody(0, 0);
		SetWidth(30);
		SetHeight(96);
		SetSayTextRange(1024);
		SetHearingSensitivity(10);
		CatchSpeech("say_hi", "hail");
		// TODO: UNCONVERTED: menu.autopen 1
		ScheduleDelayedEvent(0.1, "face_player");
	}

	void face_player()
	{
		GetAllPlayers(TOKEN_LIST);
		string PLAYER_ID = GetToken(TOKEN_LIST, 0, ";");
		if (!(IsEntityAlive(PLAYER_ID))) return;
		face_speaker(PLAYER_ID);
		ScheduleDelayedEvent(0.5, "face_player");
	}

	void game_menu_getoptions()
	{
		if (!(GOT_YE_TORCH))
		{
			if ((GET_YE_TORCH))
			{
			}
			string reg.mitem.title = "Ask for torch";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_torch";
		}
		if ((IsValidPlayer(param1)))
		{
			face_speaker(GetEntityIndex(param1));
		}
		if ((IsValidPlayer("ent_lastspoke")))
		{
			face_speaker(GetEntityIndex("ent_lastspoke"));
		}
	}

	void say_torch()
	{
		convo_anim();
		string TORCH_RECIPIENT = param1;
		SayText("Here , you can have it.");
		SayText("Maybe you ll have better luck lighting it.");
		PlayAnim("once", "give_shot");
		// TODO: offer TORCH_RECIPIENT item_torch
		GOT_YE_TORCH = 1;
		ScheduleDelayedEvent(1, "say_torch2");
	}

	void say_torch2()
	{
		convo_anim();
		SayText("Great! That s better.");
		ScheduleDelayedEvent(4, "say_torch3");
	}

	void say_torch3()
	{
		convo_anim();
		SayText("I was feeling around the walls here");
		ScheduleDelayedEvent(2, "say_torch4");
	}

	void say_torch4()
	{
		convo_anim();
		SayText("One area felt cracked , and made a hollow noise when I knocked on it.");
		ScheduleDelayedEvent(3, "say_torch5");
	}

	void say_torch5()
	{
		convo_anim();
		SayText("Find it , and give it a whack with that torch!");
	}

	void say_hi()
	{
		if (!(SAID_GREETING))
		{
			player_greeting();
		}
		else
		{
			if (!(WALL_BROKEN))
			{
				face_speaker();
				SayText("You have the torch , Adventurer. Find the weak spot.");
			}
			else
			{
				face_speaker();
				SayText("Hurry! The guards will be along soon!");
				SendInfoMessageToAll("green (She shoos you towards the hole in the wall)");
			}
		}
	}

	void player_spawned()
	{
		ScheduleDelayedEvent(5, "player_greeting");
	}

	void player_greeting()
	{
		convo_anim();
		if ((SAID_GREETING)) return;
		SayText("Hello , Adventurer!");
		SAID_GREETING = 1;
		GET_YE_TORCH = 1;
		ScheduleDelayedEvent(2, "player_greeting2");
	}

	void player_greeting2()
	{
		convo_anim();
		SayText("I woke up a few minutes ago , with you on the other side of the cell.");
		ScheduleDelayedEvent(2, "player_greeting3");
	}

	void player_greeting3()
	{
		convo_anim();
		SayText("You ve been out for quite a while.");
		ScheduleDelayedEvent(5, "player_greeting4");
	}

	void player_greeting4()
	{
		convo_anim();
		SayText("We re in a holding cell, as you can see.");
		ScheduleDelayedEvent(5, "player_greeting5");
	}

	void player_greeting5()
	{
		convo_anim();
		SayText("Last I saw were bandits before I was clocked on the head.");
		ScheduleDelayedEvent(10, "player_greeting6");
	}

	void player_greeting6()
	{
		SayText("It s so dark in here!");
		PlayAnim("once", "pondering2");
		ScheduleDelayedEvent(4, "player_greeting7");
	}

	void player_greeting7()
	{
		convo_anim();
		SayText("I found this [torch] in a corner , but I can t seem to light it!");
		SendInfoMessageToAll("green Press the use key (Default 'e') on Kyra to bring up her chat menu");
	}

	void wall_broken()
	{
		convo_anim();
		SayText("Great job! Now we can get out of here.");
		ScheduleDelayedEvent(2, "wall_broken2");
		WALL_BROKEN = 1;
	}

	void wall_broken2()
	{
		convo_anim();
		SayText("Though I think I ll hold back for now");
		ScheduleDelayedEvent(2, "wall_broken3");
	}

	void wall_broken3()
	{
		convo_anim();
		SayText("I ll distract the guards should they return.");
		ScheduleDelayedEvent(4, "wall_broken4");
	}

	void wall_broken4()
	{
		convo_anim();
		SayText("Go on! I ll be fine!");
	}

}

}
