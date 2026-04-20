#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "NPCs/base_storage.as"

namespace MS
{

class Edanateller : CGameScript
{
	string ANIM_CHAT;
	string ANIM_NO;
	string ANIM_STORE;
	float CHAT_DELAY_STEP1;
	float CHAT_DELAY_STEP2;
	float CHAT_DELAY_STEP3;
	float CHAT_DELAY_STEP4;
	string CHAT_SOUND1;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_SOUND4;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	string CONV_ANIMS;
	int DID_HELLO;
	string GALA_CHEST_POS;
	string NEXT_TALK;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int PLACEHOLDER;
	int PLAYING_DEAD;
	string SAYTEXT_BANKOPEN;
	string SAYTEXT_BANK_NOTE;
	string SAYTEXT_GIVETICKET;
	string SAYTEXT_HAND_WARN;
	string SAYTEXT_ITEMS_HANDS;
	string SAYTEXT_NOITEM;
	string SAYTEXT_NOSTORABLES;
	string SAYTEXT_NOTICKET;
	string SAYTEXT_REDEEMTICKET;
	string SAYTEXT_REFUND;
	string SAYTEXT_SELECT_CAT;
	string SAYTEXT_SELECT_ITEM;
	string SAYTEXT_SELECT_TICKET;
	string SAYTEXT_wondrous_NOFUNDS;
	string SAYTEXT_wondrous_PURCHASED;

	Edanateller()
	{
		PLACEHOLDER = 0;
		GALA_CHEST_POS = /* TODO: $relpos */ $relpos(55, 8, 0);
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 0;
		CONV_ANIMS = "idle1;flinch;laflinch;raflinch;llflinch;rlflinch";
		SAYTEXT_wondrous_NOFUNDS = "Need, more, flesh. I mean gold... Need more golds...";
		SAYTEXT_wondrous_PURCHASED = "One scroll... Use... Wisely.";
		SAYTEXT_BANKOPEN = "Behold... Your shinies.";
		SAYTEXT_REFUND = "Fee... Returned.";
		SAYTEXT_SELECT_ITEM = "Choose... Item.";
		SAYTEXT_SELECT_CAT = SAYTEXT_SELECT_ITEM;
		SAYTEXT_NOITEM = "Item, not, received.";
		SAYTEXT_NOTICKET = "Ticket, needs ticket.";
		SAYTEXT_NOSTORABLES = "Cannot, store.";
		SAYTEXT_GIVETICKET = "Ticket, I gives ticket to fleshling.";
		SAYTEXT_SELECT_TICKET = "Please choose ticket, fleshling.";
		SAYTEXT_HAND_WARN = "Tickets, in delicious meat hands, please.";
		SAYTEXT_REDEEMTICKET = "Fleshling... Transaction, complete.";
		SAYTEXT_ITEMS_HANDS = "Items to store, in delicious meat hands, please.";
		SAYTEXT_BANK_NOTE = "Give note, in exchange, golds.";
		ANIM_CHAT = "idle1";
		ANIM_NO = "llflinch";
		ANIM_STORE = "raflinch";
	}

	void OnSpawn() override
	{
		SetName("Deadric of Galat s Storage");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetWidth(16);
		SetHeight(72);
		SetModel("monsters/skeleton.mdl");
		SetModelBody(0, 8);
		SetRoam(false);
		PLAYING_DEAD = 1;
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("say_rumor", "job");
		CatchSpeech("heard_store", "shop");
	}

	void heard_hi()
	{
		DID_HELLO = 1;
		NEXT_TALK = GetGameTime();
		NEXT_TALK += 6.0;
		PlayAnim("critical", "idle1");
		SayText("Welcome , fleshlings , to Galat s Weapon and Armor Storage, Edeadna branch...");
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_hail1.wav", 10);
		ScheduleDelayedEvent(6.5, "heard_hi2");
	}

	void heard_hi2()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_hail2.wav", 10);
		SayText("Galat Storage , we re eveeerryyywheeeereee...");
	}

	void say_rumor()
	{
		PlayAnim("critical", "rlflinch");
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_rumors.wav", 10);
		SayText("The rumor mill here... Is kinda dead.");
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
			SayText("Welcome , fleshlings , to Galat s Weapon and Armor Storage, Edeadna branch...");
			EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_hail1.wav", 10);
			NEXT_TALK = GetGameTime();
			NEXT_TALK += 6.0;
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
		CHAT_STEPS = 4;
		CHAT_STEP1 = "Galat chest...";
		CHAT_DELAY_STEP1 = 1.5;
		CHAT_SOUND1 = "voices/nightmare_edana/teller_gchest1.wav";
		CHAT_STEP2 = "Put items to store in your, delicious, meat hands...";
		CHAT_DELAY_STEP2 = 4.25;
		CHAT_SOUND2 = "voices/nightmare_edana/teller_gchest2.wav";
		CHAT_STEP3 = "Then use chest...";
		CHAT_DELAY_STEP3 = 2.0;
		CHAT_SOUND3 = "voices/nightmare_edana/teller_gchest3.wav";
		CHAT_STEP4 = "Stores stuff...";
		CHAT_DELAY_STEP4 = 2.0;
		CHAT_SOUND4 = "voices/nightmare_edana/teller_gchest4.wav";
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
		CHAT_STEP1 = "Wondrous Scroll of Galat's Storage...";
		CHAT_DELAY_STEP1 = 3.0;
		CHAT_SOUND1 = "voices/nightmare_edana/teller_wscroll1.wav";
		CHAT_STEP2 = "Summons chests with demonic magicks.";
		CHAT_DELAY_STEP2 = 3.5;
		CHAT_SOUND2 = "voices/nightmare_edana/teller_wscroll2.wav";
		CHAT_STEP3 = "Use anywhere.";
		CHAT_DELAY_STEP3 = 1.5;
		CHAT_SOUND3 = "voices/nightmare_edana/teller_wscroll3.wav";
		CHAT_STEP4 = "Exchange is ";
		CHAT_STEP4 += GALA_SCROLL_PRICE;
		CHAT_STEP4 += " golds. ...or one soul.";
		CHAT_DELAY_STEP4 = 4.0;
		if (RandomInt(1, 2) == 1)
		{
			CHAT_SOUND4 = "voices/nightmare_edana/teller_wscroll4a.wav";
		}
		else
		{
			CHAT_SOUND4 = "voices/nightmare_edana/teller_wscroll4b.wav";
		}
		chat_loop();
	}

	void say_wondrous_cant_afford()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_wscroll_nofunds.wav", 10);
	}

	void buy_scroll()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_wscroll_purchased.wav", 10);
	}

	void open_betabank()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_return_fee1.wav", 10);
	}

	void cancel_trade()
	{
		if (RandomInt(1, 2) == 1)
		{
			EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_return_fee1.wav", 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_return_fee2.wav", 10);
		}
	}

	void say_select_item()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_choose_item.wav", 10);
	}

	void activate_storage()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_choose_item.wav", 10);
	}

	void bteller_error_no_item()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_store_error.wav", 10);
	}

	void bteller_error_no_ticket()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_ticket_error.wav", 10);
	}

	void bteller_store_error()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_store_error.wav", 10);
	}

	void bteller_give_ticket()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_ticket_purchased.wav", 10);
	}

	void bteller_select_ticket()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_choose_item.wav", 10);
	}

	void bteller_ticket_warn()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_ticket_detect.wav", 10);
	}

	void bteller_ticket_redeemed()
	{
		EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_store_success.wav", 10);
	}

	void bteller_hand_warn()
	{
		if (!(DID_HELLO)) return;
		if (!(GetGameTime() > NEXT_TALK)) return;
		if (RandomInt(1, 2) == 1)
		{
			EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_items_in_hands1.wav", 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, "voices/nightmare_edana/teller_items_in_hands2.wav", 10);
		}
	}

}

}
