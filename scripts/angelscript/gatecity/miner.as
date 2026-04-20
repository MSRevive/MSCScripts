#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Miner : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(30);
		SetMaxHealth(30);
		SetGold(50);
		SetName("|Roderick the Miner");
		SetFOV(120);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetInvincible(true);
		SetModelBody(1, 8);
		SetModelBody(2, 0);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
		CatchSpeech("say_undermountains", "undermountain");
	}

	void say_hi()
	{
		SayText("Hail , Adventurer. " + I + " hope the [underkeep] would open soon.");
	}

	void say_job()
	{
		SayText("You too? " + I + " need to find work as well.");
	}

	void say_rumor()
	{
		SayText(A + " miner friend of mine says undead creatures lie below the city.");
	}

	void say_undermountains()
	{
		SayText("The Underkeep goes through the deepest parts of the mountains.");
		ScheduleDelayedEvent(3, "say_undermountains2");
	}

	void say_undermountains2()
	{
		SayText("Rare gems and metals can be found down there.");
		ScheduleDelayedEvent(3, "say_undermountains3");
	}

	void say_undermountains3()
	{
		SayText("It s so dangerous there now, so the mayor has closed off all access.");
	}

}

}
