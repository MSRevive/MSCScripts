#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Magicshop : CGameScript
{
	int CANCHAT;
	int JOB;
	int STORE_CLOSED;
	int VEND_ARMORER;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Magicshop()
	{
		const string SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		const string STORE_NAME = "gatecity_magicshop";
		const string STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int STORE_SELLMENU = 1;
		const float SELL_RATIO = 0.75;
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const int NO_HAIL = 1;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
		const int NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("Galan");
		SetHealth(25);
		SetGold(25);
		SetName("Galan the Mage");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
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
				SayText("Can I get you some potions?");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("Would you like a potion or a new spell?");
			}
		}
	}

	void say_job()
	{
		SayText("Until the Undermountains is open again , I have no need to hire you.");
	}

	void say_rumor()
	{
		SayText("Goblins have been hanging around the city lately.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(25, 30), 115, 0.2);
		AddStoreItem(STORE_NAME, "health_lpotion", RandomInt(25, 30), 115, 0.2);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "health_spotion", RandomInt(1, 4), 120, 0.2);
		}
		AddStoreItem(STORE_NAME, "mana_mpotion", RandomInt(5, 10), 120, 0.2);
		AddStoreItem(STORE_NAME, "scroll_fire_dart", RandomInt(1, 3), 135);
		AddStoreItem(STORE_NAME, "scroll_lightning_weak", RandomInt(1, 3), 135);
		AddStoreItem(STORE_NAME, "scroll2_fire_dart", RandomInt(1, 3), 135);
		AddStoreItem(STORE_NAME, "scroll2_lightning_weak", RandomInt(1, 3), 135);
		AddStoreItem(STORE_NAME, "sheath_spellbook", RandomInt(1, 3), 135);
		AddStoreItem(STORE_NAME, "scroll2_glow", RandomInt(1, 2), 200);
		AddStoreItem(STORE_NAME, "scroll_glow", RandomInt(3, 5), 200);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "mana_resist_fire", 1, 150, 0.1);
		}
		else
		{
			if (RandomInt(1, 15) == 1)
			{
				AddStoreItem(STORE_NAME, "mana_resist_cold", 1, 150, 0.1);
			}
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
		SayText("Sorry , I m closed. I will reopen at seven in the morning.");
	}

}

}
