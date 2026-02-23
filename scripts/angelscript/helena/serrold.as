#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Serrold : CGameScript
{
	int CAN_RUN;
	int CAN_SCREAM;
	int GAVE_GOLD;
	int GAVE_MONEY;
	int INN_CLOSED;
	int SEE_ENEMY;

	Serrold()
	{
		const int NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.2);
		CanSee("enemy");
		if (SEE_ENEMY == 0)
		{
		}
		flee();
		shiver();
		scream();
	}

	void OnSpawn() override
	{
		SetHealth(125);
		SetGold(2);
		SetName("Serrold");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 0);
		INN_CLOSED = 0;
		SEE_ENEMY = 0;
		CAN_SCREAM = 1;
		CAN_RUN = 1;
		GAVE_MONEY = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_orcs", "orcs");
		CatchSpeech("say_rumor", "people");
		CatchSpeech("say_dorfgan", "dorfgan");
		CatchSpeech("say_erkold", "erkold");
		CatchSpeech("say_serrold", "serrold");
		CatchSpeech("say_harry", "harry");
		CatchSpeech("say_innopen", "open");
		CatchSpeech("say_innopen", "hole");
		CatchSpeech("say_thanks", "ok");
		CatchSpeech("say_thanks", "okay");
		CatchSpeech("say_thanks", "sure");
	}

	void greet_players()
	{
		SetVolume(10);
		Say("oldvillager1[50] *[180] *[80] *[80] *[150] *[50] *[50] *[50] *[50]");
	}

	void say_hi()
	{
		PlayAnim("once", "panic");
		SayText("Please help our town! The [orcs] are attacking!");
		ScheduleDelayedEvent(2, "say_hi2");
	}

	void say_hi2()
	{
		SayText("Even if we survive the attack , we still need [people] to keep order in the town!");
	}

	void say_orcs()
	{
		PlayAnim("once", "fear1");
		SayText("Evil creatures spawned from hell!");
	}

	void say_rumor()
	{
		PlayAnim("once", "idle3");
		SayText("[serrold] , [dorfgan] and [erkold] are the only ones who can run this village! If we all die , the village will die with us!");
	}

	void say_dorfgan()
	{
		PlayAnim("once", "yes");
		SayText("The blacksmith. He is a good man , not even in times like this does he stop forgeing!");
	}

	void say_erkold()
	{
		PlayAnim("once", "yes");
		SayText("The man at the burnt down house. He and his family used to supply the village with food , but I am not sure how it will go now when the family has been kidnapped..");
	}

	void say_serrold()
	{
		PlayAnim("once", "yes");
		SayText("I am Serrold , the town elder.");
	}

	void say_harry()
	{
		PlayAnim("once", "no");
		SayText("That man is good for nothing. I closed down his Inn but I still get the feeling that something is going on in there..");
	}

	void say_innopen()
	{
		INN_CLOSED = "equals";
		if (!(GAVE_GOLD == 0)) return;
		PlayAnim("once", "no");
		SayText("What! He opened it up again! Well.. I guess I can t stop him. Here s some gold for telling me.");
		GAVE_GOLD = 1;
		// TODO: offer ent_lastspoke gold RandomInt(1, 3)
	}

	void say_thanks()
	{
		PlayAnim("once", "yes");
		SayText("Thank you! Now go out and kick some green butt!");
	}

	void robbed()
	{
		PlayAnim("once", "beatdoor");
	}

	void recvoffer_gold()
	{
		recv_enoughgold();
		recv_notenoughgold();
	}

	void recv_enoughgold()
	{
		OFFER_AMT = ">=";
		// TODO: UNCONVERTED: DLLFunc recvoffer accept
		SayText("I know Harry knows something...");
		PlayAnim("once", "yes");
	}

	void recv_notenoughgold()
	{
		OFFER_AMT = "<";
		// TODO: UNCONVERTED: DLLFunc recvoffer reject
		SayText("I am quite well off without your charity.");
		PlayAnim("once", "no");
	}

	void flee()
	{
		if (!(CAN_RUN == 1)) return;
		SetMoveAnim("run1");
		SetMoveDest("flee");
		SEE_ENEMY = 1;
		CAN_RUN = 1;
		ScheduleDelayedEvent(RandomInt(0, 4), "resetflee");
	}

	void shiver()
	{
		PlayAnim("once", "crouch_idle3");
		if (!(CAN_SCREAM == 1)) return;
		SetVolume(8);
		EmitSound(GetOwner(), "player/fallpain4.wav");
		Say("*[100]");
		ScheduleDelayedEvent(2, "flee");
	}

	void stopmoving()
	{
		if (!(SEE_ENEMY == 1)) return;
		SEE_ENEMY = 0;
	}

	void scream()
	{
		if (!(CAN_SCREAM == 1)) return;
		SetVolume(8);
		// PlayRandomSound from: "scientist/scream07.wav", "scientist/scream10.wav", "scientist/scream12.wav", "scientist/scream13.wav"
		array<string> sounds = {"scientist/scream07.wav", "scientist/scream10.wav", "scientist/scream12.wav", "scientist/scream13.wav"};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CAN_SCREAM = 0;
		Say("*[200]");
		ScheduleDelayedEvent(RandomInt(2, 6), "resetscream");
	}

	void resetscream()
	{
		CAN_SCREAM = 1;
	}

	void resetflee()
	{
		CAN_RUN = 1;
	}

	void struck()
	{
		SetRoam(true);
		SetVolume(8);
		EmitSound(GetOwner(), "player/fallpain4.wav");
		flee();
	}

	void parry()
	{
		PlayAnim("once", "flinch");
		flee();
	}

}

}
