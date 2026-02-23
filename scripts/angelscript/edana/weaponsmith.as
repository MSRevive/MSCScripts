#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Weaponsmith : CGameScript
{
	int CIDER;
	float SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int VEND_NEWBIE;

	Weaponsmith()
	{
		SOUND_DEATH = "none";
		STORE_NAME = "edana_kyrthos";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.75;
		SELL_WEAPON_LEVEL = 3;
		VEND_NEWBIE = 1;
		const int VEND_WEAPONS = 1;
		const int VEND_CONTAINERS = 1;
		const int NO_CHAT = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15);
		if ((CanSee("player", 128)))
		{
		}
		SayText("WEAPONS FOR SAAAAALLLLLLLEEEEE!!!!!!");
	}

	void OnSpawn() override
	{
		SetName("krythos");
		SetHealth(25);
		SetGold(50);
		SetName("Krythos the Weaponsmith");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/blacksmith.mdl");
		SetInvincible(true);
		CIDER = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_store", "buy");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_cider", "cider");
		CatchSpeech("say_rumor", "rumours");
	}

	void say_hi()
	{
		SayText("Welcome to my humble shop , I sell all kinds of adventuring stuffs.");
		ScheduleDelayedEvent(0.8, "say_hi2");
	}

	void say_hi2()
	{
		SayText("Can I interest you in anything?");
	}

	void say_job()
	{
		SayText("You don't look like a member of the Merchant's Guild, and I can't afford to hire non-guild workers.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "smallarms_rknife", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dirk", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_stiletto", 0, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "smallarms_stiletto", 1, 100, SELL_RATIO);
		}
		AddStoreItem(STORE_NAME, "swords_rsword", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_scimitar", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_longsword", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_bastardsword", 0, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "swords_bastardsword", 1, 100, SELL_RATIO);
		}
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_2haxe", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_battleaxe", 0, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "axes_battleaxe", 1, 100, SELL_RATIO);
		}
		AddStoreItem(STORE_NAME, "blunt_club", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer1", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer2", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_mace", 2, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_warhammer", 1, 100, SELL_RATIO);
		}
		AddStoreItem(STORE_NAME, "blunt_hammer3", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_maul", 0, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_maul", 1, 100, SELL_RATIO);
		}
		AddStoreItem(STORE_NAME, "polearms_qs", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_sp", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", 2, 100, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_gauntlets_leather", 1, 100, SELL_RATIO);
		}
	}

	void trade_done()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		SayText("Please , do come again some time. Might have something more interesting for you then.");
	}

	void cider4()
	{
		CIDER = 1;
	}

	void say_cider()
	{
		if (!(CIDER == 1)) return;
		PlayAnim("once", "converse2");
		SayText("Ah yes, the shipment was waylaid so I had to arrange another, I've already sent a messenger.");
		ScheduleDelayedEvent(3, "say_cider2");
	}

	void say_cider2()
	{
		SayText("She must have gotten anxious. Sorry for the touble. Head back to her for your reward");
		CIDER = 99;
		CallExternal(FindEntityByName("wench"), "ciderreward");
	}

	void say_rumor()
	{
		PlayAnim("once", "pondering2");
		SayText("Helena is starting to become a fair sized city, their armourer is finally able to make all of his own weapons.");
	}

}

}
