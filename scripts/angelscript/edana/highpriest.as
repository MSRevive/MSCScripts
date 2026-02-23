#pragma context server

namespace MS
{

class Highpriest : CGameScript
{
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.3);
		CanSee(CURRENT_ALLY);
		SetMoveDest(m_hLastSeen);
	}

	void OnSpawn() override
	{
		SetHealth(60);
		SetMaxHealth(60);
		SetGold(0);
		SetName("High Priest");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		ATTACK_RANGE = 100;
		ATTACK1_DAMAGE = -1000;
		ATTACK_PERCENTAGE = 1.0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_job", "work");
		CatchSpeech("say_rumour", "rumours");
		CatchSpeech("say_rumour", "news");
		CatchSpeech("say_rumour", "happenings");
		CatchSpeech("say_rumour", "rumor");
		CatchSpeech("say_heal", "heal");
		CatchSpeech("say_heal", "regenerate");
		CatchSpeech("say_heal", "reconstitute");
		CatchSpeech("say_heal", "wounds");
		CatchSpeech("say_heal", "wounded");
		CatchSpeech("say_heal", "healing");
	}

	void say_hi()
	{
		SetVolume(10);
		SayText("...");
	}

	void say_job()
	{
		SetVolume(10);
		SayText("It is the duty of each one of us to server Urdual with all of our heart.");
	}

	void say_rumour()
	{
		SayText("Long ago , a fallen elf left the Temple of Balance to aid Torkalath and his orcs.");
		ScheduleDelayedEvent(5, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("That fool didn t know much of the orcs, and we begged him not to go.");
		ScheduleDelayedEvent(5, "say_rumour3");
	}

	void say_rumour3()
	{
		SayText("They tricked him into believeing they would let him help , but instead they killed him and ate his body.");
		ScheduleDelayedEvent(5, "say_rumour4");
	}

	void say_rumour4()
	{
		SayText("The Circle of Seven trapped his soul into his armor so they could use his rage on their berserkers.");
		ScheduleDelayedEvent(5, "say_rumour5");
	}

	void say_rumour5()
	{
		SayText("I believe the elf s name was Geric.");
	}

	void say_heal()
	{
		SayText("Oh my , let me help you with that...");
		PlayAnim("once", "retina");
		ScheduleDelayedEvent(1, "attack_1");
	}

	void attack_1()
	{
		ApplyEffect("ent_lastspoke", "effects/effect_rejuv2", 0, 1000, GetEntityIndex(GetOwner()));
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Ask to be Healed";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_heal";
	}

}

}
