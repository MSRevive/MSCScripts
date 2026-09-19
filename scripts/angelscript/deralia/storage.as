#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "NPCs/base_storage.as"
#include "monsters/base_civilian.as"

namespace MS
{

class Storage : CGameScript
{
	string ANIM_CHAT;
	string ANIM_IDLE;
	string ANIM_NO;
	string ANIM_RUN;
	string ANIM_STORE;
	string ANIM_WALK;
	int CHATTING;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	int CHAT_STEPS;
	int DID_HELLO;
	string GALA_CHEST_POS;
	int IS_FLEEING;
	string MY_HOME;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string SAYTEXT_GIVETICKET;
	string SAYTEXT_HAND_WARN;
	string SAYTEXT_ITEMS_HANDS;
	string SAYTEXT_NOITEM;
	string SAYTEXT_NOSTORABLES;
	string SAYTEXT_NOTICKET;
	string SAYTEXT_REDEEMTICKET;
	string SAYTEXT_REFUND;
	string SAYTEXT_SELECT_ITEM;
	string SAYTEXT_SELECT_TICKET;

	Storage()
	{
		GALA_CHEST_POS = /* TODO: $relpos */ $relpos(0, 48, 64);
		ANIM_CHAT = "pondering3";
		ANIM_NO = "no";
		ANIM_STORE = "return_needle";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk_scared";
		SAYTEXT_REFUND = "Here's your fee back. Such as it is.";
		SAYTEXT_SELECT_ITEM = "What do you wish to store?";
		SAYTEXT_NOITEM = "I did not recieve your item.";
		SAYTEXT_NOTICKET = "I did not recieve your ticket.";
		SAYTEXT_NOSTORABLES = "Sorry, I'm afraid you have nothing we can store for you.";
		SAYTEXT_GIVETICKET = "Here is your ticket! You can redeem that at any Galat outlet.";
		SAYTEXT_SELECT_TICKET = "Which ticket would do you like to redeem?";
		SAYTEXT_HAND_WARN = "Please place your tickets in your hands.";
		SAYTEXT_REDEEMTICKET = "Thank you for using Galat Storage.";
		SAYTEXT_ITEMS_HANDS = "Please hold forth any items you wish to store in your hands.";
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("Guilda of Galat s Storage");
		SetHealth(40);
		SetInvincible(false);
		SetGold(10);
		SetRace("human");
		SetWidth(28);
		SetHeight(96);
		SetModel("npc/human2.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("run");
		SetRoam(false);
		PlayAnim("once", "idle1");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("heard_rumor", "job");
		CatchSpeech("heard_store", "shop");
		ScheduleDelayedEvent(1.6, "post_spawn");
	}

	void post_spawn()
	{
		MY_HOME = GetMonsterProperty("origin");
	}

	void heard_hi()
	{
		if ((CHATTING)) return;
		CHATTING = 1;
		DID_HELLO = 1;
		PlayAnim("critical", "180_right");
		SayText("Welcome to Galat s Weapon and Armor Storage.");
		ScheduleDelayedEvent(5.0, "heard_hi2");
	}

	void heard_hi2()
	{
		SayText("For a nominal fee , we can store your weapons and armor.");
		ScheduleDelayedEvent(5.0, "heard_hi3");
	}

	void heard_hi3()
	{
		SayText("We ll give you a ticket for any item that we can store.");
		ScheduleDelayedEvent(5.0, "heard_hi4");
	}

	void heard_hi4()
	{
		SayText("Thanks to our contacts with the Felewyn wizards , you may redeem this ticket at any Galat outlet!");
		ScheduleDelayedEvent(5.0, "heard_hi5");
	}

	void heard_hi5()
	{
		CHATTING = 0;
		PlayAnim("critical", "pondering2");
		SayText("Galat has outlets in Deralia , Gatecity , Kray Eldorad , and surprisingly , Helena.");
	}

	void heard_rumor()
	{
		PlayAnim("critical", "fear1");
		SayText("By Urdual! You mean there s more than one woman in this town!?");
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
			PlayAnim("critical", "lean");
			SayText("Welcome to Galat s Weapon and Armor Storage!");
		}
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "heard_hi";
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetRoam(true);
		SetMoveAnim(ANIM_RUN);
		SetMoveDest(m_hLastStruck);
		SetMenuAutoOpen(0);
		if ((IS_FLEEING)) return;
		IS_FLEEING = 1;
		ScheduleDelayedEvent(20.0, "stop_fleeing");
	}

	void stop_fleeing()
	{
		SetMoveDest(MY_HOME);
		SetMoveAnim(ANIM_WALK);
		SetMenuAutoOpen(1);
		SetRoam(false);
		IS_FLEEING = 0;
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
		CHAT_STEP1 = "Yes, this before me is the latest in magical banking: Galat's Wondrous Chest of Storage!";
		CHAT_STEP2 = "This new chest here can store items for you, no need for tickets.";
		CHAT_STEP3 = "Simply place the items you wish to store in your hands, and use the chest. It does the rest!";
		CHAT_STEP4 = "To withdraw items, use it as you would any chest, simply reach in and take what you need.";
		CHAT_STEP5 = "The chest keeps each customer's inventory in a special dimensional pocket only the customer can access.";
		CHAT_STEP6 = "The chest can hold about a couple dozen or so items for each user. You can use this one here at any time.";
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
		CHAT_STEP1 = "With a Wondrous Scroll of Galat's storage you can summon Galat's Wondrous Chest of Storage anywhere you may happen to be.";
		CHAT_STEP2 = "Any Galat customers present can then use the chest to access whatever items they have stored therein.";
		CHAT_STEP3 = "Each scroll is good for single summoning. Be sure you have a fair amount of room around yourself for the chest to manifest in.";
		CHAT_STEP4 = "I, and any Galat Banking representative can sell you one of these scrolls for the meager asking price of ";
		CHAT_STEP4 += GALA_SCROLL_PRICE;
		CHAT_STEP4 += " gold.";
		chat_loop();
	}

}

}
