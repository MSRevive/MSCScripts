#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class Urdauf : CGameScript
{
	int B_QUEST_DONE;
	string QUEST_COMPLETER;
	int TALKED_SUMDALE;
	int TOLD_STORY;

	Urdauf()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const int CHAT_AUTO_HAIL = 1;
		B_QUEST_DONE = 0;
		TALKED_SUMDALE = 0;
		const int CHAT_USE_CONV_ANIMS = 0;
	}

	void OnSpawn() override
	{
		SetName("urduaf");
		SetHealth(30);
		SetGold(50);
		SetName("Urduaf");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 2);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "book");
	}

	void askbook()
	{
		TALKED_SUMDALE = 1;
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
			chat_now("Look, I don't feel like talking right now so please just leave.");
			PlayAnim("critical", "no");
		}
		if ((B_QUEST_DONE))
		{
			string WINNER_NAME = GetEntityName(QUEST_COMPLETER);
			string L_MSG = "I'm so happy now that ";
			L_MSG += WINNER_NAME;
			L_MSG += " has returned my journal!";
			PlayAnim("once", "wave");
			chat_now(L_MSG);
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
		if (!(TALKED_SUMDALE)) return;
		if ((B_QUEST_DONE)) return;
		chat_now("You know about the book? You must have learned of it from Sumdale.");
		ScheduleDelayedEvent(4, "say_bothered1a");
	}

	void say_bothered1a()
	{
		PlayAnim("once", "no");
		chat_now("..I had a book once, it's very important to me.. ");
		ScheduleDelayedEvent(3, "story");
	}

	void story()
	{
		PlayAnim("once", "converse1");
		chat_now("I was foolish enough to take it with me to explore the caves. I fancied myself an adventurer.");
		ScheduleDelayedEvent(5, "say_story2");
	}

	void say_story2()
	{
		PlayAnim("critial", "talkright");
		chat_now("I was going to explore a little and write down what I found.");
		ScheduleDelayedEvent(5, "say_story3");
	}

	void say_story3()
	{
		PlayAnim("critial", "converse1");
		chat_now("I was in a room with an incredible drop off. There was a chest nearby.");
		ScheduleDelayedEvent(5, "say_story4");
	}

	void say_story4()
	{
		PlayAnim("once", "converse1");
		chat_now("I was startled by an huge spider. If there are any spiders bigger than that I'd hate to meet it. ");
		ScheduleDelayedEvent(5, "say_story5");
	}

	void say_story5()
	{
		PlayAnim("once", "converse1");
		chat_now("I dropped my precious book and ran to the surface. There was a cave in behind me as I crawled frantically away.");
		ScheduleDelayedEvent(5, "say_story6");
	}

	void say_story6()
	{
		PlayAnim("once", "converse1");
		chat_now("I couldn't get back to my book and now all I can ask is for the help of a real adventurer.");
		ScheduleDelayedEvent(5, "say_story7");
	}

	void say_story7()
	{
		PlayAnim("once", "yes");
		chat_now("If you can return my book to me i'm sure there'd be some kind of reward for your troubles.");
		TOLD_STORY = 1;
	}

	void give_book()
	{
		ReceiveOffer("accept");
		PlayAnim("once", "eye_wipe");
		chat_now("My god, that's my book! I cannot thank you enough brave adventurer!");
		Say("[.10] [.20] [.20] [.10] [.10] [.10] [.25] [.20] [.10] [.30] [.20] [.40]");
		QUEST_COMPLETER = param1;
		B_QUEST_DONE = 1;
		ScheduleDelayedEvent(2, "recvbook_2");
	}

	void recvbook_2()
	{
		B_QUEST_DONE = 1;
		CallExternal(FindEntityByName("sumdale"), "bookfound");
		chat_now("Here, take this gold as a reward, adventurer.");
		// TODO: offer QUEST_COMPLETER gold RandomInt(6, 9)
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_book_old")))
		{
			string reg.mitem.title = "Return book";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_book_old";
			string reg.mitem.callback = "give_book";
		}
		if ((TALKED_SUMDALE))
		{
			if (!(B_QUEST_DONE))
			{
			}
			string reg.mitem.title = "Ask about Book";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
	}

}

}
