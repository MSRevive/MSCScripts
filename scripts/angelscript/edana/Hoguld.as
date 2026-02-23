#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Hoguld : CGameScript
{
	int ACCEPTED;
	int ASKED;

	Hoguld()
	{
		const int NO_RUMOR = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		if (ACCEPTED != 1)
		{
		}
		if (ASKED != 1)
		{
		}
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		SayText("Is anybody going to Deralia soon?");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Hoguld");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("walk");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("saY_job", "yes");
		CatchSpeech("say_no", "no");
		randomspawn();
		ASKED = 0;
		ACCEPTED = 0;
	}

	void say_hi()
	{
		if (!(ACCEPTED != 1)) return;
		if (!(ASKED != 1)) return;
		SayText("Hello there! You look like the traveling sort. Are you going to Deralia anytime soon?");
		SetMoveDest("ent_lastspoke");
		ASKED = 1;
	}

	void say_no()
	{
		if (!(ASKED == 1)) return;
		SayText("Oh....ok...thanks anyway");
		ASKED = 0;
	}

	void say_job()
	{
		if (!(ASKED == 1)) return;
		SayText("Excellent! I was wondering if you d be so kind as to deliver this letter for me?");
		SetMoveDest("ent_lastspoke");
		// TODO: offer ent_lastspoke item_letter
		ScheduleDelayedEvent(3, "say_letter2");
		ACCEPTED = 1;
	}

	void say_letter2()
	{
		SayText("As you can see , it s addressed to Willem Coflin in Deralia. If you can deliver that sometime, I d be most happy!");
		SetMoveDest("ent_lastspoke");
	}

	void randomspawn()
	{
		if (!(RandomInt(0, 99) > 50)) return;
		DeleteEntity(GetOwner());
	}

}

}
