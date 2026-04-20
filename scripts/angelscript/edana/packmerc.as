#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Packmerc : CGameScript
{
	string AD_TEXT;
	int CANCHAT;
	int CHAT_GOODS;
	int CHAT_JOB;
	int NO_CHAT;
	float SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Packmerc()
	{
		SOUND_DEATH = "none";
		STORE_NAME = "foglund_shop";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.75;
		SELL_WEAPON_LEVEL = 0;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		NO_CHAT = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if ((CANCHAT))
		{
		}
		if ((CanSee("player", 128)))
		{
		}
		SayText(AD_TEXT);
		Say("[.6] [.6] [.6]");
		no_chat();
		ScheduleDelayedEvent(90, "reset_chat");
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(25);
		SetName("Foglund the Merchant");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 2);
		SetInvincible(true);
		CHAT_JOB = 0;
		CHAT_GOODS = 0;
		CANCHAT = 1;
		if (GetMapName() != "lowlands")
		{
			AD_TEXT = "Backpacks! Sheaths! Torches!";
		}
		if (GetMapName() == "lowlands")
		{
			AD_TEXT = "I do hope you can help me with my little bear problem...";
		}
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_store", "buy");
		CatchSpeech("say_rumour", "heard");
		CatchSpeech("say_job", "work");
		CatchSpeech("say_bear", "bear");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_bear()
	{
		SayText("I hate bears, I really do, I've an insatiable desire to buy bear parts. Got any?");
		ScheduleDelayedEvent(4.0, "say_bear2");
	}

	void say_bear2()
	{
		if (!(GetMapName() == "lowlands")) return;
		SayText("Granted, I suspect this has gotten me into a bit of trouble.");
		ScheduleDelayedEvent(4.0, "say_bear3");
	}

	void say_bear3()
	{
		SayText("It is said if you kill 100 bears, the Curse of the Bear Gods will befall you.");
		ScheduleDelayedEvent(4.0, "say_bear4");
	}

	void say_bear4()
	{
		SayText("Looks as though it has befallen me... I can't get outside.");
		ScheduleDelayedEvent(4.0, "say_bear5");
	}

	void say_bear5()
	{
		SayText("I've no clue how I'm going to get back to Edana.");
		ScheduleDelayedEvent(4.0, "say_bear6");
	}

	void say_bear6()
	{
		SayText("I'll give you access to my special stock, if you think you can break this curse!");
	}

	void say_hi()
	{
		SayText("Hello , " + I + " have many things that you will need!");
		ScheduleDelayedEvent(2, "say_store");
		no_chat();
	}

	void no_chat()
	{
		CANCHAT = 0;
		ScheduleDelayedEvent(20, "reset_chat");
	}

	void reset_chat()
	{
		CANCHAT = 1;
	}

	void vendor_addstoreitems()
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "lowlands")
		{
			AddStoreItem(STORE_NAME, "item_crystal_reloc", 1, 300, 0.1);
			AddStoreItem(STORE_NAME, "item_crystal_return", 1, 300, 0.1);
			AddStoreItem(STORE_NAME, "sheath_spellbook", 1, 80, SELL_RATIO);
			AddStoreItem(STORE_NAME, "skin_bear", 20, 100, 0.9);
			AddStoreItem(STORE_NAME, "health_spotion", 10, 80, 0.5);
			AddStoreItem(STORE_NAME, "mana_protection", 1, RandomInt(100, 150), 0.2);
		}
		if (L_MAP_NAME != "lowlands")
		{
			AddStoreItem(STORE_NAME, "skin_bear", 0, 100, 2.0);
		}
		AddStoreItem(STORE_NAME, "item_bearclaw", 0, 100, 0.9);
		AddStoreItem(STORE_NAME, "swords_rsword", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_rknife", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_treebow", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer1", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_qs", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(5, 10), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_bigsack", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", RandomInt(1, 4), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_club", 0, 100, SELL_RATIO);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_club", 1, 100, SELL_RATIO);
		}
	}

	void trade_success()
	{
		if (!(CHAT_GOODS)) return;
		Say("goods[.34] [.24] [.35] [.40]");
		no_chat();
		CHAT_GOODS = 0;
		ScheduleDelayedEvent(6, "reset_chat_goods");
	}

	void reset_chat_goods()
	{
		CHAT_GOODS = 1;
	}

	void say_job()
	{
		SayText("Well I'm just a small shop owner with no need for help, maybe Ike could help ye out?");
		Say("[.5] [.4] [.2] [.1] [.4] [.4] [.2] [.2] [.4] [.1][.2] [.2] [.8] [.2] [.2] [.4] [.6] [.4] [.2]");
		no_chat();
		ScheduleDelayedEvent(15, "reset_chat_job");
	}

	void reset_chat_job()
	{
		CHAT_JOB = 1;
	}

	void say_rumour()
	{
		no_chat();
		PlayAnim("once", "no");
		SayText("I don't know much. Speak to Krythos. He've been all over the world.");
		Say("[.2] [.2] [.2] [.5] [.3] [.1] [.15] [.6] [.4] [.4][.2] [.2] [.2] [.3] [1]");
	}

}

}
