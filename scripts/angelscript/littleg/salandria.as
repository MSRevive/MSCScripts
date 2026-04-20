#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Salandria : CGameScript
{
	string MEL_ID;
	int NO_JOB;
	int QUEST_DONE;
	int SAID_MEL;

	Salandria()
	{
		NO_JOB = 1;
		QUEST_DONE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetGold(50);
		SetName("Elven Child");
		SetWidth(32);
		SetHeight(72);
		SetRace("elf");
		SetRoam(false);
		SetModel("npc/elf_fc.mdl");
		SetInvincible(true);
		// TODO: UNCONVERTED: setmodelbody	0
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_what", "documents");
		CatchSpeech("say_huh", "melanoin");
		CatchSpeech("say_rumour", "rumour");
	}

	void say_job()
	{
		if (param1 == "PARAM1")
		{
			if (GetEntityRange("ent_lastspoke") > 128)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		say_hi2();
	}

	void say_rumor()
	{
		if (param1 == "PARAM1")
		{
			if (GetEntityRange("ent_lastspoke") > 128)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		say_rumour();
	}

	void say_hi()
	{
		if (param1 == "PARAM1")
		{
			if (GetEntityRange("ent_lastspoke") > 128)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(QUEST_DONE))
		{
			say_hi_normal();
		}
		if ((QUEST_DONE))
		{
			say_thanx();
		}
	}

	void say_thanx()
	{
		SayText("Thanks again for what you ve done for Melanion, You are my new friend now.");
	}

	void say_hi_normal()
	{
		SayText("Hello! My name is Salandria.");
		SetName("Salandria");
		ScheduleDelayedEvent(3, "say_hi2");
	}

	void say_hi2()
	{
		MEL_ID = FindEntityByName("melanion");
		CallExternal(MEL_ID, "askdocuments");
		SayText("You look like a friendly person , maybe you can help me with something.");
		ScheduleDelayedEvent(4, "say_hi3");
	}

	void say_hi3()
	{
		SayText("My mother s good friend Melanion took me here, but she is very distressed.");
		ScheduleDelayedEvent(7, "say_hi4");
	}

	void say_hi4()
	{
		SayText("She lost some documents from our home. It means so much to her.");
		SayText("she s been very quiet, barely eats, and talks of nothing but the documents.");
		SAID_MEL = 1;
	}

	void say_what()
	{
		if ((QUEST_DONE)) return;
		SayText(I + " found her with a tragic look , and no documents.");
		ScheduleDelayedEvent(3, "say_what2");
	}

	void say_what2()
	{
		SayText("She is getting better but she is still so sad.");
		ScheduleDelayedEvent(3, "say_what3");
	}

	void say_what3()
	{
		SayText("You d best ask her, she s been distraught over the loss of her documents.");
	}

	void say_huh()
	{
		SayText("Who are you talking about? You mean Melanion? She s up there.");
	}

	void bookfound()
	{
		QUEST_DONE = 1;
	}

	void say_rumour()
	{
		if (param1 == "PARAM1")
		{
			if (GetEntityRange("ent_lastspoke") > 128)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayAnim("once", "pondering");
		SayText(I + " heard Melanion s meeting has something to do with Eswen Sylen and about allowing humans inside.");
	}

	void game_menu_getoptions()
	{
		if (!(SAID_URD))
		{
			string reg.mitem.title = "Ask about Jobs";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
		if (!(SAID_URD)) return;
		if (!(QUEST_DONE))
		{
			string reg.mitem.title = "Ask About Melanion";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_what";
		}
		if ((QUEST_DONE))
		{
			string reg.mitem.title = "Ask About Melanion";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_thanx";
		}
	}

}

}
