#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Healer : CGameScript
{
	string CURRENT_THIEF;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Healer()
	{
		STORE_NAME = "healer1";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		const int NO_HAIL = 1;
		const int NO_JOB = 1;
		const int XMASS_OLD_GUY = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(25);
		CanSee("player");
		SayText("Greetings , may I be of some aid?");
	}

	void OnSpawn() override
	{
		SetHealth(60);
		SetMaxHealth(60);
		SetGold(0);
		SetName("Gortigan the wise");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CURRENT_THIEF = �PNULL�P;
		CatchSpeech("say_rumour", "rumours");
		CatchSpeech("say_island", "island");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", 30, 100);
		AddStoreItem(STORE_NAME, "health_lpotion", 30, 100);
		AddStoreItem(STORE_NAME, "scroll2_glow", 2, 150);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "health_spotion", 3, 100);
		}
		bs_epic_item();
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Be wary adventurer , not everything can be conquered. Such as the cursed [island] .");
	}

	void say_island()
	{
		PlayAnim("once", "pondering");
		SayText("Yes , the harbour master often takes requests to sail there. Many do not return.");
	}

}

}
