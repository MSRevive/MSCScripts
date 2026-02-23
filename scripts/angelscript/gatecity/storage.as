#pragma context server

#include "monsters/base_npc.as"
#include "NPCs/base_storage.as"

namespace MS
{

class Storage : CGameScript
{
	string ANIM_IDLE;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	int CHAT_STEPS;
	int DID_HELLO;

	Storage()
	{
		const string GALA_CHEST_POS = /* TODO: $relpos */ $relpos(20, 50, 50);
		const string ANIM_CHAT = "nod";
		const string ANIM_NO = "attack";
		const string ANIM_STORE = "nod";
		ANIM_IDLE = "idle";
		const string SAYTEXT_REFUND = "No pressure! Here's yer fee back. Come back anytime.";
		const string SAYTEXT_SELECT_ITEM = "Pick what yer gonna store.";
		const string SAYTEXT_NOITEM = "Er, sorry, I didn't get the thing.";
		const string SAYTEXT_NOTICKET = "Sorry, I didn't get yer ticket.";
		const string SAYTEXT_NOSTORABLES = "Sorry, ya've got nuttin I can store for you.";
		const string SAYTEXT_GIVETICKET = "Here's yer ticket! Remember, ya can redeem that at any Galat outlet.";
		const string SAYTEXT_SELECT_TICKET = "What ticket would ya like to redeem?";
		const string SAYTEXT_HAND_WARN = "Put yer tickets in your hands where I can see them please.";
		const string SAYTEXT_REDEEMTICKET = "There ya go! Thank you for using Galat Storage, please come again!";
		const string SAYTEXT_ITEMS_HANDS = "Gotta put yer stuff in yer hands before I can store it.";
	}

	void OnSpawn() override
	{
		SetName("Vogdor of Galat s Storage");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetWidth(28);
		SetHeight(96);
		SetModel("dwarf/male1.mdl");
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		SetRoam(false);
		PlayAnim("once", "idle");
		SetModelBody(0, 1);
		SetModelBody(1, 3);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("heard_rumor", "job");
		CatchSpeech("heard_store", "shop");
	}

	void heard_hi()
	{
		DID_HELLO = 1;
		PlayAnim("critical", ANIM_CHAT);
		EmitSound(GetOwner(), 0, "npc/dwarfatservice.wav", 10);
		SayText("ello thar, welcome to Galat s Weapon and Armor Storage...");
		ScheduleDelayedEvent(5.0, "heard_hi2");
	}

	void heard_hi2()
	{
		SayText("For a nominal fee , we can store yer things here for ya s.");
		ScheduleDelayedEvent(5.0, "heard_hi3");
	}

	void heard_hi3()
	{
		SayText("We ll gives you a ticket for anything we can store.");
		ScheduleDelayedEvent(5.0, "heard_hi4");
	}

	void heard_hi4()
	{
		SayText("Thanks to our contacts with the Felewyn wizards , ya can redeem this ticket at any Galat outlet!");
		ScheduleDelayedEvent(5.0, "heard_hi5");
	}

	void heard_hi5()
	{
		SayText("Galat has outlets all over - even in the forsaken town of Helena!");
	}

	void heard_rumor()
	{
		SayText("Hmm... Not much goin on here to be honest. We dwarves don t like change.");
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
		CHAT_STEP1 = "Ah, that bleedin thing be the new fangled Wondrous Chest of Storage.";
		CHAT_STEP2 = "This bugger here can store items for you, no need for tickets. Makes me wonder what I'm doin' here.";
		CHAT_STEP3 = "Just thrust your fists at it, whiling holdin' whatever it be you wantin' to get off yer hands.";
		CHAT_STEP4 = "Then, when ye want yer stuff back, just open her up - or anyone like her, anywhere.";
		CHAT_STEP5 = "The chest has some magic thingie on it that makes sure you, and only you, gets yer stuff.";
		CHAT_STEP6 = "It's free to use. Seems the lads at Galat HQ are in a giving mood this turn. *cough*";
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
		CHAT_STEP1 = "Ah, here be the interestin' part of the whole deal. With one of these, you can summon that there chest in front of me.";
		CHAT_STEP2 = "Meaning you, and yer friends, can have access to the Galat Wondrous Chest of Storage, wherever ye may happen to be.";
		CHAT_STEP3 = "Only works once though - and ye need a fair bit of room to place the chest, so be careful.";
		CHAT_STEP4 = "So, this where where they get ya. After suckering in with free use of the chest here, they charge you ";
		CHAT_STEP4 += GALA_SCROLL_PRICE;
		CHAT_STEP4 += " gold a piece the scrolls!";
		chat_loop();
	}

}

}
