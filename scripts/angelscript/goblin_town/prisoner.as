#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Prisoner : CGameScript
{
	string NPC;
	string NPC_O;
	string PLAYER;
	string PLAYER_O;
	int QUEST_GOBLINPRISONER;
	string distance;

	Prisoner()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
	}

	void game_precache()
	{
		Precache("npc/human1.mdl");
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetMaxHealth(30);
		SetGold(50);
		SetName("Almund the Traveling Merchant");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 2);
		QUEST_GOBLINPRISONER = 0;
		const int HEARING_RANGE = 175;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_no", "no");
		CatchSpeech("say_yes", "yes");
	}

	void say_hi()
	{
		playerdist();
		if (distance <= HEARING_RANGE)
		{
			if (QUEST_GOBLINPRISONER == 0)
			{
				SayText("Are you here to rescue me?");
			}
			if (QUEST_GOBLINPRISONER == 1)
			{
				SayText("I can find my way home now");
			}
		}
	}

	void say_no()
	{
		playerdist();
		if (distance <= HEARING_RANGE)
		{
			if (QUEST_GOBLINPRISONER == 0)
			{
				SayText("I guess I am doomed to rot in this cage...");
			}
			if (QUEST_GOBLINPRISONER == 1)
			{
				SayText("I can find my way home now");
			}
		}
	}

	void say_yes()
	{
		playerdist();
		if (distance <= HEARING_RANGE)
		{
			if (QUEST_GOBLINPRISONER == 1)
			{
				SayText("I can find my way home now.");
			}
			if (QUEST_GOBLINPRISONER == 0)
			{
				QUEST_GOBLINPRISONER = 1;
				SayText("Thank you! My family must be worried about me!");
				ScheduleDelayedEvent(3, "ending");
			}
		}
	}

	void ending()
	{
		SayText("I was captured by these goblins while traveling between towns.");
		ScheduleDelayedEvent(3, "ending2");
	}

	void ending2()
	{
		SayText("They stole all of my goods, but that doesn't matter.");
		ScheduleDelayedEvent(3, "reward");
	}

	void reward()
	{
		SayText("Please take this letter to my wife, Kendra, in Gate City.");
		// TODO: offer ent_lastspoke item_letter_almund
	}

	void playerdist()
	{
		PLAYER = GetEntityIndex("ent_lastspoke");
		PLAYER_O = GetEntityOrigin(PLAYER);
		NPC = GetEntityIndex(GetOwner());
		NPC_O = GetEntityOrigin(NPC);
		distance = Distance(NPC_O, PLAYER_O);
	}

}

}
