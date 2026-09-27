#pragma context server

namespace MS
{

class BaseArrowStorage : CGameScript
{
	string ANIM_CHAT;
	string ANIM_NO;
	string ANIM_YES;
	string ARROW_NAMES;
	string BOLT_NAMES;
	int CHECK_LOOP;
	string CUSTOMER_ID;
	string SAYTEXT_GIVE_TICKET;
	string SAYTEXT_NOTICKET;
	string SAYTEXT_NOT_ENOUGH;
	string SAYTEXT_REDEEMTICKET;

	BaseArrowStorage()
	{
		ARROW_NAMES = "proj_arrow_bluntwooden;proj_arrow_broadhead;proj_arrow_fire;proj_arrow_frost;proj_arrow_gholy;proj_arrow_holy;proj_arrow_jagged;proj_arrow_poison;proj_arrow_silvertipped;proj_arrow_wooden;";
		BOLT_NAMES = "proj_bolt_fire;proj_bolt_iron;proj_bolt_silver;proj_bolt_steel;proj_bolt_wooden";
		SAYTEXT_GIVE_TICKET = "There you go. You can redeem that ticket with most any fletcher in the land.";
		SAYTEXT_REDEEMTICKET = "Okay, here's your ammo.";
		SAYTEXT_NOT_ENOUGH = "Sorry, you don't have enough of those for me to sell you the ticket.";
		SAYTEXT_NOTICKET = "Sorry, I did not recieve the ticket.";
		ANIM_CHAT = "none";
		ANIM_YES = "none";
		ANIM_NO = "none";
	}

	void game_menu_getoptions()
	{
		CUSTOMER_ID = param1;
		check_for_item("proj_arrow_bluntwooden", 1);
		check_for_item("proj_arrow_broadhead", 1);
		check_for_item("proj_arrow_fire", 2);
		check_for_item("proj_arrow_frost", 10);
		check_for_item("proj_arrow_gholy", 20);
		check_for_item("proj_arrow_holy", 5);
		check_for_item("proj_arrow_jagged", 5);
		check_for_item("proj_arrow_poison", 5);
		check_for_item("proj_arrow_silvertipped", 1);
		check_for_item("proj_arrow_wooden", 1);
		check_for_item("proj_bolt_fire", 30);
		check_for_item("proj_bolt_iron", 10);
		check_for_item("proj_bolt_silver", 20);
		check_for_item("proj_bolt_steel", 10);
		check_for_item("proj_bolt_wooden", 1);
		if (!(ItemExists(param1, "item_tk_proj"))) return;
		CHECK_LOOP = 0;
		string N_NAMES = GetTokenCount(ARROW_NAMES, ";");
		for (int i = 0; i < N_NAMES; i++)
		{
			list_tickets(ARROW_NAMES);
		}
		CHECK_LOOP = 0;
		string N_NAMES = GetTokenCount(BOLT_NAMES, ";");
		for (int i = 0; i < N_NAMES; i++)
		{
			list_tickets(BOLT_NAMES);
		}
	}

	void gticket_proj_bolt_fire()
	{
		give_ticket("proj_bolt_fire");
	}

	void gticket_proj_bolt_iron()
	{
		give_ticket("proj_bolt_iron");
	}

	void gticket_proj_bolt_silver()
	{
		give_ticket("proj_bolt_silver");
	}

	void gticket_proj_bolt_steel()
	{
		give_ticket("proj_bolt_steel");
	}

	void gticket_proj_bolt_wooden()
	{
		give_ticket("proj_bolt_wooden");
	}

	void gticket_proj_arrow_bluntwooden()
	{
		give_ticket("proj_arrow_bluntwooden");
	}

	void gticket_proj_arrow_broadhead()
	{
		give_ticket("proj_arrow_broadhead");
	}

	void gticket_proj_arrow_fire()
	{
		give_ticket("proj_arrow_fire");
	}

	void gticket_proj_arrow_frost()
	{
		give_ticket("proj_arrow_frost");
	}

	void gticket_proj_arrow_gholy()
	{
		give_ticket("proj_arrow_gholy");
	}

	void gticket_proj_arrow_holy()
	{
		give_ticket("proj_arrow_holy");
	}

	void gticket_proj_arrow_jagged()
	{
		give_ticket("proj_arrow_jagged");
	}

	void gticket_proj_arrow_poison()
	{
		give_ticket("proj_arrow_poison");
	}

	void gticket_proj_arrow_silvertipped()
	{
		give_ticket("proj_arrow_silvertipped");
	}

	void gticket_proj_arrow_wooden()
	{
		give_ticket("proj_arrow_wooden");
	}

	void give_ticket()
	{
		string ITEM_TYPE = param1;
		string TICKET_NAME = "item_tk_";
		// TODO: UNCONVERTED: addstr TICKET_NAME ITEM_TYPE
		// TODO: offer CUSTOMER_ID TICKET_NAME
		PlayAnim("critical", ANIM_YES);
		SayText(SAYTEXT_GIVE_TICKET);
	}

	void list_tickets()
	{
		string CHECK_STRING = param2;
		string SEARCH_ITEM = GetToken(CHECK_STRING, CHECK_LOOP, ";");
		string SEARCH_TICKET = "item_tk_";
		SEARCH_TICKET += SEARCH_ITEM;
		if (!(ItemExists(CUSTOMER_ID, SEARCH_TICKET))) return;
		string TICKET_NAME = ItemExists(CUSTOMER_ID, SEARCH_TICKET);
		string reg.mitem.title = "Redeem ";
		string reg.mitem.type = "callback";
		string reg.mitem.data = SEARCH_ITEM;
		string reg.mitem.callback = "redeem_ticket";
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
			// TODO: offer PARAM1 ITEM_IN:150
			PlayAnim("critical", ANIM_YES);
			SayText(SAYTEXT_REDEEMTICKET);
		}
		else
		{
			SayText(SAYTEXT_NOTICKET);
			PlayAnim("critical", ANIM_NO);
		}
	}

	void not_enough_arrows()
	{
		PlayAnim("critical", ANIM_NO);
		SayText(SAYTEXT_NOT_ENOUGH);
	}

	void check_for_item()
	{
		string SEARCH_ITEM = param1;
		string STORAGE_FEE = PARAM;
		if (!(ItemExists(param1, SEARCH_ITEM))) return;
		string CALLBACK = "gticket_";
		CALLBACK += SEARCH_ITEM;
		string ITEM_NAME = ItemExists(param1, SEARCH_NAME);
		string reg.mitem.title = "Store: 150 ";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:";
		string reg.mitem.callback = CALLBACK;
		string reg.mitem.cb_failed = "not_enough_arrows";
	}

}

}
