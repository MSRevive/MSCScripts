#pragma context server

namespace MS
{

class BaseStorage : CGameScript
{
	string ARMOR_STRING1;
	string ARMOR_STRING2;
	string ARMOR_TYPES;
	string AXE_STRING;
	string AXE_TYPES;
	string BANK_USER;
	int BC_TOTAL_MOUTH_TIME;
	string BLUNT_STRING;
	string BLUNT_TYPES;
	string BOW_STRING;
	string BOW_TYPES;
	int CHECK_LOOP;
	string CUSTOMER_ID;
	float FEE_HP_RATIO;
	int FOUND_IN_HANDS;
	int GALA_SCROLL_PRICE;
	string GAUNTLET_STRING;
	string GAUNTLET_TYPES;
	int GAVE_HAND_WARNING;
	int GAVE_SELECT_TICKET_TEXT;
	string REGISTER_ITEMS;
	string REGISTER_TICKETS;
	string SMALLARM_STRING1;
	string SMALLARM_STRING2;
	string SMALLARM_TYPES;
	int STORAGE_ACTIVE;
	string STORAGE_TYPE;
	string SWORD_STRING1;
	string SWORD_STRING2;
	string SWORD_TYPES;
	int TICKETS_ACTIVE;
	int TICKET_COUNT;
	int TOTAL_COUNT;
	string USE_FEE;

	BaseStorage()
	{
		const string GALA_CHEST_POS = /* TODO: $relpos */ $relpos(0, 64, 64);
		GALA_SCROLL_PRICE = 5000;
		const string SAYTEXT_wondrous_NOFUNDS = "We're sorry, but you seem to lack the funds to purchase Galat's Wondrous Scroll.";
		const string SAYTEXT_wondrous_PURCHASED = "Here you go. It's only good for one use, so be sure you have room to use it.";
		const string STORAGE_DISPLAYNAME = "Galat's Storage";
		const string STORAGE_NAME = "main_bank";
		const float STORAGE_FEERATIO = 0.01;
		const int STORAGE_ACCOUNT_COST = 5;
		const string SAYTEXT_BANKOPEN = "There, that should be your stuff.";
		FEE_HP_RATIO = 0.1;
		AXE_STRING = "axes_2haxe;axes_axe;axes_battleaxe;axes_doubleaxe;axes_greataxe;axes_rsmallaxe;axes_runeaxe;axes_scythe;axes_smallaxe;axes_golden;axes_golden_ref;";
		BLUNT_STRING = "blunt_calrianmace;blunt_club;blunt_darkmaul;blunt_granitemace;blunt_granitemaul;blunt_greatmaul;blunt_hammer_dorfgan;blunt_hammer1;blunt_hammer2;blunt_hammer3;blunt_mace;blunt_maul;blunt_ravenmace;blunt_rudolfsmace;blunt_rustyhammer2;blunt_warhammer;";
		BOW_STRING = "bows_crossbow_light;bows_longbow;bows_orcbow;bows_shortbow;bows_swiftbow;bows_treebow;bows_orion1;";
		GAUNTLET_STRING = "blunt_gauntlets;blunt_gauntlets_fire;gauntlets_normal;blunt_snake_staff;";
		ARMOR_STRING1 = "armor_dark;armor_golden;armor_helm_dark;armor_helm_gaz1;armor_helm_gaz2;armor_helm_golden;armor_helm_knight;armor_helm_mongol;armor_helm_plate;armor_knight;armor_leather;armor_leather_studded;armor_leather_torn;armor_mongol;armor_plate;";
		ARMOR_STRING2 = "armor_helm_gray;armor_helm_bronze;";
		SMALLARM_STRING1 = "smallarms_bone_blade;smallarms_craftedknife;smallarms_craftedknife2;smallarms_craftedknife3;smallarms_craftedknife4;smallarms_dagger;smallarms_dirk;smallarms_fangstooth;smallarms_flamelick;smallarms_huggerdagger;smallarms_huggerdagger2;";
		SMALLARM_STRING2 = "smallarms_huggerdagger3;smallarms_huggerdagger4;smallarms_knife;smallarms_rknife;smallarms_royaldagger;";
		SWORD_STRING1 = "swords_bastardsword;swords_giceblade;swords_iceblade;swords_katana;swords_katana2;swords_katana3;swords_katana4;swords_liceblade;swords_longsword;swords_lostblade;swords_m2sword;swords_msword;swords_nkatana;swords_poison1;swords_rsword;swords_scimitar;";
		SWORD_STRING2 = "swords_shortsword;swords_skullblade;swords_skullblade2;swords_skullblade3;swords_skullblade4;swords_spiderblade;swords_testskin;swords_testsub;swords_volcano;swords_rune_green;";
		const int N_ADDITIONAL = 3;
		const string ADDITIONAL_ITEMS_01 = "blunt_gauntlets_serpant;blunt_gauntlets_leather;blunt_gauntlets_demon;bows_orion1;swords_novablade12;armor_pheonix55;axes_poison1;axes_vaxe;axes_thunder11;axes_gthunder11;blunt_lrod11;bows_thornbow;bows_crossbow_heavy33;armor_helm_undead;";
		const string ADDITIONAL_ITEMS_02 = "blunt_northmaul972;smallarms_frozentongueonflagpole;swords_frostblade55;armor_belmont;armor_belmont;blunt_mithral;armor_salamander;armor_fireliz;swords_wolvesbane;swords_blood_drinker;armor_leather_gaz1;axes_td;axes_tf;axes_ti;axes_tp;";
		const string ADDITIONAL_ITEMS_03 = "axes_dragon;smallarms_nh;bows_firebird;bows_frost;armor_faura;armor_paura;armor_venom;smallarms_k_fire;axes_tl;";
		const string SAYTEXT_REFUND = "No pressure, here's your fee back. Come back anytime.";
		const string SAYTEXT_SELECT_ITEM = "Please select the specific item you would like to store.";
		const string SAYTEXT_SELECT_CAT = SAYTEXT_SELECT_ITEM;
		const string SAYTEXT_NOITEM = "Sorry, I did not recieve the item.";
		const string SAYTEXT_NOTICKET = "Sorry, I did not recieve the ticket.";
		const string SAYTEXT_NOSTORABLES = "I'm sorry, you've no items we can store for you.";
		const string SAYTEXT_GIVETICKET = "Here's your ticket! Remember, you can redeem that at any Galat outlet.";
		const string SAYTEXT_SELECT_TICKET = "Please select which ticket you wish to redeem.";
		const string SAYTEXT_HAND_WARN = "Please place tickets in your hands before you attempt to redeem them.";
		const string SAYTEXT_REDEEMTICKET = "There ya go! Thank you for using Galat Storage, please come again!";
		const string SAYTEXT_ITEMS_HANDS = "Remember, I can only store items held forth in your hands.";
		const string SAYTEXT_BANK_NOTE = "Ah, a you wish to cash a Galat bank note. Yes, we can do that here.";
		const string ANIM_CHAT = "talkright";
		const string ANIM_NO = "deskidle";
		const string ANIM_STORE = "portal";
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(1.0, "create_bank");
	}

	void create_bank()
	{
		SpawnNPC("chests/bank1", GALA_CHEST_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		storage_reset();
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		RemoveMenuItem("abort_option");
		CUSTOMER_ID = GetEntityIndex(param1);
		if ((TICKETS_ACTIVE))
		{
			REGISTER_ITEMS = 0;
			REGISTER_TICKETS = 1;
		}
		if (!(STORAGE_ACTIVE))
		{
			count_items(CUSTOMER_ID);
			if ((ItemExists(param1, "item_galat_note_100")))
			{
				string reg.mitem.title = "Redeem Bank Note [100]";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "item_galat_note_100";
				string reg.mitem.callback = "note_hundred";
			}
			if ((ItemExists(param1, "item_galat_note_10")))
			{
				string reg.mitem.title = "Redeem Bank Note [10]";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "item_galat_note_10";
				string reg.mitem.callback = "note_ten";
			}
			string reg.mitem.title = "About storage chest";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_storage_chest";
			string reg.mitem.title = "Buy Wondrous Scroll (";
			reg.mitem.title += GALA_SCROLL_PRICE;
			reg.mitem.title += "gp)";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:";
			reg.mitem.data += GALA_SCROLL_PRICE;
			string reg.mitem.callback = "buy_scroll";
			string reg.mitem.cb_failed = "say_wondrous_cant_afford";
			string reg.mitem.title = "About Wondrous Scroll";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_wondrous";
		}
		if (!(FOUND_IN_HANDS))
		{
			if (TOTAL_COUNT > 0)
			{
			}
			SayText("SAYTEXT_ITEMS_HANDS");
			bteller_hand_warn();
		}
		if ((TICKETS_ACTIVE))
		{
			if (!(GAVE_SELECT_TICKET_TEXT))
			{
			}
			ScheduleDelayedEvent(0.5, "storage_reset");
		}
		if ((TICKETS_ACTIVE)) return;
		if (!(STORAGE_ACTIVE))
		{
			USE_FEE = GetEntityMaxHealth(param1);
			USE_FEE *= FEE_HP_RATIO;
			USE_FEE = int(USE_FEE);
			if (USE_FEE < 25)
			{
				USE_FEE = 25;
			}
			string reg.mitem.id = "a_storage";
			string reg.mitem.title = "Store an Item: ";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:";
			string reg.mitem.callback = "activate_storage";
			if (TOTAL_COUNT == 0)
			{
				PlayAnim("critical", ANIM_NO);
				SayText("SAYTEXT_NOSTORABLES");
				bteller_store_error();
				string reg.mitem.type = "disabled";
				RemoveMenuItem("a_storage");
			}
			if (!(FOUND_IN_HANDS))
			{
				string reg.mitem.type = "disabled";
			}
			if ((FOUND_IN_HANDS))
			{
			}
			if (TICKET_COUNT > 0)
			{
				string reg.mitem.id = "a_ticket";
				string reg.mitem.title = "Redeem a ticket";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "activate_tickets";
				int reg.mitem.disable = 0;
			}
		}
		if (!(STORAGE_ACTIVE)) return;
		string reg.mitem.cb_failed = "storage_reset";
		FOUND_IN_HANDS = 0;
		TOTAL_COUNT = 0;
		REGISTER_ITEMS = 1;
		REGISTER_TICKETS = 0;
		enum_all();
		if (FOUND_IN_HANDS == 0)
		{
			bteller_hand_warn();
			SayText("SAYTEXT_ITEMS_HANDS");
		}
		display_abort();
	}

	void count_items()
	{
		FOUND_IN_HANDS = 0;
		TOTAL_COUNT = 0;
		TICKET_COUNT = 0;
		REGISTER_ITEMS = 0;
		enum_all();
	}

	void check_inventory()
	{
		string CHECK_STRING = param2;
		string SEARCH_ITEM = GetToken(CHECK_STRING, CHECK_LOOP, ";");
		if ((ItemExists(CUSTOMER_ID, SEARCH_ITEM)))
		{
			if (!(REGISTER_TICKETS))
			{
			}
			int FOUND_ITEM = 1;
			if ((ItemExists(CUSTOMER_ID, SEARCH_ITEM)))
			{
			}
			string NOT_IN_HANDS = ItemExists(CUSTOMER_ID, SEARCH_ITEM);
			if (!(NOT_IN_HANDS))
			{
				FOUND_IN_HANDS = 1;
			}
			TOTAL_COUNT += 1;
			if ((REGISTER_ITEMS))
			{
				if (!(NOT_IN_HANDS))
				{
				}
				string ITEM_NAME = ItemExists(CUSTOMER_ID, SEARCH_ITEM);
				string reg.mitem.title = "Store ";
				string reg.mitem.type = "callback";
				string reg.mitem.data = SEARCH_ITEM;
				string reg.mitem.callback = "return_ticket";
				string reg.mitem.cb_failed = "storage_reset";
			}
		}
		if ((REGISTER_TICKETS))
		{
			string SEARCH_TICKET = "item_tk_";
			SEARCH_TICKET += SEARCH_ITEM;
			if ((ItemExists(CUSTOMER_ID, SEARCH_TICKET)))
			{
			}
			string NOT_IN_HANDS = ItemExists(CUSTOMER_ID, SEARCH_TICKET);
			if ((NOT_IN_HANDS))
			{
				if (!(GAVE_HAND_WARNING))
				{
				}
				SayText("SAYTEXT_HAND_WARN");
				bteller_ticket_warn();
				GAVE_HAND_WARNING = 1;
			}
			if (!(NOT_IN_HANDS))
			{
			}
			if (!(GAVE_SELECT_TICKET_TEXT))
			{
				SayText("SAYTEXT_SELECT_TICKET");
				GAVE_SELECT_TICKET_TEXT = 1;
				bteller_select_ticket();
			}
			string TICKET_NAME = ItemExists(CUSTOMER_ID, SEARCH_TICKET);
			string reg.mitem.title = TICKET_NAME;
			string reg.mitem.type = "callback";
			string reg.mitem.data = SEARCH_ITEM;
			string reg.mitem.callback = "redeem_ticket";
			string reg.mitem.cb_failed = "storage_reset";
		}
		if (!(REGISTER_ITEMS))
		{
			string SEARCH_TICKET = "item_tk_";
			SEARCH_TICKET += SEARCH_ITEM;
			if ((ItemExists(CUSTOMER_ID, SEARCH_TICKET)))
			{
				TICKET_COUNT += 1;
				string NOT_IN_HANDS = ItemExists(CUSTOMER_ID, SEARCH_ITEM);
				if ((NOT_IN_HANDS))
				{
					if (!(GAVE_HAND_WARNING))
					{
					}
					SayText("SAYTEXT_HAND_WARN");
					bteller_ticket_warn();
					GAVE_HAND_WARNING = 1;
				}
			}
		}
		CHECK_LOOP += 1;
	}

	void activate_storage()
	{
		SayText("SAYTEXT_SELECT_CAT");
		STORAGE_ACTIVE = 1;
		ScheduleDelayedEvent(0.5, "open_menu", param1);
	}

	void activate_tickets()
	{
		TICKETS_ACTIVE = 1;
		ScheduleDelayedEvent(0.5, "open_menu", param1);
	}

	void say_select_item()
	{
		SayText("SAYTEXT_SELECT_ITEM");
	}

	void return_ticket()
	{
		string ITEM_IN = param2;
		string TICKET_NAME = "item_tk_";
		TICKET_NAME += ITEM_IN;
		if ((ItemExists(param1, ITEM_IN)))
		{
			string METHOD_HACK = ItemExists(param1, ITEM_IN);
			// TODO: offer PARAM1 TICKET_NAME
			bteller_give_ticket();
			SayText("SAYTEXT_GIVETICKET");
		}
		else
		{
			SayText("SAYTEXT_NOITEM");
			PlayAnim("critical", ANIM_NO);
			bteller_error_no_item();
		}
		storage_reset();
	}

	void open_menu()
	{
		OpenMenu(CUSTOMER_ID);
	}

	void storage_reset()
	{
		STORAGE_TYPE = "unset";
		STORAGE_ACTIVE = 0;
		TICKETS_ACTIVE = 0;
		REGISTER_TICKETS = 0;
		REGISTER_ITEMS = 0;
		FOUND_IN_HANDS = 0;
		TOTAL_COUNT = 0;
		GAVE_SELECT_TICKET_TEXT = 0;
		GAVE_HAND_WARNING = 0;
	}

	void cancel_trade()
	{
		SayText("SAYTEXT_REFUND");
		// TODO: offer PARAM1 gold USE_FEE
		storage_reset();
	}

	void display_abort()
	{
		string reg.mitem.id = "abort_option";
		string reg.mitem.title = "Abort Transaction";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "cancel_trade";
	}

	void redeem_ticket()
	{
		string ITEM_IN = param2;
		string TICKET_NAME = "item_tk_";
		TICKET_NAME += ITEM_IN;
		if ((ItemExists(param1, TICKET_NAME)))
		{
			PlayAnim("critical", ANIM_STORE);
			string METHOD_HACK = ItemExists(param1, TICKET_NAME);
			// TODO: offer PARAM1 ITEM_IN
			SayText("SAYTEXT_REDEEMTICKET");
			bteller_ticket_redeemed();
		}
		else
		{
			SayText("SAYTEXT_NOTICKET");
			PlayAnim("critical", ANIM_NO);
			bteller_error_no_item();
		}
		storage_reset();
	}

	void enum_all()
	{
		CHECK_LOOP = 0;
		ARMOR_TYPES = GetTokenCount(ARMOR_STRING1, ";");
		for (int i = 0; i < ARMOR_TYPES; i++)
		{
			check_inventory("armor", ARMOR_STRING1);
		}
		CHECK_LOOP = 0;
		ARMOR_TYPES = GetTokenCount(ARMOR_STRING2, ";");
		for (int i = 0; i < ARMOR_TYPES; i++)
		{
			check_inventory("armor", ARMOR_STRING2);
		}
		CHECK_LOOP = 0;
		AXE_TYPES = GetTokenCount(AXE_STRING, ";");
		for (int i = 0; i < AXE_TYPES; i++)
		{
			check_inventory("axe", AXE_STRING);
		}
		CHECK_LOOP = 0;
		BLUNT_TYPES = GetTokenCount(BLUNT_STRING, ";");
		for (int i = 0; i < BLUNT_TYPES; i++)
		{
			check_inventory("blunt", BLUNT_STRING);
		}
		CHECK_LOOP = 0;
		BOW_TYPES = GetTokenCount(BOW_STRING, ";");
		for (int i = 0; i < BOW_TYPES; i++)
		{
			check_inventory("bow", BOW_STRING);
		}
		CHECK_LOOP = 0;
		GAUNTLET_TYPES = GetTokenCount(GAUNTLET_STRING, ";");
		for (int i = 0; i < GAUNTLET_TYPES; i++)
		{
			check_inventory("gauntlet", GAUNTLET_STRING);
		}
		CHECK_LOOP = 0;
		SMALLARM_TYPES = GetTokenCount(SMALLARM_STRING1, ";");
		for (int i = 0; i < SMALLARM_TYPES; i++)
		{
			check_inventory("smallarm", SMALLARM_STRING1);
		}
		CHECK_LOOP = 0;
		SMALLARM_TYPES = GetTokenCount(SMALLARM_STRING2, ";");
		for (int i = 0; i < SMALLARM_TYPES; i++)
		{
			check_inventory("smallarm", SMALLARM_STRING2);
		}
		CHECK_LOOP = 0;
		SWORD_TYPES = GetTokenCount(SWORD_STRING1, ";");
		for (int i = 0; i < SWORD_TYPES; i++)
		{
			check_inventory("sword", SWORD_STRING1);
		}
		CHECK_LOOP = 0;
		SWORD_TYPES = GetTokenCount(SWORD_STRING2, ";");
		for (int i = 0; i < SWORD_TYPES; i++)
		{
			check_inventory("sword", SWORD_STRING2);
		}
		if (!(N_ADDITIONAL >= 1)) return;
		CHECK_LOOP = 0;
		string NEXT_CHECK_LIST = ADDITIONAL_ITEMS_01;
		string CHECK_LIST_NITEMS = GetTokenCount(NEXT_CHECK_LIST, ";");
		for (int i = 0; i < CHECK_LIST_NITEMS; i++)
		{
			check_inventory("other", NEXT_CHECK_LIST);
		}
		if (!(N_ADDITIONAL >= 2)) return;
		CHECK_LOOP = 0;
		string NEXT_CHECK_LIST = ADDITIONAL_ITEMS_02;
		string CHECK_LIST_NITEMS = GetTokenCount(NEXT_CHECK_LIST, ";");
		for (int i = 0; i < CHECK_LIST_NITEMS; i++)
		{
			check_inventory("other", NEXT_CHECK_LIST);
		}
		if (!(N_ADDITIONAL >= 3)) return;
		CHECK_LOOP = 0;
		string NEXT_CHECK_LIST = ADDITIONAL_ITEMS_03;
		string CHECK_LIST_NITEMS = GetTokenCount(NEXT_CHECK_LIST, ";");
		for (int i = 0; i < CHECK_LIST_NITEMS; i++)
		{
			check_inventory("other", NEXT_CHECK_LIST);
		}
		if (!(N_ADDITIONAL >= 4)) return;
		CHECK_LOOP = 0;
		string NEXT_CHECK_LIST = ADDITIONAL_ITEMS_04;
		string CHECK_LIST_NITEMS = GetTokenCount(NEXT_CHECK_LIST, ";");
		for (int i = 0; i < CHECK_LIST_NITEMS; i++)
		{
			check_inventory("other", NEXT_CHECK_LIST);
		}
		if (!(N_ADDITIONAL >= 5)) return;
		CHECK_LOOP = 0;
		string NEXT_CHECK_LIST = ADDITIONAL_ITEMS_05;
		string CHECK_LIST_NITEMS = GetTokenCount(NEXT_CHECK_LIST, ";");
		for (int i = 0; i < CHECK_LIST_NITEMS; i++)
		{
			check_inventory("other", NEXT_CHECK_LIST);
		}
	}

	void note_hundred()
	{
		SayText("SAYTEXT_BANK_NOTE");
		PlayAnim("once", ANIM_CHAT);
		// TODO: offer PARAM1 gold 100
	}

	void note_ten()
	{
		SayText("SAYTEXT_BANK_NOTE");
		PlayAnim("once", ANIM_CHAT);
		// TODO: offer PARAM1 gold 10
	}

	void open_betabank()
	{
		Storage("checkaccount", STORAGE_NAME, m_hLastUsed, "betabank");
		BANK_USER = param1;
	}

	void betabank_success()
	{
		SayText("SAYTEXT_BANKOPEN");
		Storage("trade", STORAGE_NAME, BANK_USER, STORAGE_FEERATIO, STORAGE_DISPLAYNAME);
	}

	void betabank_failed()
	{
		convo_anim();
		SayText("We have this eh , mystic portal to the vaults. It seems to be working okay , but it s still a little experimental.");
		ScheduleDelayedEvent(2.0, "bank_intro1");
	}

	void bank_intro1()
	{
		SayText("You can use it for a minimal fee. Just beware that it is at the moment at your own risk - at least until the wizards get the kinks worked out.");
		Storage("openaccount", STORAGE_NAME, BANK_USER);
		ScheduleDelayedEvent(2.0, "bank_intro2");
	}

	void bank_intro2()
	{
		convo_anim();
		SayText("You can store more items in the betabank , and you don t have to deal with tickets. Also, usually cheaper - the cost is based on the value of the item.");
		SendInfoMsg(BANK_USER, "BETA BANK ACCOUNT OPEN Choose Open Betabank again to start using the betabank.");
	}

	void buy_scroll()
	{
		SayText("SAYTEXT_wondrous_PURCHASED");
		lchat_mouth_move();
		// TODO: offer PARAM1 item_gwond
		PlayAnim("once", "return_needle");
	}

	void say_wondrous_cant_afford()
	{
		SayText("SAYTEXT_wondrous_NOFUNDS");
		lchat_mouth_move();
		PlayAnim("once", "no");
	}

	void lchat_mouth_move()
	{
		BC_TOTAL_MOUTH_TIME = 0;
		string RND_SAY1 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY1 += M_TIME;
		RND_SAY1 += "]";
		string RND_SAY2 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY2 += M_TIME;
		RND_SAY2 += "]";
		string RND_SAY3 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY3 += M_TIME;
		RND_SAY3 += "]";
		string RND_SAY4 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY4 += M_TIME;
		RND_SAY4 += "]";
		Say("RND_SAY1 RND_SAY2 RND_SAY3 RND_SAY4");
		BC_TOTAL_MOUTH_TIME += 1.0;
		BC_TOTAL_MOUTH_TIME("bchat_close_mouth");
	}

	void lchat_close_mouth()
	{
		if ((NO_CLOSE_MOUTH)) return;
		SetProp(GetOwner(), "controller1", 0);
	}

}

}
