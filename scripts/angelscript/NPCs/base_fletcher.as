#pragma context server

namespace MS
{

class BaseFletcher : CGameScript
{
	string ANIM_CONVO;
	string ANIM_DONE;
	string ANIM_NO;
	int ARROW_MENU;
	string ARROW_STACK_TYPES;
	int BOLT_MENU;
	string BOLT_STACK_TYPES;
	string BUNDLE_AMT;
	int BUNDLE_MENU;
	string BUNDLE_TYPE;
	string CUSTOMER_ID;
	string GIVE_ITEM;
	string LOOP_COUNT;
	string SAYTEXT_BUNDLE;
	string SAYTEXT_BUNDLE_DONE;
	string SAYTEXT_NOT_ENOUGH;
	int VENDOR_MENU_OFF;

	BaseFletcher()
	{
		ARROW_STACK_TYPES = "proj_arrow_bluntwooden;proj_arrow_broadhead;proj_arrow_fire;proj_arrow_frost;proj_arrow_gholy;proj_arrow_gpoison;proj_arrow_holy;proj_arrow_jagged;proj_arrow_poison;proj_arrow_silvertipped;proj_arrow_wooden;";
		BOLT_STACK_TYPES = "proj_bolt_fire;proj_bolt_iron;proj_bolt_silver;proj_bolt_steel;proj_bolt_wooden;";
		SAYTEXT_NOT_ENOUGH = "You do not have enough of that type of projectile.";
		SAYTEXT_BUNDLE_DONE = "There you go, all bundled up.";
		SAYTEXT_BUNDLE = "I can tie your arrows and bolts into neat bundles for quicker access, if you have enough to make such bundles. No charge for this.";
		ANIM_DONE = "pull_needle";
		ANIM_NO = "no";
		ANIM_CONVO = "converse1";
	}

	void game_menu_getoptions()
	{
		CUSTOMER_ID = param1;
		if (!(BUNDLE_MENU))
		{
			LOOP_COUNT = 0;
			for (int i = 0; i < GetTokenCount(ARROW_STACK_TYPES, ";"); i++)
			{
				check_arrows();
			}
			LOOP_COUNT = 0;
			for (int i = 0; i < GetTokenCount(ARROW_STACK_TYPES, ";"); i++)
			{
				check_bolts();
			}
			if ((ARROW_MENU))
			{
				string reg.mitem.title = "Bundle Arrows (120)";
				string reg.mitem.type = "callback";
				int reg.mitem.data = 120;
				string reg.mitem.callback = "bundle_arrows_menu";
				string reg.mitem.title = "Bundle Arrows (240)";
				string reg.mitem.type = "callback";
				int reg.mitem.data = 120;
				string reg.mitem.callback = "bundle_arrows_menu";
			}
			if ((BOLT_MENU))
			{
				string reg.mitem.title = "Bundle Bolts (200)";
				string reg.mitem.type = "callback";
				int reg.mitem.data = 200;
				string reg.mitem.callback = "bundle_bolts_menu";
				string reg.mitem.title = "Bundle Bolts (400)";
				string reg.mitem.type = "callback";
				int reg.mitem.data = 400;
				string reg.mitem.callback = "bundle_bolts_menu";
			}
		}
		if (!(BUNDLE_MENU)) return;
		if (BUNDLE_TYPE == "arrows")
		{
			LOOP_COUNT = 0;
			for (int i = 0; i < GetTokenCount(ARROW_STACK_TYPES, ";"); i++)
			{
				add_arrow_options();
			}
		}
		if (BUNDLE_TYPE == "bolts")
		{
			LOOP_COUNT = 0;
			for (int i = 0; i < GetTokenCount(BOLT_STACK_TYPES, ";"); i++)
			{
				add_bolt_options();
			}
		}
	}

	void bundle_arrows_menu()
	{
		BUNDLE_MENU = 1;
		VENDOR_MENU_OFF = 1;
		BUNDLE_AMT = param2;
		BUNDLE_TYPE = "arrows";
		OpenMenu(CUSTOMER_ID);
		PlayAnim("critical", ANIM_CONVO);
		SayText(SAYTEXT_BUNDLE);
	}

	void bundle_bolts_menu()
	{
		BUNDLE_MENU = 1;
		VENDOR_MENU_OFF = 1;
		BUNDLE_AMT = param2;
		BUNDLE_TYPE = "bolts";
		OpenMenu(CUSTOMER_ID);
		PlayAnim("critical", ANIM_CONVO);
		SayText(SAYTEXT_BUNDLE);
	}

	void add_arrow_options()
	{
		string CUR_ITEM = GetToken(ARROW_STACK_TYPES, i, ";");
		string STACK_STRING = CUR_ITEM;
		STACK_STRING += ":";
		STACK_STRING += BUNDLE_AMT;
		string CALLBACK_STRING = "give_bundle_";
		CALLBACK_STRING += CUR_ITEM;
		string TITLE_STRING = "bundle ";
		TITLE_STRING += ItemExists(CUSTOMER_ID, CUR_ITEM);
		TITLE_STRING += "s";
		LogDebug("adding_menu item CUR_ITEM title TITLE_STRING data STACK_STRING callback CALLBACK_STRING");
		if (!(ItemExists(CUSTOMER_ID, CUR_ITEM))) return;
		string reg.mitem.title = TITLE_STRING;
		string reg.mitem.type = "payment";
		string reg.mitem.data = STACK_STRING;
		string reg.mitem.callback = CALLBACK_STRING;
		string reg.mitem.cb_failed = "not_enough_arrows";
	}

	void add_bolt_options()
	{
		LogDebug("iteration game.script.iteration");
		string CUR_ITEM = GetToken(BOLT_STACK_TYPES, LOOP_COUNT, ";");
		LOOP_COUNT += 1;
		string STACK_STRING = CUR_ITEM;
		STACK_STRING += ":";
		STACK_STRING += BUNDLE_AMT;
		string CALLBACK_STRING = "give_bundle_";
		CALLBACK_STRING += CUR_ITEM;
		if (!(ItemExists(CUSTOMER_ID, CUR_ITEM))) return;
		string ITEM_NAME = ItemExists(CUSTOMER_ID, CUR_ITEM);
		string reg.mitem.title = "Bundle ";
		string reg.mitem.type = "payment";
		string reg.mitem.data = STACK_STRING;
		string reg.mitem.callback = CALLBACK_STRING;
		string reg.mitem.cb_failed = "not_enough_arrows";
	}

	void check_arrows()
	{
		string CUR_ITEM = GetToken(ARROW_STACK_TYPES, LOOP_COUNT, ";");
		LOOP_COUNT += 1;
		string ITEM_NAME = ItemExists(CUSTOMER_ID, CUR_ITEM);
		ARROW_MENU = 1;
	}

	void check_bolts()
	{
		string CUR_ITEM = GetToken(ARROW_STACK_TYPES, LOOP_COUNT, ";");
		LOOP_COUNT += 1;
		string ITEM_NAME = ItemExists(CUSTOMER_ID, CUR_ITEM);
		BOLT_MENU = 1;
	}

	void not_enough_arrows()
	{
		PlayAnim("critical", ANIM_NO);
		SayText(SAYTEXT_NOT_ENOUGH);
		BUNDLE_MENU = 0;
		VENDOR_MENU_OFF = 0;
	}

	void give_bundle_proj_arrow_bluntwooden()
	{
		GIVE_ITEM = "proj_arrow_bluntwooden";
		return_bundle();
	}

	void give_bundle_proj_arrow_broadhead()
	{
		GIVE_ITEM = "proj_arrow_broadhead";
		return_bundle();
	}

	void give_bundle_proj_arrow_fire()
	{
		GIVE_ITEM = "proj_arrow_fire";
		return_bundle();
	}

	void give_bundle_proj_arrow_frost()
	{
		GIVE_ITEM = "proj_arrow_frost";
		return_bundle();
	}

	void give_bundle_proj_arrow_gholy()
	{
		GIVE_ITEM = "proj_arrow_gholy";
		return_bundle();
	}

	void give_bundle_proj_arrow_gpoison()
	{
		GIVE_ITEM = "proj_arrow_gpoison";
		return_bundle();
	}

	void give_bundle_proj_arrow_holy()
	{
		GIVE_ITEM = "proj_arrow_holy";
		return_bundle();
	}

	void give_bundle_proj_arrow_jagged()
	{
		GIVE_ITEM = "proj_arrow_jagged";
		return_bundle();
	}

	void give_bundle_proj_arrow_poison()
	{
		GIVE_ITEM = "proj_arrow_poison";
		return_bundle();
	}

	void give_bundle_proj_arrow_silvertipped()
	{
		GIVE_ITEM = "proj_arrow_silvertipped";
		return_bundle();
	}

	void give_bundle_proj_arrow_wooden()
	{
		GIVE_ITEM = "proj_arrow_wooden";
		return_bundle();
	}

	void give_bundle_proj_bolt_fire()
	{
		GIVE_ITEM = "proj_bolt_fire";
		return_bundle();
	}

	void give_bundle_proj_bolt_iron()
	{
		GIVE_ITEM = "proj_bolt_iron";
		return_bundle();
	}

	void give_bundle_proj_bolt_silver()
	{
		GIVE_ITEM = "proj_bolt_silver";
		return_bundle();
	}

	void give_bundle_proj_bolt_steel()
	{
		GIVE_ITEM = "proj_bolt_steel";
		return_bundle();
	}

	void give_bundle_proj_bolt_wooden()
	{
		GIVE_ITEM = "proj_bolt_wooden";
		return_bundle();
	}

	void return_bundle()
	{
		LogDebug("return_bundle");
		string BUNDLE_STRING = GIVE_ITEM;
		BUNDLE_STRING += ":";
		BUNDLE_STRING += BUNDLE_AMT;
		// TODO: offer CUSTOMER_ID BUNDLE_STRING
		PlayAnim("critical", ANIM_DONE);
		SayText(SAYTEXT_BUNDLE_DONE);
		BUNDLE_MENU = 0;
		VENDOR_MENU_OFF = 0;
	}

}

}
