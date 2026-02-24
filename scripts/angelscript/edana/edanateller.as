#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "NPCs/base_storage.as"

namespace MS
{

class Edanateller : CGameScript
{
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	int CHAT_STEPS;
	int DID_HELLO;
	string GALA_CHEST_POS;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int PLACEHOLDER;

	Edanateller()
	{
		PLACEHOLDER = 0;
		GALA_CHEST_POS = /* TODO: $relpos */ $relpos(55, 8, 0);
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("Edric of Galat s Storage");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetWidth(16);
		SetHeight(72);
		SetModel("npc/balancepriest1.mdl");
		SetModelBody(1, 1);
		SetRoam(false);
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("heard_rumor", "job");
		CatchSpeech("heard_store", "shop");
	}

	void heard_hi()
	{
		DID_HELLO = 1;
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
		SayText("We ll gives ya a ticket in exchange for any item we can store.");
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

	void heard_rumor()
	{
		SayText("Look , " + I + "just work here , " + I + " don t live here. You got an item to store, or what?");
	}

	void heard_store()
	{
		OpenMenu(GetEntityIndex("ent_lastheard"));
	}

	void game_menu_getoptions()
	{
		if (!(DID_HELLO))
		{
			DID_HELLO = 1;
			SayText("Welcome to Galat s Weapon and Armor Storage!");
		}
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "heard_hi";
	}

	void say_storage_chest()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_storage_chest");
		}
		if ((BUSY_CHATTING)) return;
		convo_anim();
		CHAT_STEPS = 6;
		CHAT_STEP1 = "Ah yes, our new Galat Chest of Wondrous Storage!";
		CHAT_STEP2 = "This new chest here can store items for you, without the need to redeem tickets.";
		CHAT_STEP3 = "Simply place the items you wish to store in your hands, and use the chest.";
		CHAT_STEP4 = "To withdraw items, use it as you would any chest, simply reach in and take what you need.";
		CHAT_STEP5 = "The chest keeps each customer's inventory in a special dimensional pocket only the customer can access.";
		CHAT_STEP6 = "The chest can hold about a dozen or so items for each user. It's free to use for a limited time!";
		chat_loop();
	}

	void say_wondrous()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_wondrous");
		}
		if ((BUSY_CHATTING)) return;
		convo_anim();
		CHAT_STEPS = 4;
		CHAT_STEP1 = "With a Wondrous Scroll of Galat's storage you can summon Galat's Chest of Wondrous Storage anywhere you may happen to be!";
		CHAT_STEP2 = "Any Galat customers present can then use the chest to access whatever items they have stored therein.";
		CHAT_STEP3 = "Each scroll is only good for one use. Be sure there's a patch of flat ground in front of you, big enough for the chest to manifest in.";
		CHAT_STEP4 = "Right now you can purchase these scrolls for the reasonable price of ";
		CHAT_STEP4 += GALA_SCROLL_PRICE;
		CHAT_STEP4 += " gold!";
		chat_loop();
	}

}

}
