#pragma context server

#include "NPCs/human_guard.as"
#include "monsters/base_chat.as"

namespace MS
{

class GuardBarracks : CGameScript
{
	int BG_ROAM;
	float BG_SPEED;
	int BUSY_TALKING_JOB;
	string JOB_TARGET;
	string MENU_MODE;
	int NO_CHAT;
	string QUEST_WIN;
	int TALK;
	int TOOK_JOB;

	GuardBarracks()
	{
		BG_ROAM = 1;
		BG_SPEED = 1.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(25, 45));
		if (!(IS_HUNTING))
		{
		}
		if ((CanSee("ally", 128)))
		{
		}
		npcatk_setmovedest(m_hLastSeen, 128);
		EmitSound(GetOwner(), 0, "npc/hello1.wav", 5);
		Say("[.83] [.33] [.91] [.91] [.38] [.36]");
	}

	void OnSpawn() override
	{
		SetName("Cathain , Militia Quartermaster");
		SetRoam(true);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_help", "help");
		CatchSpeech("say_rumour", "news");
		CatchSpeech("say_island", "island");
		SetMenuAutoOpen(1);
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_hi()
	{
		TALK = RandomInt(1, 5);
		respond1();
		respond2();
	}

	void respond1()
	{
		if (!(TALK == 1)) return;
		SayText(I + " should ve joined the army...");
	}

	void respond2()
	{
		if (!(TALK != 1)) return;
		SayText("Be on your way sir.");
	}

	void say_help()
	{
		SayText("Ergh , help yourself.");
	}

	void say_rumour()
	{
		SayText("Hmmm , why would you ask such things? Best be on your way traveller.");
	}

	void say_island()
	{
		SayText("Huh , what? How did you ... the people in this city talk too much.");
	}

	void game_menu_getoptions()
	{
		if (!(TRADE_RING))
		{
			if (MENU_MODE == "sewers")
			{
			}
			string reg.mitem.title = "Take the Sewer Job";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "go_to_sewers";
		}
		if (!(TRADE_RING)) return;
		string L_RQUEST_STEP = GetPlayerQuestData(param1, "r");
		if (!(L_RQUEST_STEP == 12)) return;
		string reg.mitem.title = "Offer 500 gold";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:500;item_ring";
		string reg.mitem.callback = "got_ring";
	}

	void got_ring()
	{
		// TODO: offer PARAM1 item_ring_percept
		QUEST_WIN = param1;
		SayText("There ya go, snapped back together, good as new.");
		ScheduleDelayedEvent(2.0, "got_ring2");
		SetPlayerQuestData(QUEST_WIN, "r");
	}

	void got_ring2()
	{
		SetMoveAnim("walk");
		SetRoam(true);
		PlayAnim("once", "walk");
		SetMoveDest(QUEST_WIN);
		SayText("Make good use of it!");
	}

	void say_job()
	{
		if ((BUSY_TALKING_JOB)) return;
		BUSY_TALKING_JOB = 1;
		SetRoam(false);
		MENU_MODE = "sewers";
		if ((IsEntityAlive(param1)))
		{
			SetMoveDest(param1);
			JOB_TARGET = param1;
		}
		else
		{
			SetMoveDest("ent_lastspoke");
			JOB_TARGET = GetEntityIndex("ent_lastspoke");
		}
		SayText("Eh? You want a job aye? Well have I got one for you...");
		ScheduleDelayedEvent(3.0, "say_job2");
	}

	void say_job2()
	{
		if ((TOOK_JOB)) return;
		SayText("We sent a construction team, down into the sewers, a little while ago, and lost em.");
		ScheduleDelayedEvent(5.0, "say_job3");
	}

	void say_job3()
	{
		if ((TOOK_JOB)) return;
		SayText("So we sent a chunk of the militia after them... And we lost THEM.");
		ScheduleDelayedEvent(5.0, "say_job4");
	}

	void say_job4()
	{
		if ((TOOK_JOB)) return;
		SayText("I can't spare anymore men on that ancient maze, but if we don't fix things down there soon...");
		ScheduleDelayedEvent(5.0, "say_job5");
	}

	void say_job5()
	{
		if ((TOOK_JOB)) return;
		SayText("...It's going to get... Very odorous, up here in Deralia...");
		ScheduleDelayedEvent(5.0, "say_job6");
	}

	void say_job6()
	{
		if ((TOOK_JOB)) return;
		SayText("I can't pay you, mind ye. However, all sorts of recluse wizards and such have setup shop down there in the past...");
		ScheduleDelayedEvent(5.0, "say_job7");
	}

	void say_job7()
	{
		if ((TOOK_JOB)) return;
		SayText("So there's bound to be a fair amount of loot - if you can get out alive.");
		ScheduleDelayedEvent(5.0, "say_job8");
	}

	void say_job8()
	{
		if ((TOOK_JOB)) return;
		SayText("If you're interested, give me a heads up, and I'll show you the way. I'm too busy to go down there myself, mind you.");
		BUSY_TALKING_JOB = 0;
		ScheduleDelayedEvent(5.0, "say_job9");
	}

	void say_job9()
	{
		NO_CHAT = 1;
		OpenMenu(JOB_TARGET);
	}

	void go_to_sewers()
	{
		TOOK_JOB = 1;
		SayText("Alright, I'll show you the way in just a few minutes... Now where'd I put that damned key...");
		CallExternal(GAME_MASTER, "gm_map_vote", JOB_TARGET, "deraliasewers", "Do you wish to enter Deralia Sewers?", 1, 1);
		CallExternal("players", "ext_set_map", "deraliasewers", "from_deralia", "from_deralia");
		SendColoredMessage(JOB_TARGET, "Starting vote for Deraliasewers...");
		NO_CHAT = 0;
	}

	void game_menu_cancel()
	{
		SetRoam(true);
		NO_CHAT = 0;
		TOOK_JOB = 0;
	}

}

}
