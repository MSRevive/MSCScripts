#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Proffund : CGameScript
{
	int DEED;
	int GIVEREWARD;
	int NO_JOB;
	int NO_RUMOR;
	int OFFER;
	int OVER;
	int SLINKER;

	Proffund()
	{
		NO_JOB = 1;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("Proffund");
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Master Proffund");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("walk");
		SetInvincible(true);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_deed", "deed");
		CatchSpeech("say_slinker", "slinker");
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
		DEED = 0;
		SLINKER = 0;
		OFFER = 0;
		OVER = 2;
		GIVEREWARD = 0;
	}

	void say_hi()
	{
		if (GIVEREWARD == 0)
		{
			SayText("Yes , what do you want?");
		}
		if (GIVEREWARD == 1)
		{
			SayText("Nice work , here s your reward!");
			// TODO: offer ent_lastspoke gold 25
			// TODO: offer ent_lastspoke scroll_summon_rat
			GIVEREWARD = 0;
		}
	}

	void say_deed()
	{
		if (!(OVER == 0)) return;
		if (SLINKER == 0)
		{
			DEED = 1;
			SayText(A + " property deed? What nonsense is this? ... who sent you?");
		}
		else
		{
			SayText("Oh really? " + A + "deed to one of my farm properties , " + I + " suppose. Well , he ll have to try harder than you, if he s planning on");
			SayText("intimidating me into giving him a property deed!");
			ScheduleDelayedEvent(3, "say_helpme");
		}
	}

	void say_slinker()
	{
		if (!(OVER == 0)) return;
		if (DEED == 0)
		{
			SLINKER = 1;
			SayText("S-slinker? Shh , be a little quieter! My reputation , you understand.. What does he want?");
		}
		else
		{
			SayText("S-slinker? Shh , be a little quieter! Well , he ll have to try harder than you, if he s planning on intimidating me into giving him a property deed!");
			ScheduleDelayedEvent(3, "say_helpme");
		}
	}

	void say_helpme()
	{
		SayText("However , maybe you can help me out. " + I + " d like Slinker, shall we say, removed from the picture. Will you help me by, uhm, taking care of him?");
		OFFER = 1;
	}

	void say_yes()
	{
		if (!(OVER == 0)) return;
		if (!(OFFER == 1)) return;
		SayText("Excellent. When you return , " + I + " shall reward you...");
		CallExternal(FindEntityByName("Slinker"), "mortal");
		OVER = 1;
	}

	void say_no()
	{
		if (!(OVER == 0)) return;
		if (!(OFFER == 1)) return;
		SayText("Are..are you sure? " + I + " mean... please don t hurt me. Here, here! Take it!");
		// TODO: offer ent_lastspoke item_deed
		OFFER = 0;
		OVER = 1;
	}

	void slinker_dead()
	{
		GIVEREWARD = 1;
	}

	void quest_start()
	{
		LogDebug("Started!");
		OVER = 0;
	}

}

}
