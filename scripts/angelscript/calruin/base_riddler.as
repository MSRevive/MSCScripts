#pragma context server

namespace MS
{

class BaseRiddler : CGameScript
{
	int INTRODUCED;
	int NTRODUCED;
	int RIDDLE_ANSWERED;
	string VICTIM;

	BaseRiddler()
	{
		RIDDLE_ANSWERED = 0;
		NTRODUCED = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if ((CanSee("player", 128)))
		{
		}
		ScheduleDelayedEvent(2, "say_riddle1");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("undead");
		SetName("Riddlemaster");
		SetRoam(false);
		SetModel("monsters/riddler.mdl");
		SetInvincible(true);
		SetNoPush(true);
		CatchSpeech("say_riddle1", "hi");
		CatchSpeech("say_riddle", "yes");
		CatchSpeech("say_answer", RIDDLE_ANSWER);
		SetSolid("none");
	}

	void say_riddle1()
	{
		if ((INTRODUCED)) return;
		INTRODUCED = 1;
		SayText("Halt! You may not proceed until you answer a riddle!");
		ScheduleDelayedEvent(4, "say_riddle2");
	}

	void say_riddle2()
	{
		SayText("Take my advice and leave, for if you fail to answer, you will die!");
		ScheduleDelayedEvent(4, "say_riddle3");
	}

	void say_riddle3()
	{
		SayText("Despite the risk, are you willing to try?");
	}

	void say_riddle()
	{
		if (!(INTRODUCED)) return;
		if ((RIDDLE_ANSWERED)) return;
		VICTIM = GetEntityIndex("ent_lastspoke");
		riddle_question();
		ScheduleDelayedEvent(30, "kill_player");
	}

	void say_answer()
	{
		RIDDLE_ANSWERED = 1;
		riddle_correct();
		ScheduleDelayedEvent(2, "death");
	}

	void death()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void kill_player()
	{
		if ((RIDDLE_ANSWERED)) return;
		string MY_TARGET_POS = GetEntityOrigin(VICTIM);
		MY_TARGET_POS += Vector3(0, 0, 16);
		SayText(FAILED_MSG);
		string l.sky = MY_TARGET_POS;
		l.sky += Vector3(0, 0, 4096);
		EmitSound3D("weather/Storm_exclamation.wav", 10, MY_TARGET_POS);
		ClientEvent("new", "all_in_sight", "effects/sfx_lightning", MY_TARGET_POS, l.sky, 1, 1);
		DoDamage(VICTIM, "direct", 10000, 1.0, GetOwner());
		ScheduleDelayedEvent(5, "restart");
	}

	void restart()
	{
		INTRODUCED = 0;
	}

}

}
