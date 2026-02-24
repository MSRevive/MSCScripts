#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Towncrier : CGameScript
{
	int EVIDENCE_FOUND;
	int NO_JOB;
	int TALKING;

	Towncrier()
	{
		NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (!(TALKING))
		{
		}
		SetSayTextRange(1024);
		SayText("News! Path to Gate City open! Orcish attacks on Helena nearly over!");
		SetSayTextRange("default");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Godfrey the Town Crier");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 2);
		EVIDENCE_FOUND = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_adventure", "adventure");
		CatchSpeech("say_rumour", "rumours");
		CatchSpeech("say_mayor", "mayor");
	}

	void say_hi()
	{
		TALKING = 1;
		SayText("Hello! What can " + I + " help you with? Looking for [adventure] ? Or perhaps you d like to hear about the [news] that goes around?");
		if (!(GetEntityProperty("ent_lastspoke", "player") == 1)) return;
		SetMoveDest(9999);
		SetRoam(false);
		ScheduleDelayedEvent(10, "resume");
	}

	void say_adventure()
	{
		SayText("Everyone new goes to the old sewers. It s not in use anymore, at least not as much, but the guards put items and money in");
		SayText("a chest they keep hidden somewhere in there.");
		ScheduleDelayedEvent(4, "say_adventure2");
	}

	void say_adventure2()
	{
		SayText("Indeed. It has encouraged many to join the guards. If fortune is with you , you might get their special price... Good luck!");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Have you heard? They fought back the orcs in Helena , and they re not just rebuilding it. Looks like it s becoming a market place , if you ask me.");
		ScheduleDelayedEvent(5, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("They ve set up several shops, and the inn is in business again. But I m not so sure if it ll do any good business.");
		ScheduleDelayedEvent(5, "say_rumour3");
	}

	void say_rumour3()
	{
		SayText(I + " have been hearing reports of repeated attacks. Things could get quite messy if you go out there.");
	}

	void say_mayor()
	{
		if (!(EVIDENCE_FOUND == 1)) return;
		SayText("Apparently , the mayor has been discovered to be working with the orcs! Surprises all around!");
	}

	void worldevent_evidence_found()
	{
		EVIDENCE_FOUND = 1;
	}

	void resume()
	{
		TALKING = 0;
		SetRoam(true);
	}

	void worldevent_time()
	{
		if (param1 == 24.00)
		{
			SayText("tis midnight and all is well!");
		}
		if (param1 == 1.00)
		{
			SayText("tis one in the morn and all is well!");
		}
		if (param1 == 2.00)
		{
			SayText("tis two in the morn and all is well!");
		}
		if (param1 == 3.00)
		{
			SayText("tis three in the morn and all is well!");
		}
		if (param1 == 4.00)
		{
			SayText("tis four in the morn and all is well!");
		}
		if (param1 == 5.00)
		{
			SayText("tis five in the morn and all is well!");
		}
		if (param1 == 6.00)
		{
			SayText("tis six in the morn and all is well!");
		}
		if (param1 == 7.00)
		{
			SayText("tis seven in the morn and all is well!");
		}
		if (param1 == 8.00)
		{
			SayText("tis eight in the morn and all is well!");
		}
		if (param1 == 9.00)
		{
			SayText("tis nine in the morn and all is well!");
		}
		if (param1 == 10.00)
		{
			SayText("tis ten in the morn and all is well!");
		}
		if (param1 == 11.00)
		{
			SayText("tis eleven in the morn and all is well!");
		}
		if (param1 == 12.00)
		{
			SayText("tis noon and all is well!");
		}
		if (param1 == 13.00)
		{
			SayText("tis one in the eve and all is well!");
		}
		if (param1 == 14.00)
		{
			SayText("tis two in the eve and all is well!");
		}
		if (param1 == 15.00)
		{
			SayText("tis three in the eve and all is well!");
		}
		if (param1 == 16.00)
		{
			SayText("tis four in the eve and all is well!");
		}
		if (param1 == 17.00)
		{
			SayText("tis five in the eve and all is well!");
		}
		if (param1 == 18.00)
		{
			SayText("tis six in the eve and all is well!");
		}
		if (param1 == 19.00)
		{
			SayText("tis seven in the eve and all is well!");
		}
		if (param1 == 20.00)
		{
			SayText("tis eight in the eve and all is well!");
		}
		if (param1 == 21.00)
		{
			SayText("tis nine in the eve and all is well!");
		}
		if (param1 == 22.00)
		{
			SayText("tis ten in the eve and all is well!");
		}
		if (param1 == 23.00)
		{
			SayText("tis eleven in the eve and all is well!");
		}
	}

}

}
