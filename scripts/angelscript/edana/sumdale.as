#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class Sumdale : CGameScript
{
	int QUEST_DONE;
	int SAID_URD;
	string URD_ID;

	Sumdale()
	{
		QUEST_DONE = 0;
		const int CHAT_AUTO_HAIL = 1;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetGold(50);
		SetName("Patron");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 2);
		SetName("sumdale");
		if ((G_CHIRSTMAS_MODE))
		{
			SetModelBody(2, 1);
		}
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_what", "book");
		CatchSpeech("say_huh", "urdaf");
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
		chat_now("Thanks again for what you've done for my friend.", 3.0);
	}

	void say_hi_normal()
	{
		chat_now("Hail adventurer! My name is Sumdale.", 2.9);
		SetName("Sumdale");
		ScheduleDelayedEvent(3, "say_hi2");
	}

	void say_hi2()
	{
		URD_ID = FindEntityByName("urduaf");
		CallExternal(URD_ID, "askbook");
		chat_now("You look like a kind fellow, maybe you can help me with something.", 3.9);
		ScheduleDelayedEvent(4, "say_hi3");
	}

	void say_hi3()
	{
		chat_now("My friend Urdauf up there has become distraught over the loss of his book...", 6.9);
		ScheduleDelayedEvent(7, "say_hi4");
	}

	void say_hi4()
	{
		chat_now("His father gave it to him as a family heirloom. It means so much to him.", 4.0);
		chat_now("He's been very quiet, barely eats, and talks of nothing but the book.", 3.0);
		SAID_URD = 1;
	}

	void say_what()
	{
		if ((QUEST_DONE)) return;
		chat_now("I recently found him passed out in the field outside of town and brought him back here.", 2.9);
		ScheduleDelayedEvent(3, "say_what2");
	}

	void say_what2()
	{
		chat_now("He's finally walking again but he won't talk to me much about what happened.", 2.9);
		ScheduleDelayedEvent(3, "say_what3");
	}

	void say_what3()
	{
		chat_now("You'd best ask him, he's been distraught over the loss of some book.", 3.0);
	}

	void say_huh()
	{
		chat_now("Who are you talking about? You mean Urdauf? He's up there.", 2.0);
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
		chat_now("I saw Tristan read an odd note here at the tavern the other night. It seemed pretty torn up to me, and he looked confused.", 3.5);
	}

	void game_menu_getoptions()
	{
		if (!(SAID_URD))
		{
			if (!(QUEST_DONE))
			{
				string reg.mitem.title = "Ask about Jobs";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_job";
			}
			else
			{
				string reg.mitem.title = "Ask About Urdauf";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_thanx";
			}
		}
		if (!(SAID_URD)) return;
		if (!(QUEST_DONE))
		{
			string reg.mitem.title = "Ask About Urdauf";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_what";
		}
		else
		{
			string reg.mitem.title = "Ask About Urdauf";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_thanx";
		}
	}

}

}
