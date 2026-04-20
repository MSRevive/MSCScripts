#pragma context server

#include "monsters/base_chat_array.as"
#include "NPCs/base_storage.as"

namespace MS
{

class Storage : CGameScript
{
	string ANIM_CHAT;
	string ANIM_IDLE;
	string ANIM_NO;
	string ANIM_STORE;
	string CHAT_CONV_ANIMS;
	int CHAT_NEVER_INTERRUPT;
	int DID_HELLO;
	string DID_INTRO;
	int DID_SNIDE;
	string GALA_CHEST_POS;
	string PLAYER_SPOTTED;
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
	string SAYTEXT_wondrous_NOFUNDS;
	string SAYTEXT_wondrous_PURCHASED;

	Storage()
	{
		GALA_CHEST_POS = /* TODO: $relpos */ $relpos(0, 64, 0);
		CHAT_NEVER_INTERRUPT = 1;
		CHAT_CONV_ANIMS = "look_idle;deep_idle;ref_aim_egon;ref_aim_squeek";
		ANIM_CHAT = "look_idle";
		ANIM_NO = "look_idle";
		ANIM_STORE = "ref_shoot_trip";
		ANIM_IDLE = "idle";
		SAYTEXT_REFUND = "Very well, I shall refund your fee then.";
		SAYTEXT_SELECT_ITEM = "Which item would you like us to store?";
		SAYTEXT_NOITEM = "I apologize, but I did not receive the item you wished to store.";
		SAYTEXT_NOTICKET = "It seems that I did not receive your ticket.";
		SAYTEXT_NOSTORABLES = "I fear that you have no items which we can store for you.";
		SAYTEXT_GIVETICKET = "Very good then, here is your ticket. Remember, as always, you may redeem such tickets at any Galat outlet.";
		SAYTEXT_SELECT_TICKET = "Very well then, which ticket would do you like to redeem?";
		SAYTEXT_HAND_WARN = "Please, for the love of Felewyn, remember to place the tickets you wish to redeem in your in your hands.";
		SAYTEXT_REDEEMTICKET = "We of Galat appreciate your business.";
		SAYTEXT_ITEMS_HANDS = "Please hold forth any items you wish to store in your hands.";
		SAYTEXT_wondrous_NOFUNDS = "I'm afraid you lack sufficient funds for this service.";
		SAYTEXT_wondrous_PURCHASED = "One scroll it is. Please be careful as to its usage, as we cannot provide refunds should you be foolish enough to summon the chest into a wall.";
	}

	void OnSpawn() override
	{
		SetName("Magi Varondo");
		SetHealth(30);
		SetInvincible(true);
		SetNoPush(true);
		SetGold(0);
		SetRace("beloved");
		SetWidth(28);
		SetHeight(96);
		SetModel("npc/elf_m_wizard.mdl");
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		SetRoam(false);
		PlayAnim("once", "idle");
		SetModelBody(1, 2);
		SetProp(GetOwner(), "skin", 7);
		SetSayTextRange(512);
		CatchSpeech("heard_hi", "hail");
		CatchSpeech("say_rumor", "job");
		CatchSpeech("heard_store", "shop");
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
		chat_add_text("introf_text", "Ah, salutations to the young adventurers. I had overheard there were some honored guests in the villa, but I knew not whether to believe my elven ears.", 7.6, "sound:voices/sorc_villa/varondo/villa_friendly_greeting_part_1.wav");
		chat_add_text("introf_text", "Greetings. I am Vorondo, stationed here by Galat to provide services to those unfortunate enough to pass though these orc infested lands.", 8.1, "sound:voices/sorc_villa/varondo/villa_friendly_greeting_part_2.wav");
		chat_add_text("introh_text", "Salutations, young adventurers. I would not venture further, for the villa just beyond this bend belongs to Runegahr and the Shadahar Orcs.", 7.1, "sound:voices/sorc_villa/varondo/villa_enemy_greeting_part_1.wav");
		chat_add_text("introh_text", "They tolerate my presence here, but would no doubt attempt to slay me were I to move closer, and they'll treat you no better, no doubt.", 7.3, "sound:voices/sorc_villa/varondo/villa_enemy_greeting_part_2.wav");
		chat_add_text("introh_text", "Should you choose to enter the villa, and are attacked - and mark my words, you will be - I fear I will not be able to assist you.", 7.1, "sound:voices/sorc_villa/varondo/villa_enemy_greeting_part_3.wav");
		chat_add_text("introh_text", "Galat wishes to maintain peaceful relations with this particular orc tribe, and thus I am forbade to interfere save in self-defense...", 7.4, "sound:voices/sorc_villa/varondo/villa_enemy_greeting_part_4.wav");
		chat_add_text("introh_text", "...and even then, I am under strict orders to favor discretion over valor.", 4.5, "sound:voices/sorc_villa/varondo/villa_enemy_greeting_part_5.wav");
		chat_add_text("hail_text", "I am Vorondo, stationed in this gods forsaken land to provide Galat services to those few who can make use of them.", 6.1, "sound:voices/sorc_villa/varondo/hailed.wav");
		chat_add_text("hail_text", "The orcs, savages though they maybe, tollerate my presense, so long as I setup shop no closer to their stronghold than this.", 7.1, "sound:voices/sorc_villa/varondo/hailed_2.wav");
		chat_add_text("hail_text", "I would have prefered, of course, to be stationed in Eswen Sylen, or someplace closer to my homeland - anywhere but here, really...", 8.0, "sound:voices/sorc_villa/varondo/hailed_3.wav");
		chat_add_text("hail_text", "But alas, as one of the few who can both defend themselves, and dependably provide Galat services, I drew the short straw, and wound up out... Here.", 9.5, "sound:voices/sorc_villa/varondo/hailed_4.wav");
		chat_add_text("hail_text", "It could be worse, I suppose. One does grow accustom to the smell of orc, over time. Now what services may I offer one of my rare customers?", 5.5, "sound:voices/sorc_villa/varondo/hailed_5.wav");
		chat_add_text("rumor_text", "Fear not for me. I am quite capable of defending myself. Not that I would attempt to move closer to the villa, for fear of the bloodbath that would ensue.", 8.5, "sound:voices/sorc_villa/varondo/rumours_or_survival_1.wav");
		chat_add_text("rumor_text", "I suppose, the high bankers of Galat had hoped to extend a hand of friendship to these orcs, for while they are still savages, they are more civil than most...", 7.7, "sound:voices/sorc_villa/varondo/rumours_or_survival_2.wav");
		chat_add_text("rumor_text", "I fear the effort has been ill-fated, however, for thus far, only two orcs have dared to use my services, and the rest have only agreed to stop trying to devour me.", 8.4, "sound:voices/sorc_villa/varondo/rumours_or_survival_3.wav");
		chat_add_text("rumor_text", "The human merchant from Sunden-dal uses my services, at least, so it isn't a total waste of my time - though I could surely think of more pleasant ways to spend it.", 9.2, "sound:voices/sorc_villa/varondo/rumours_or_survival_4.wav");
		chat_add_text("rumor_text", "It would be only slightly safer to setup in Sunden-dal, to the south, for it has problems of its own, though, unquestionably, the odor would be more pleasant.", 8.3, "sound:voices/sorc_villa/varondo/rumours_or_survival_5.wav");
		chat_add_text("rumor_text", "But alas, the Galat management has deemed the place too small to bother with, I suppose.", 5.2, "sound:voices/sorc_villa/varondo/rumours_or_survival_6.wav");
		chat_add_text("rumor_text", "...And thus, by cruel twist of fate, here I am.", 4.2, "sound:voices/sorc_villa/varondo/rumours_or_survival_7.wav");
		chat_add_text("storage_chest", "This, as I am sure you already know, is the enchanted Galat Storage Chest.", 5.7, "sound:voices/sorc_villa/varondo/asked_about_chest_1.wav");
		chat_add_text("storage_chest", "You may place items held in your hands into the chest with relative ease.", 4.6, "sound:voices/sorc_villa/varondo/asked_about_chest_2.wav");
		chat_add_text("storage_chest", "To withdraw items, simply open the chest and remove the items you desire.", 4.3, "sound:voices/sorc_villa/varondo/asked_about_chest_3.wav");
		chat_add_text("storage_chest", "The chest employs a dimensional pocket system, and thus will display an inventory unique to each customer's account.", 5.9, "sound:voices/sorc_villa/varondo/asked_about_chest_4.wav");
		chat_add_text("storage_chest", "The chest can hold a limited number of items for each customer, and it cannot store every type of item, so please be aware of its limitations.", 6.9, "sound:voices/sorc_villa/varondo/asked_about_chest_5.wav");
		chat_add_text("scroll_text", "The Wondrous Scroll allows you to summon a Galat Storage Chest anywhere you may happen to be at the time.", 5.2, "sound:voices/sorc_villa/varondo/asked_about_scroll_1.wav");
		chat_add_text("scroll_text", "Needless to say, this is quite useful for adventurers such as yourself, who often find themselves in, shall we say, out of the way places.", 9.1, "sound:voices/sorc_villa/varondo/asked_about_scroll_2.wav");
		chat_add_text("scroll_text", "Though it requires no magical skill, per say, one must be careful, when employing the scroll, not to summon the chest inside a wall or other obstacle.", 7.6, "sound:voices/sorc_villa/varondo/asked_about_scroll_3.wav");
		string SCROLL_LINE = "The scroll is not for the faint of fortune, however. It currently sells for ";
		SCROLL_LINE += GALA_SCROLL_PRICE;
		SCROLL_LINE += " gold.";
		chat_add_text("scroll_text", SCROLL_LINE, 5.2, "sound:voices/sorc_villa/varondo/asked_about_scroll_4.wav");
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		if ((CanSee("player", 256)))
		{
			DID_INTRO = 1;
			PLAYER_SPOTTED = GetEntityIndex(m_hLastSeen);
			do_intro();
		}
		else
		{
			ScheduleDelayedEvent(1.0, "scan_for_players");
		}
	}

	void do_intro()
	{
		if ((G_SORCV_FRIENDLY))
		{
			do_intro_friendly();
		}
		else
		{
			do_intro_hostile();
		}
	}

	void do_intro_friendly()
	{
		SetMoveDest(PLAYER_SPOTTED);
		chat_start_sequence("introf_text");
	}

	void do_intro_hostile()
	{
		SetMoveDest(PLAYER_SPOTTED);
		chat_start_sequence("introh_text");
	}

	void heard_hi()
	{
		DID_HELLO = 1;
		chat_start_sequence("hail_text");
	}

	void say_rumor()
	{
		DID_HELLO = 1;
		chat_start_sequence("rumor_text");
	}

	void heard_store()
	{
		OpenMenu(GetEntityIndex("ent_lastheard"));
	}

	void reset_side()
	{
		DID_SNIDE = 0;
	}

	void game_menu_getoptions()
	{
		SetMoveDest(param1);
		if (!(DID_HELLO))
		{
			if (!(DID_SNIDE))
			{
			}
			DID_SNIDE = 1;
			ScheduleDelayedEvent(60.0, "reset_side");
			if (!(CHAT_BUSY))
			{
			}
			chat_now("Welcome to Galat's Weapon and Armor Storage. We're everywhere, apparently.", 3.8, "sound:voices/sorc_villa/varondo/idle_gripe.wav");
		}
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "heard_hi";
		string reg.mitem.title = "A lone elf?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_rumor";
	}

	void say_storage_chest()
	{
		chat_start_sequence("storage_chest");
	}

	void say_wondrous()
	{
		chat_start_sequence("scroll_text");
	}

	void say_wondrous_cant_afford()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/failure_no_money.wav", 10);
	}

	void buy_scroll()
	{
		chat_move_mouth(4.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/scroll_bought.wav", 10);
	}

	void open_betabank()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/cancelled_transaction.wav", 10);
	}

	void cancel_trade()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/cancelled_transaction.wav", 10);
	}

	void say_select_item()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/store_item.wav", 10);
	}

	void activate_storage()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/store_item.wav", 10);
	}

	void bteller_error_no_item()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/failed_itemget.wav", 10);
	}

	void bteller_error_no_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/failed_ticketget.wav", 10);
	}

	void bteller_store_error()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/no_storables.wav", 10);
	}

	void bteller_give_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/storage_success.wav", 10);
	}

	void bteller_select_ticket()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/request_redeem_ticket.wav", 10);
	}

	void bteller_ticket_warn()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/no_ticket_in_hands.wav", 10);
	}

	void bteller_ticket_redeemed()
	{
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/success_other.wav", 10);
	}

	void bteller_hand_warn()
	{
		if (!(DID_HELLO)) return;
		if (!(GetGameTime() > NEXT_TALK)) return;
		chat_move_mouth(3.0);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/varondo/please_hold_forth_items.wav", 10);
	}

}

}
