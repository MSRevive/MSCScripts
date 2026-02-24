#pragma context server

#include "help/first_vendor.as"

namespace MS
{

class BaseNpcVendor : CGameScript
{
	string BUSY_COMMENT;
	int HAS_INCLUDE_VENDOR;
	string L_SERVICE;
	string STORE_BUYMENU;
	int STORE_RESTOCK;
	int STORE_RESTOCK_TIME_HI;
	int STORE_RESTOCK_TIME_LO;
	string STORE_TRADEEXT;
	int VENDOR_STORE_ACTIVE;
	string VENDOR_TARGET;
	int VEND_NO_GOODBYE;

	BaseNpcVendor()
	{
		HAS_INCLUDE_VENDOR = 1;
		STORE_RESTOCK = 1;
		STORE_RESTOCK_TIME_LO = 300;
		STORE_RESTOCK_TIME_HI = 600;
		BUSY_COMMENT = "One at a time, please.";
		if (STORE_TRADEEXT == "STORE_TRADEEXT")
		{
			STORE_TRADEEXT = "trade";
		}
		if (STORE_BUYMENU == "STORE_BUYMENU")
		{
			STORE_BUYMENU = 1;
		}
	}

	void OnSpawn() override
	{
		CatchSpeech("npc_say_store", "store");
		ScheduleDelayedEvent(0.1, "vendor_setup_store");
		if (!(GetMonsterProperty("race") == "human")) return;
		SetModelBody(0, 3);
	}

	void vendor_setup_store()
	{
		if ((VEND_INDIVIDUAL)) return;
		NpcStoreCreate(STORE_NAME);
		ScheduleDelayedEvent(1.0, "vendor_addstoreitems");
	}

	void OnSpawn() override
	{
		if (!(GetMonsterProperty("race") == "human")) return;
		SetModelBody(0, 3);
	}

	void game_menu_getoptions()
	{
		vendor_addstoremenu(param1);
	}

	void vendor_addstoremenu()
	{
		if ((VENDOR_MENU_OFF)) return;
		string reg.mitem.id = "genericstore";
		int reg.mitem.priority = -100;
		string reg.mitem.access = "all";
		if (!(STORE_CLOSED))
		{
			if (VEND_CHAT_MODE != "weapons")
			{
			}
			string reg.mitem.title = "Shop";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "vendor_offerstore";
		}
		else
		{
			string reg.mitem.title = "Closed";
			string reg.mitem.type = "disabled";
		}
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		vendor_used();
		if ((VENDOR_NOT_ON_USE)) return;
		vendor_offerstore(GetEntityIndex(m_hLastUsed));
	}

	void npc_say_store()
	{
		vendor_offerstore(GetEntityIndex("ent_lastspoke"));
	}

	void vendor_offerstore()
	{
		LogDebug("vendor_offerstore to GetEntityName(param1)");
		VENDOR_STORE_ACTIVE = 1;
		if (!(STORE_CLOSED))
		{
			VENDOR_TARGET = param1;
			if (VENDOR_DELAY > 0)
			{
				VENDOR_DELAY("basevendor_offerstore");
			}
			else
			{
				basevendor_offerstore();
			}
		}
		else
		{
			vendor_say_closed();
			VENDOR_STORE_ACTIVE = 0;
		}
	}

	void vendor_fail()
	{
		VENDOR_STORE_ACTIVE = 0;
	}

	void basevendor_offerstore()
	{
		if (param1 != "PARAM1")
		{
			VENDOR_TARGET = param1;
		}
		int L_SERVICE = 0;
		if ((STORE_BUYMENU))
		{
			L_SERVICE = "buy";
		}
		if ((STORE_SELLMENU))
		{
			L_SERVICE += ";sell";
		}
		if (SELL_WEAPON_LEVEL > 0)
		{
			SendColoredMessage(VENDOR_TARGET, "This vendor's weapons require proficiency level  " + SELL_WEAPON_LEVEL);
		}
		if (!(VEND_INDIVIDUAL))
		{
			NpcStoreOffer(STORE_NAME, VENDOR_TARGET, L_SERVICE, "trade");
		}
		else
		{
			if (VEND_PREFIX == "VEND_PREFIX")
			{
				VEND_PREFIX = STORE_NAME;
				array<string> ARRAY_STORES;
				LogDebug("basevendor_offerstore initiated array");
			}
			string L_TARGET_STORE = VEND_PREFIX;
			L_TARGET_STORE += GetPlayerAuthId(VENDOR_TARGET);
			if (ArrayFind(ARRAY_STORES, L_TARGET_STORE, 0) > -1)
			{
				LogDebug("basevendor_offerstore setupstore L_TARGET_STORE");
				NpcStoreOffer(L_TARGET_STORE, VENDOR_TARGET, L_SERVICE, "trade");
			}
			else
			{
				ShowHelpTip(VENDOR_TARGET, "generic", "Individualized Store", "This merchant shows a seperate inventory for each player.");
				ARRAY_STORES.insertLast(L_TARGET_STORE);
				STORE_NAME = L_TARGET_STORE;
				NpcStoreCreate(STORE_NAME);
				vendor_addstoreitems();
				NpcStoreOffer(STORE_NAME, VENDOR_TARGET, L_SERVICE, "trade");
			}
		}
	}

	void trade_busy()
	{
		if (!(IsEntityAlive(param1))) return;
		if (!(GetEntityRange(param1) < 256)) return;
		SayText(BUSY_COMMENT);
	}

	void trade_success()
	{
		VENDOR_STORE_ACTIVE = 0;
	}

	void vendor_store_reset()
	{
		NpcStoreRemove(STORE_NAME, "allitems");
		ScheduleDelayedEvent(0.1, "vendor_addstoreitems");
	}

	void vendor_clear()
	{
		NpcStoreRemove(STORE_NAME, "allitems");
	}

	void game_confirm_buy()
	{
		LogDebug("game_confirm_buy id PARAM1 script PARAM2 cost PARAM3 disp PARAM4 stat PARAM5");
		string PLAYER_ID = param1;
		string ITEM_NAME = param2;
		string ITEM_SCRIPT = param3;
		string ITEM_TYPE = param4;
		string ITEM_STAT = "skill.";
		ITEM_STAT += param4;
		SayText(I + "do not think you yet have the skill to use a " + ITEM_NAME + " properly.");
		SayText("You might consider buying one of my other " + ITEM_TYPE + " items instead.");
		VEND_NO_GOODBYE = 1;
		if (SELL_WEAPON_LEVEL > 0)
		{
			if (StringToLower(GetMapName()) != "edana")
			{
			}
			string MSG_TEXT = "This vendor offers weapons requiring levels ";
			MSG_TEXT += SELL_WEAPON_LEVEL;
			SendInfoMsg(param1, "VENDOR LEVEL");
		}
		if ((HAS_BASE_CHAT_INCLUDE))
		{
			bchat_mouth_move();
		}
		if ((HAS_BASE_CHAT_ARRAY_INCLUDE))
		{
			chat_mouth_move();
		}
	}

}

}
