#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Melanion : CGameScript
{
	int B_QUEST_DONE;
	int NO_JOB;
	int NO_RUMOR;
	string QUEST_COMPLETER;
	int TALKED_SALANDRIA;
	int TOLD_STORY;

	Melanion()
	{
		NO_JOB = 1;
		NO_RUMOR = 1;
		B_QUEST_DONE = 0;
		TALKED_SALANDRIA = 0;
	}

	void OnSpawn() override
	{
		SetName("melanion");
		SetHealth(30);
		SetGold(50);
		SetName("Ambassador Melanion Belore");
		SetWidth(32);
		SetHeight(72);
		SetRace("elf");
		SetRoam(false);
		SetModel("npc/elf_f.mdl");
		SetInvincible(true);
		// TODO: UNCONVERTED: setmodelbody	0
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "documents");
	}

	void askbook()
	{
		TALKED_SALANDRIA = 1;
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
		if (!(B_QUEST_DONE))
		{
			PlayAnim("once", "no");
			SayText(I + " will loose my job...and the whole transaction will fail...please leave me alone.");
		}
		if ((B_QUEST_DONE))
		{
			string WINNER_NAME = GetEntityName(QUEST_COMPLETER);
			SayText("Hello! " + I + " m so happy now that WINNER_NAME has returned my documents!");
		}
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
		if (!(TALKED_SALANDRIA)) return;
		if ((B_QUEST_DONE)) return;
		SayText("You know about the documents? You must have learned of it from Salandria.");
		ScheduleDelayedEvent(4, "say_bothered1a");
	}

	void say_bothered1a()
	{
		PlayAnim("once", "no");
		SayText(..I + " am a diplomat from Kray Eldorad , i had some documents..");
		ScheduleDelayedEvent(4, "story");
	}

	void story()
	{
		PlayAnim("once", "converse1");
		SayText("We were planning a diplomatic meeting. " + I + " came all the way from Kray Eldorad.");
		ScheduleDelayedEvent(5, "say_story2");
	}

	void say_story2()
	{
		PlayAnim("critial", "talkright");
		SayText(I + " was walking in the garden , when a man came by , he stole my documents!.");
		ScheduleDelayedEvent(5, "say_story3");
	}

	void say_story3()
	{
		PlayAnim("critial", "converse1");
		SayText("Thoose Documents had very important information , i chased him all the way to Thornlands , to a place called the Spider Cavern.");
		ScheduleDelayedEvent(7, "say_story4");
	}

	void say_story4()
	{
		PlayAnim("once", "converse1");
		SayText(I + "was then startled by many spiders , and had to flee , thoose documents " + MUST + " be back before the meeting , please help me.");
		ScheduleDelayedEvent(6, "say_story5");
	}

	void say_story5()
	{
		PlayAnim("once", "converse1");
		SayText("He is in there somewhere , please find him...it is so important for me...");
		ScheduleDelayedEvent(5, "say_story6");
	}

	void say_story6()
	{
		PlayAnim("once", "converse1");
		SayText(I + " tried talking to Edrin but he said his guards were far too busy and that he could not spare one.");
		ScheduleDelayedEvent(5, "say_story7");
	}

	void say_story7()
	{
		PlayAnim("once", "yes");
		SayText("If you can return my documents , i will make sure you will be rewarded.");
		TOLD_STORY = 1;
	}

	void give_book()
	{
		ReceiveOffer("accept");
		PlayAnim("once", "eye_wipe");
		SayText("The Documents! By Felewyn Bless you!");
		Say("[.10] [.20] [.20] [.10] [.10] [.10] [.25] [.20] [.10] [.30] [.20] [.40]");
		QUEST_COMPLETER = param1;
		B_QUEST_DONE = 1;
		ScheduleDelayedEvent(2, "recvdocuments_2");
	}

	void recvbook_2()
	{
		B_QUEST_DONE = 1;
		CallExternal(FindEntityByName("salandria"), "documentsfound");
		SayText("Here , some coins , and a gift from Salandria.");
		// TODO: offer QUEST_COMPLETER gold RandomInt(13, 16)
		// TODO: offer QUEST_COMPLETE item_bracelet
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_documents")))
		{
			string reg.mitem.title = "Return documents";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_documents";
			string reg.mitem.callback = "give_documents";
		}
		if ((TALKED_SALANDRIA))
		{
			if (!(B_QUEST_DONE))
			{
			}
			string reg.mitem.title = "Ask about Documents";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
	}

}

}
