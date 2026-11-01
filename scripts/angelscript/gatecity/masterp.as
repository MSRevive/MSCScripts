#pragma context server

#include "monsters/base_chat.as"
#include "help/first_npc.as"

namespace MS
{

class Masterp : CGameScript
{
	int CANCHAT;
	int TEMPLE;

	void OnSpawn() override
	{
		SetHealth(1);
		SetGold(0);
		SetName("Theobold");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		TEMPLE = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_temple", "temple");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
	}

	void say_hi()
	{
		SayText("Hail , Adventurer. What can the temple do for you today?");
	}

	void say_job()
	{
		SayText(A + "job? " + I + " am afraid the temple has no specific jobs for you.");
		ScheduleDelayedEvent(3, "say_job2");
	}

	void say_rumor()
	{
		SayText("However , there are rumors of a [broken temple] to the north");
		TEMPLE = 1;
	}

	void say_temple()
	{
		if ((TEMPLE))
		{
			SayText("Yes , if good or evil becomes too strong in the area the temple is in , it will eventually crack in two");
			ScheduleDelayedEvent(3, "say_temple2");
		}
	}

	void say_temple2()
	{
		SayText("There are many of these cracked temples scattered accross the land , and are usually filled with");
		SayText("monsters seeking to create yet more unbalance.");
	}

}

}
