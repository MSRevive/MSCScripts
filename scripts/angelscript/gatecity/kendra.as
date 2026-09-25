#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Kendra : CGameScript
{
	int QUEST_GOBLINPRISONER;

	void OnSpawn() override
	{
		SetHealth(30);
		SetMaxHealth(30);
		SetGold(50);
		SetName("|Kendra");
		SetFOV(120);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human2.mdl");
		SetInvincible(true);
		SetModelBody(0, 2);
		SetModelBody(1, 0);
		QUEST_GOBLINPRISONER = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_upset", "wrong");
		CatchSpeech("say_rumor", "rumour");
		CatchSpeech("say_steambow", "sucks");
	}

	void say_job()
	{
		say_upset();
	}

	void say_hi()
	{
		if (QUEST_GOBLINPRISONER == 0)
		{
			SayText(I + " m too [upset] to talk right now.");
		}
		if (QUEST_GOBLINPRISONER == 1)
		{
			SayText("Thank you Adventurer , " + I + " couldn t be happier!");
		}
	}

	void say_rumor()
	{
		if (QUEST_GOBLINPRISONER == 0)
		{
			SayText("...");
		}
		if (QUEST_GOBLINPRISONER == 1)
		{
			SayText(I + " haven t been out much recently.");
		}
	}

	void say_upset()
	{
		if (QUEST_GOBLINPRISONER == 0)
		{
			SayText("My husband has been missing for some time now.");
			ScheduleDelayedEvent(3, "say_upset2");
		}
	}

	void say_upset2()
	{
		SayText("He s a travelling merchant. I m affraid something has happened to him.");
		ScheduleDelayedEvent(3, "say_upset3");
	}

	void say_upset3()
	{
		SayText(I + " wish there was some way to know that he is safe.");
	}

	void game_menu_getoptions()
	{
		if (QUEST_GOBLINPRISONER == 0)
		{
			if ((ItemExists(param1, "item_letter_almund")))
			{
				QUESTER_LETTER = param1;
				string reg.mitem.title = "Give Almund's Letter";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "item_letter_almund";
				string reg.mitem.callback = "say_ending";
			}
		}
	}

	void say_ending()
	{
		QUEST_GOBLINPRISONER = 1;
		SayText("This letter is from my husband...");
		ScheduleDelayedEvent(3, "say_ending2");
	}

	void say_ending2()
	{
		SayText("He s going to be coming home!");
		ScheduleDelayedEvent(3, "say_reward");
	}

	void say_reward()
	{
		SayText("Thank you Adventurer! Please take this gold!");
		// TODO: offer QUESTER_LETTER gold RandomInt(20, 30)
	}

	void say_steambow()
	{
		SayText("You really think that yer going to get the Steam Crossbow that way?");
	}

}

}
