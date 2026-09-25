#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_civilian.as"
#include "monsters/base_chat.as"

namespace MS
{

class Willem : CGameScript
{
	int NO_JOB;
	string QUEST_WINNER;

	Willem()
	{
		NO_JOB = 1;
		const int NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Willem");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("walk");
		CatchSpeech("say_hi", "hi");
		randomspawn();
	}

	void give_letter()
	{
		ReceiveOffer("accept");
		ScheduleDelayedEvent(1, "say_letter");
		QUEST_WINNER = param1;
	}

	void say_hi()
	{
		SayText("What do you want?");
		SetMoveDest("ent_lastspoke");
	}

	void say_letter()
	{
		SayText("Thank you. Wow , a letter from Hoguld , it has been ages.");
		SetMoveDest("ent_lastgave");
		ScheduleDelayedEvent(3, "say_letter2");
	}

	void say_letter2()
	{
		SayText(I + " hope this is enough for the trouble");
		SetMoveDest("ent_lastgave");
		// TODO: offer QUEST_WINNER health_mpotion
		// TODO: offer QUEST_WINNER gold 8
	}

	void randomspawn()
	{
		if (!(RandomInt(0, 99) > 65)) return;
		DeleteEntity(GetOwner());
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_letter")))
		{
			string reg.mitem.title = "Deliver letter";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_letter";
			string reg.mitem.callback = "give_letter";
		}
	}

}

}
