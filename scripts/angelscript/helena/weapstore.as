#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "helena/helena_npc.as"

namespace MS
{

class Weapstore : CGameScript
{
	string OVERCHARGE;
	float SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int VEND_NEWBIE;

	Weapstore()
	{
		SOUND_DEATH = "none";
		STORE_NAME = "helena_weapstore";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.8;
		const int NO_HAIL = 1;
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
		VEND_NEWBIE = 1;
		const int VEND_WEAPONS = 1;
		const int VEND_CONTAINERS = 1;
		const int VEND_ARMORER = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15);
		if ((CanSee("player", 128)))
		{
		}
		SayText("Weapons for sale!");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Weapon Seller");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_store", "buy");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumour", "rumours");
		OVERCHARGE = RandomInt(90, 150);
		SELL_WEAPON_LEVEL = 3;
	}

	void say_hi()
	{
		SayText("Welcome to the best weapon store in town! Supplied by our own blacksmith!");
		ScheduleDelayedEvent(0.8, "say_hi2");
	}

	void say_hi2()
	{
		SayText("He s famous you know! He helped fight off the orcish attacks!");
	}

	void say_job()
	{
		SayText("I am afraid that I do not give out jobs , I am a worker myself.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "smallarms_knife", 4, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 3, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dirk", RandomInt(0, 1), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger2", RandomInt(0, 1), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_rknife", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_rsword", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_scimitar", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_nkatana", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_longsword", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_bastardsword", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", 3, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_2haxe", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_battleaxe", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_club", 1, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer1", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer2", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_mace", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_warhammer", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer3", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_maul", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_greatmaul", 0, OVERCHARGE, 0.5);
		AddStoreItem(STORE_NAME, "swords_katana", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "swords_katana2", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "swords_katana3", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "swords_katana4", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "swords_skullblade", 0, OVERCHARGE, 0.4);
		AddStoreItem(STORE_NAME, "swords_skullblade2", 0, OVERCHARGE, 0.4);
		AddStoreItem(STORE_NAME, "swords_skullblade3", 0, OVERCHARGE, 0.4);
		AddStoreItem(STORE_NAME, "swords_skullblade4", 0, OVERCHARGE, 0.4);
		AddStoreItem(STORE_NAME, "smallarms_fangstooth", 0, OVERCHARGE, 0.5);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger2", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger3", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger4", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife2", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife3", 0, OVERCHARGE, 0.6);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife4", 0, OVERCHARGE, 0.6);
		if (!(RandomInt(1, 3) == 1)) return;
		AddStoreItem(STORE_NAME, "sheath_back_holster", 5, OVERCHARGE, SELL_RATIO);
	}

	void trade_done()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		SayText("Please , do come again some time. Might have something more interesting for you then.");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering2");
		SayText("Don t travel to the west! Dangerous things lurk out there.");
	}

}

}
