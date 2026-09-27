#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Feldagor : CGameScript
{
	int HIRE_PRICE;
	int SAID_HI;

	Feldagor()
	{
		SAID_HI = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (!(SAID_HI))
		{
		}
		SetRace("human");
		if ((false))
		{
		}
		SetVolume(2);
		SAID_HI = 1;
		PlayAnim("once", "eye_weep");
		SayText("Huh?...an adventurer?");
		ScheduleDelayedEvent(2, "say_hi");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Feldagor the wise");
		SetRoam(false);
		SetModel("monsters/bludgeon_warrior.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetIdleAnim("stand");
		SetInvincible(true);
		HIRE_PRICE = RandomInt(1, 10);
		string reg.mitem.id = "hire";
		string reg.mitem.access = "all";
		string reg.mitem.title = "Offer: ";
		reg.mitem.title += HIRE_PRICE;
		reg.mitem.title += " gold";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:";
		reg.mitem.data += HIRE_PRICE;
		string reg.mitem.callback = "recvoffer_gold";
		CatchSpeech("say_hi", "hail");
	}

	void say_hi()
	{
		SayText("Hello...i am Feldagor the wise...i have been living down here for over 120 years...yes i got a spell so the undead cant see me");
		ScheduleDelayedEvent(2, "say_hi2");
	}

	void say_hi2()
	{
		PlayAnim("once", "pondering2");
		SayText("This was once our capital...before Lor Malgoriand...enslaved us...only a few escaped...give me gold and il tell you something.");
	}

	void recvoffer_gold()
	{
		ReceiveOffer("accept");
		PlayAnim("once", "yes");
		SayText("Thank you...anyway further down the hallway is a big room...it has a chest with valuable items...but it is guarded by the remains of our king.");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.id = "payment";
		string reg.mitem.title = "Offer ";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:";
		string reg.mitem.callback = "menu_recv_payment";
		string reg.mitem.cb_failed = "menu_recv_payment_failed";
	}

}

}
