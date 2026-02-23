#pragma context server

#include "NPCs/base_storage.as"
#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_civilian.as"
#include "helena/helena_npc.as"

namespace MS
{

class Storage : CGameScript
{
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_STEP1;
	string ANIM_STEP2;
	string ANIM_STEP3;
	string ANIM_STEP4;
	string ANIM_WALK;
	int CHATTING;
	float CHAT_DELAY_STEP1;
	float CHAT_DELAY_STEP2;
	float CHAT_DELAY_STEP3;
	float CHAT_DELAY_STEP4;
	float CHAT_DELAY_STEP5;
	string CHAT_SOUND1;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_SOUND4;
	string CHAT_SOUND5;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	int CHAT_STEPS;
	int DID_HELLO;
	float FEE_HP_RATIO;
	int IS_FLEEING;
	int RAID_ON;
	int STORE_CLOSED;

	Storage()
	{
		const string GALA_CHEST_POS = /* TODO: $relpos */ $relpos(0, 64, 64);
		const string ANIM_CHAT = "pondering3";
		const string ANIM_NO = "no";
		const string ANIM_STORE = "return_needle";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk_scared";
		const string SAYTEXT_REFUND = "Ummm Okay... Here's yer fee back. Come back anytime.";
		const string SAYTEXT_SELECT_ITEM = "What would you like to store?";
		const string SAYTEXT_NOITEM = "Er, sorry, I didn't get the the thing you were going to store.";
		const string SAYTEXT_NOTICKET = "Sorry, I didn't get your ticket.";
		const string SAYTEXT_NOSTORABLES = "Sorry, I'm afraid you have nothing I can store for you.";
		const string SAYTEXT_GIVETICKET = "Here's your ticket! Remember, ya can redeem that at any Galat outlet.";
		const string SAYTEXT_SELECT_TICKET = "Which ticket would do you like to redeem?";
		const string SAYTEXT_HAND_WARN = "Please place your tickets in your hands so I can redeem them for you.";
		const string SAYTEXT_REDEEMTICKET = "Th.. th... Thank you for using Galat Storage... Please come again! ...SOON!";
		const string SAYTEXT_ITEMS_HANDS = "Please hold forth any items you wish to store in your hands.";
		const string SAYTEXT_wondrous_NOFUNDS = "Eh, look, I can't take less than that for it. Sorry, but I need this job.";
		const string SAYTEXT_wondrous_PURCHASED = "Here you go. Careful not to summon it into any walls. Remember: no refunds!";
		const int NO_HAIL = 1;
		const int NO_JOB = 1;
	}

	void OnSpawn() override
	{
		SetName("Smivel of Galat s Storage");
		SetHealth(30);
		SetInvincible(false);
		SetGold(0);
		SetRace("human");
		SetWidth(28);
		SetHeight(96);
		SetModel("npc/human1.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		SetRoam(false);
		PlayAnim("once", "idle1");
		SetModelBody(0, 3);
		SetModelBody(1, 4);
		SetSayTextRange(1024);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("say_rumor", "job");
		CatchSpeech("heard_store", "shop");
	}

	void heard_hi()
	{
		if ((CHATTING)) return;
		CHATTING = 1;
		DID_HELLO = 1;
		PlayAnim("critical", "checktie");
		SayText("Eh? Oh , hello good sir... Um... Welcome to Galat s Weapon and Armor Storage.");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/welcome_to_galats.wav", 10);
		ScheduleDelayedEvent(5.8, "heard_hi2");
	}

	void heard_hi2()
	{
		SayText("For a nominal fee , we can store weapons and armor.");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/for_a_nominal_fee.wav", 10);
		ScheduleDelayedEvent(4.2, "heard_hi3");
	}

	void heard_hi3()
	{
		SayText("We ll give you a ticket for any item that we can store.");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/well_give_you_a_ticket.wav", 10);
		ScheduleDelayedEvent(3.1, "heard_hi4");
	}

	void heard_hi4()
	{
		SayText("Thanks to our contacts with the Felewyn wizards , you may redeem this ticket at any Galat outlet!");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/thanks_to_our_contacts.wav", 10);
		ScheduleDelayedEvent(5.9, "heard_hi5");
	}

	void heard_hi5()
	{
		CHATTING = 0;
		PlayAnim("critical", "lean");
		SayText("There are many other Galat outlets... All of which are in safer places than mine!");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/there_are_many_other_outlets.wav", 10);
	}

	void say_rumor()
	{
		PlayAnim("critical", "panic");
		bchat_auto_mouth_move(3.0);
		SayText("I m hoping to get promoted to the Deralia branch - IT ISN T SAFE HERE!");
		EmitSound(GetOwner(), 0, "voices/helena/smivel/im_hoping_to_get_promoted.wav", 10);
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
			PlayAnim("critical", "eye_wipe");
			SayText("Umm... Oh yeah... Welcome to Galat s Weapon and Armor Storage!");
			EmitSound(GetOwner(), 0, "voices/helena/smivel/startled_hello.wav", 10);
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

	void orc_raid()
	{
		IS_FLEEING = 1;
		game_struck();
	}

	void tele_home()
	{
		FEE_HP_RATIO = 0.01;
	}

	void helena_made_it_home()
	{
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
		string OLD_YAW = /* TODO: $vec.yaw */ $vec.yaw(NPC_HOME_ANG);
		SetAngles("face");
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetRoam(false);
		SetMenuAutoOpen(1);
		STORE_CLOSED = 0;
		RAID_ON = 0;
	}

	void say_storage_chest()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_storage_chest");
		}
		if ((BUSY_CHATTING)) return;
		convo_anim();
		CHAT_STEPS = 5;
		CHAT_STEP1 = "Oh yeah, that thing. Umm.. That's the new magical storage chest Galat put out recently.";
		CHAT_SOUND1 = "voices/helena/smivel/oh_yeah_that_thing.wav";
		CHAT_DELAY_STEP1 = 6.5;
		CHAT_STEP2 = "Eh, well.. You can put things in it, and it will store them for you.";
		CHAT_SOUND2 = "voices/helena/smivel/well_you_can_put_things_in_it.wav";
		CHAT_DELAY_STEP2 = 3.9;
		CHAT_STEP3 = "You can take things out too, of course. Just treat it like any other chest for that.";
		CHAT_SOUND3 = "voices/helena/smivel/you_can_take_things_out_too.wav";
		CHAT_DELAY_STEP3 = 4.7;
		CHAT_STEP4 = "Each customer's items are kept in a Dim... Dim-en-sion-al pocket. So they, eh, don't get mixed up.";
		CHAT_SOUND4 = "voices/helena/smivel/each_customers_items_are_stored.wav";
		CHAT_DELAY_STEP4 = 9.0;
		CHAT_STEP5 = "It holds maybe a few dozen items or so. Feel free to use it. Damn thing gives me the creeps.";
		CHAT_SOUND5 = "voices/helena/smivel/holds_a_dozen_items.wav";
		CHAT_DELAY_STEP5 = 6.3;
		chat_loop();
	}

	void say_wondrous()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_wondrous");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEPS = 4;
		ANIM_STEP1 = "checktie";
		CHAT_STEP1 = "Oh yes, *cough* with Galat's new Wondrous Scroll, you can summon forth a Galat's Wondrous Chest, anywhere.";
		CHAT_SOUND1 = "voices/helena/smivel/with_galats_new_wonderous_scroll.wav";
		CHAT_DELAY_STEP1 = 8.5;
		ANIM_STEP2 = "lean";
		CHAT_STEP2 = "Which, I'd guess, would be very useful given the sort of places adventurer's like yourself get off to.";
		CHAT_SOUND2 = "voices/helena/smivel/with_i_guess_would_be_very_useful.wav";
		CHAT_DELAY_STEP2 = 6.3;
		ANIM_STEP3 = "eye_wipe";
		CHAT_STEP3 = "We're supposed to sell these things for... Wow... That can't be right... Ummm... ";
		CHAT_STEP3 += GALA_SCROLL_PRICE;
		CHAT_STEP3 += " gold.";
		CHAT_SOUND3 = "voices/helena/smivel/were_supposed_to_sell_these_things_for.wav";
		CHAT_DELAY_STEP3 = 7.7;
		ANIM_STEP4 = "no";
		CHAT_STEP4 = "I guess the higher ups at Galat figure adventurer's like yourself are just made of gold.";
		CHAT_SOUND4 = "voices/helena/smivel/i_figure_the_higher_ups_at_galats.wav";
		CHAT_DELAY_STEP4 = 5.2;
		LogDebug("say_wondrous ANIM_STEP1");
		chat_loop();
	}

	void say_wondrous_cant_afford()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_lacks_funds.wav", 10);
	}

	void buy_scroll()
	{
		chat_move_mouth(4.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_buys_scroll.wav", 10);
	}

	void open_betabank()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_declines_to_store.wav", 10);
	}

	void cancel_trade()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_declines_to_store.wav", 10);
	}

	void say_select_item()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_wants_to_store.wav", 10);
	}

	void activate_storage()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_wants_to_store.wav", 10);
	}

	void bteller_error_no_item()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/bank_didnt_get_the_item.wav", 10);
	}

	void bteller_error_no_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/bank_failed_to_find_ticket.wav", 10);
	}

	void bteller_store_error()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/no_items_to_store.wav", 10);
	}

	void bteller_give_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/heres_your_ticket.wav", 10);
	}

	void bteller_select_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/player_asks_to_redeem.wav", 10);
	}

	void bteller_ticket_warn()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/please_place_ticket_in_hands.wav", 10);
	}

	void bteller_ticket_redeemed()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/thank_you_for_using_galat_storage.wav", 10);
	}

	void bteller_hand_warn()
	{
		if (!(DID_HELLO)) return;
		if (!(GetGameTime() > NEXT_TALK)) return;
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/helena/smivel/please_hold_forth_items.wav", 10);
	}

}

}
