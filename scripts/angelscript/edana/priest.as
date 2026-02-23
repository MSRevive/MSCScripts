#pragma context server

#include "help/first_npc.as"

namespace MS
{

class Priest : CGameScript
{
	int CANCHAT;

	void OnSpawn() override
	{
		SetHealth(40);
		SetMaxHealth(40);
		SetGold(0);
		SetName("Priest of Urdual");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		createmystore();
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_sembelbin", "sembelbin");
		CatchSpeech("say_hall", "Hall");
		CatchSpeech("say_hall", "Balance");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_job", "work");
		CatchSpeech("say_job", "money");
		CatchSpeech("say_job", "gold");
		CatchSpeech("say_rumour", "rumours");
		CatchSpeech("say_rumour", "news");
		CatchSpeech("say_rumour", "happenings");
		CatchSpeech("say_rumour", "rumor");
	}

	void say_hi()
	{
		SetVolume(10);
		SayText("Do not bother me right now. Speak with Sembelbin.");
	}

	void say_sembelbin()
	{
		SayText("Sembelbin is in the Hall of Balance , in the deepest part of the temple.");
	}

	void say_hall()
	{
		SayText("The Hall of Balance is where light and dark meet. Now please , let me meditate.");
	}

	void say_job()
	{
		SayText("Work? the Temple of Balance has no need for you at the moment.");
		ScheduleDelayedEvent(2, "say_job2");
	}

	void say_job2()
	{
		SayText("If you need a job , try the village of Edana.");
	}

	void say_rumour()
	{
		SayText("The temple is very saddened right now... We recently lost a fine elf blademaster to the orcs.");
		ScheduleDelayedEvent(5, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("Lord Vecilus was his name , and he had his armor forged at Eswen Sylen. He insited on taking the orcs alone , to avenge his brother , Sir Geric.");
		ScheduleDelayedEvent(5, "say_rumour3");
	}

	void say_rumour3()
	{
		SayText("His pride was his death , and his armor lost.");
		ScheduleDelayedEvent(5, "say_rumour4");
	}

	void say_rumour4()
	{
		SayText("We would ask you to get back that armor , but don t you go alone like Lord Vecilus.");
		ScheduleDelayedEvent(5, "say_rumour5");
	}

	void say_rumour5()
	{
		SayText("I suppose you can keep the armor to yourself when you find it , seeing we don t have any temple fighters left.");
	}

}

}
