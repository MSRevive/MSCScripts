#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_chat.as"
#include "help/first_npc.as"

namespace MS
{

class Priest : CGameScript
{
	int CANCHAT;

	Priest()
	{
		const int NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetGold(0);
		SetName("Priest of Urdual");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_theobold", "theobold");
		CatchSpeech("say_hall", "Hall");
		CatchSpeech("say_job", "job");
	}

	void say_hi()
	{
		SetVolume(10);
		SayText("Do not bother me right now. Speak with Theobold.");
	}

	void say_theobold()
	{
		SayText("Theobold is in the Hall of Balance , in the deepest part of the temple.");
	}

	void say_hall()
	{
		SayText("The Hall of Balance is where light and dark meet. Now please , let me meditate.");
	}

	void say_job()
	{
		SayText("Work? the Temple of Balance has no need for you at the moment.");
		ScheduleDelayedEvent(3, "say_job2");
	}

	void say_job2()
	{
		SayText("If you need a job , try looking in the city.");
	}

}

}
