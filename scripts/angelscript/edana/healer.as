#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Healer : CGameScript
{
	int EVIDENCE_FOUND;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Healer()
	{
		const string SOUND_DEATH = "none";
		STORE_NAME = "edana_healer";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		EVIDENCE_FOUND = 0;
		const int NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(25);
		if ((CanSee("player", 256)))
		{
		}
		SayText("Puh-potions! I-I got potions!");
	}

	void OnSpawn() override
	{
		SetHealth(60);
		SetGold(0);
		SetName("Hartold the Mage");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_rumor", "rumours");
	}

	void game_targeted_by_player()
	{
		help_vendor_magic(param1);
	}

	void say_hi()
	{
		SayText("He- He- Howdy! How about so-some po- , po- , po- , healing items?");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", 30, 100, 0.1);
		AddStoreItem(STORE_NAME, "health_lpotion", 30, 110, 0.1);
		AddStoreItem(STORE_NAME, "scroll_fire_dart", RandomInt(0, 1), 120);
		AddStoreItem(STORE_NAME, "scroll_lightning_weak", RandomInt(0, 1), 120);
		AddStoreItem(STORE_NAME, "scroll2_glow", 1, 120);
		AddStoreItem(STORE_NAME, "mana_mpotion", 5, 105, 0.1);
		AddStoreItem(STORE_NAME, "scroll_rejuvenate", 1, 200, 0.1);
		AddStoreItem(STORE_NAME, "scroll2_rejuvenate", 1, 800, 0.1);
		AddStoreItem(STORE_NAME, "sheath_spellbook", RandomInt(1, 2), 100, 0.1);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "health_spotion", RandomInt(1, 4), 100);
		}
	}

	void say_rumor()
	{
		PlayAnim("once", "pondering");
		ScheduleDelayedEvent(1.5, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("I h-hear the fletcher will buy hawk f-feathers at a very high price.");
		ScheduleDelayedEvent(3, "say_rumour3");
	}

	void say_rumour3()
	{
		if (!(EVIDENCE_FOUND == 1)) return;
		SayText("Oh! A-and the may-o-r has be-en found a trai-tor!");
	}

	void worldevent_evidence_found()
	{
		EVIDENCE_FOUND = 1;
	}

}

}
