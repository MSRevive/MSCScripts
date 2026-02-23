#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat_array.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Amaex : CGameScript
{
	int SPOKE;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Amaex()
	{
		STORE_NAME = "healer2";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		const int NO_JOB = 1;
		const int NO_HAIL = 1;
		const int XMASS_OLD_GUY = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(25);
		CanSee("player");
		chat_now("Greetings, need healing?", 1.0);
	}

	void OnSpawn() override
	{
		SetName("Amaex the Mage");
		SetHealth(100);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CatchSpeech("say_island", "island");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", 30, 100);
		AddStoreItem(STORE_NAME, "health_lpotion", 30, 100);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORE_NAME, "mana_protection", 2, 150, 0.1);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "health_spotion", 3, 100);
			AddStoreItem(STORE_NAME, "scroll2_fire_dart", 1, 200);
			AddStoreItem(STORE_NAME, "scroll2_lightning_weak", 1, 200);
		}
		AddStoreItem(STORE_NAME, "scroll2_rejuvenate", 1, 400);
		AddStoreItem(STORE_NAME, "item_crystal_return", 1, RandomInt(100, 200), 0.3);
		bs_epic_item();
	}

	void speech_nightmare_thornlands()
	{
		if ((SPOKE)) return;
		chat_now("Hail Adventurer! Welcome to my... eh- failed experiment.", 7, "sound:voices/thornlands_north/amaex1.wav");
		chat_now("I've been attempting to discover a better method of teleportation.", 5, "sound:voices/thornlands_north/amaex2.wav");
		chat_now("It's gone wrong however. And I cannot seem to dispel it.", 5, "sound:voices/thornlands_north/amaex3.wav");
		chat_now("I'll try and tell you to stay away, but I know how you adventurers think.", 6.0, "sound:voices/thornlands_north/amaex4.wav", "open_portal");
		SPOKE = 1;
	}

	void open_portal()
	{
		UseTrigger("Nightmare_Wall");
	}

}

}
