#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Healer02 : CGameScript
{
	int NO_HAIL;
	int NO_JOB;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int XMASS_OLD_GUY;

	Healer02()
	{
		STORE_NAME = "healer2";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		NO_JOB = 1;
		NO_HAIL = 1;
		XMASS_OLD_GUY = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(25);
		CanSee("player");
		SayText("Greetings , need healing?");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Melhar the pure");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CatchSpeech("say_rumour", "rumours");
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

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText(I + "always aggree with Gortigan on this one. Stay " + AWAY + " from the [island] .");
	}

	void say_island()
	{
		PlayAnim("once", "pondering");
		SayText("Yes , the harbour master often takes requests to sail there. Many do not return.");
	}

}

}
