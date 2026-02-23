#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class KnightFoutpost : CGameScript
{
	int FoutpostTrans;
	int SAID_HI;

	KnightFoutpost()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(500);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Royal Knight");
		SetRoam(false);
		SetModel("npc/royal_guard1.mdl");
		SetInvincible(true);
		SetIdleAnim("idle1");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_leave1", "leaving");
		FoutpostTrans = 0;
	}

	void say_hi()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal1.wav", 10);
		SayText("I don't have much time to talk, adventurer.  We're [leaving] shortly.");
		SAID_HI = 1;
	}

	void say_leave1()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal2.wav", 10);
		SayText("The King has finally agreed to send reinforcements to an outpost to the north.");
		ScheduleDelayedEvent(5, "say_leave2");
	}

	void say_leave2()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal3.wav", 10);
		SayText("The Orcs have been more aggressive in their recent attacks.");
		ScheduleDelayedEvent(4, "say_leave3");
	}

	void say_leave3()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal4.wav", 10);
		SayText("We've received word from Vadrel that another attack would be imminent.");
		FoutpostTrans = 1;
	}

	void game_menu_getoptions()
	{
		if ((SAID_HI))
		{
			string reg.mitem.title = "Leaving?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_leave1";
		}
		if (FoutpostTrans == 1)
		{
			string reg.mitem.title = "Ask to Join";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "ask_join1";
		}
	}

	void ask_join1()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal5.wav", 10);
		SayText("Well, you seem to know how to use a weapon... or so I hope.");
		ScheduleDelayedEvent(5, "ask_join2");
	}

	void ask_join2()
	{
		EmitSound(GetOwner(), 5, "voices/deralia/royalknight/royal6.wav", 10);
		SayText("Just don't expect me to babysit you... or bring back your corpse.");
		ScheduleDelayedEvent(4, "start_vote");
	}

	void start_vote()
	{
		string VOTE_TITLE = "Join the Reinforcements to the Forgotton Outpost?";
		string L_OPTIONS = "Yes!:foutpost;No!:0";
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", L_OPTIONS, VOTE_TITLE, "Voting begins now!", 0);
	}

}

}
