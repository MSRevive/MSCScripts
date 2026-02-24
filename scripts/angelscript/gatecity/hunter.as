#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Hunter : CGameScript
{
	int CANCHAT;
	int JOB;
	int NO_CHAT;
	int NPC_REACTS;
	float SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	int STORE_CLOSED;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int VEND_ARMORER;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Hunter()
	{
		SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		STORE_NAME = "gatecity_huntery";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.75;
		SELL_WEAPON_LEVEL = 3;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
		NO_CHAT = 1;
		NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("Durwyn");
		SetHealth(25);
		SetGold(25);
		SetName("Durwyn the Hunter");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(2, 0);
		JOB = 0;
		CANCHAT = 1;
		STORE_CLOSED = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
		createmystore();
	}

	void npcreact_targetsighted()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist(param1) <= 90)
			{
				SayText("Get your hunting supplies!");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("Would you like a fine bow? Or perhaps a quiver?");
			}
		}
	}

	void say_job()
	{
		SayText(I + "have everything " + I + " need right now.");
	}

	void say_rumor()
	{
		SayText("If you want some information about this area , speak with the miner in the tavern.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "proj_arrow_wooden", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_fire", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_broadhead", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_holy", 60, 200, 0.1, 30);
		silver_tipped();
		AddStoreItem(STORE_NAME, "pack_quiver", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_orcbow", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_treebow", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_shortbow", RandomInt(1, 2), 115, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_sp", RandomInt(0, 2), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_tri", RandomInt(0, 1), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_ratpelt", 0, 130, 1.1);
		AddStoreItem(STORE_NAME, "skin_boar", 0, 130, 1.1);
		AddStoreItem(STORE_NAME, "skin_boar_heavy", 0, 130, 1.1);
		AddStoreItem(STORE_NAME, "skin_bear", 0, 130, 1.1);
		AddStoreItem(STORE_NAME, "proj_bolt_fire", 50, 300, 0, 25);
	}

	void silver_tipped()
	{
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_silvertipped", 300, 135, 0, 30);
		}
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		EmitSound(GetOwner(), CHAN_VOICE, "npc/goods.wav", "game.sound.maxvol");
		Say("[.34] [.24] [.35] [.40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void vendor_say_closed()
	{
		SayText("Sorry , " + I + " m closed. I will reopen at seven in the morning.");
	}

}

}
