#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class OldHarry : CGameScript
{
	int CAN_RUN;
	int CAN_SCREAM;
	int FRIGHTENED;
	int SAY_SO;
	int SEE_ENEMY;
	string STORENAME;

	OldHarry()
	{
		const int NO_RUMOR = 1;
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
		SetHealth(150);
		SetGold(1);
		SetName("Harry");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 1);
		SAY_SO = 0;
		FRIGHTENED = 0;
		SEE_ENEMY = 0;
		CAN_SCREAM = 1;
		CAN_RUN = 1;
		STORENAME = "harrys_inn";
		createmystore();
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_quiet", "quiet");
		CatchSpeech("say_orcs", "orcs");
		CatchSpeech("say_dorfgan", "dorfgan");
		CatchSpeech("say_erkold", "erkold");
		CatchSpeech("say_serrold", "serrold");
		CatchSpeech("say_thanks", "ok");
		CatchSpeech("say_thanks", "okay");
		CatchSpeech("say_thanks", "sure");
	}

	void say_hi()
	{
		PlayAnim("once", "pondering3");
		SayText("Greetings to you adventurer!");
		ScheduleDelayedEvent(3, "say_hi2test");
	}

	void say_hi2test()
	{
		SAY_SO = "equals";
		SayText("I am Harry , your humble innkeeper. If you want to stay here you will have to be [quiet] .");
		setsayso();
	}

	void satsayso()
	{
		SAY_SO = 1;
	}

	void say_quiet()
	{
		PlayAnim("once", "pondering2");
		SayText("I m not really allowed to give booze to the adventurers.. Serrold said it would "deterioate their performance" and then he gave order to barricade the door..");
		ScheduleDelayedEvent(4, "say_quiet2");
	}

	void say_quiet2()
	{
		PlayAnim("once", "pondering1");
		SayText("If would have stopped as he said , i would be ruined by now! So I made a small hole in the wall.. you probably saw it on your way in!");
	}

	void say_orcs()
	{
		SayText("They disappear after 10 drinks!");
	}

	void say_dorfgan()
	{
		PlayAnim("once", "yes");
		SayText("Nice guy , he keeps order when my customers get a little fuzzy");
	}

	void say_erkold()
	{
		PlayAnim("once", "yes");
		SayText("Poor man.. Lost everything..Except his armor , which he sent to Dorfgan for repairs , if I recall him correctly.");
	}

	void say_serrold()
	{
		PlayAnim("once", "no");
		SayText("Hmf. Our village elder . Never sat his foot in my beutiful Inn.");
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
		SayText("Last time Erkold was here , he said he was looking for someone to take care of his [armor] .");
		PlayAnim("once", "yes");
	}

	void recv_notenoughgold()
	{
		OFFER_AMT = "<";
		// TODO: UNCONVERTED: DLLFunc recvoffer reject
		SayText("I am quite well off without your charity.");
		PlayAnim("once", "no");
	}

	void playerused()
	{
		SetVolume(4);
		// TODO: offerstore STORENAME buysell trade
	}

	void createmystore()
	{
		// TODO: createstore STORENAME
		AddStoreItem(STORENAME, "health_apple", 15, 100);
		AddStoreItem(STORENAME, "health_mpotion", 4, 100, 0.2);
		AddStoreItem(STORENAME, "proj_arrow_wooden", 300, 90, 0, 25);
		AddStoreItem(STORENAME, "drink_mead", 20, 20);
		AddStoreItem(STORENAME, "drink_ale", 20, 20);
		AddStoreItem(STORENAME, "drink_wine", 20, 20);
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
