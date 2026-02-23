#pragma context server

#include "monsters/base_npc.as"
#include "NPCs/base_storage.as"

namespace MS
{

class Storage : CGameScript
{
	Storage()
	{
		const int PLACEHOLDER = 0;
	}

	void OnSpawn() override
	{
		SetName("Edric of Galat s Storage");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetWidth(28);
		SetHeight(96);
		SetModel("npc/balancepriest1.mdl");
		SetModelBody(1, 1);
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("heard_rumor", "job");
		CatchSpeech("heard_store", "shop");
	}

	void heard_hi()
	{
		PlayAnim("critical", "talkright");
		SayText("Greetings , welcome to Galat s Weapon and Armor Storage...");
		ScheduleDelayedEvent(5.0, "heard_hi2");
	}

	void heard_hi2()
	{
		SayText("For a nominal fee , we can store your items here for you.");
		ScheduleDelayedEvent(5.0, "heard_hi3");
	}

	void heard_hi3()
	{
		SayText("We ll give you a ticket in exchange for any item we can store.");
		ScheduleDelayedEvent(5.0, "heard_hi4");
	}

	void heard_hi4()
	{
		SayText("Thanks to our contacts with the Felewyn wizards , you can redeem this ticket at any Galat outlet.");
		ScheduleDelayedEvent(5.0, "heard_hi5");
	}

	void heard_hi5()
	{
		SayText("Galat has outlets in Deralia , Gatecity , Kray Eldorad , and now , even in Helena!");
	}

	void heard_rurmor()
	{
		SayText("Look , I just work here , I don t live here. You got an item to store, or what?");
	}

	void heard_store()
	{
		OpenMenu(GetEntityIndex("ent_lastheard"));
	}

}

}
