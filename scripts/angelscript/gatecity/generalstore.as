#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Generalstore : CGameScript
{
	int CANCHAT;
	int JOB;
	int NO_CHAT;
	int NO_RUMOR;
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

	Generalstore()
	{
		SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		STORE_NAME = "gatecity_generalstore";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.75;
		NO_RUMOR = 1;
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
		SetName("Egmont");
		SetHealth(25);
		SetGold(25);
		SetName("Egmont the Merchant");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 0);
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
				SayText("Fine goods for sale!");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("Can " + I + " get something for you?");
			}
		}
	}

	void say_job()
	{
		SayText("Sorry , " + I + " have no need to hire anyone.");
	}

	void say_rumor()
	{
		SayText(I + " heard a fellow merchant from this city has gone missing.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "smallarms_rknife", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_doubleaxe", 1, 150, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_club", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer1", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(5, 10), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_bigsack", RandomInt(1, 5), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_belt", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_belt_holster", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_dagger", RandomInt(1, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_snakeskin", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_belt_snakeskin", 0, 100, SELL_RATIO);
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
		SayText("Sorry, I'm closed. I will reopen at seven in the morning.");
	}

	void say_containers()
	{
		SayText("Weapon straps hold any type of weapon. Quivers hold amunition. Big sacks hold nearly everything else.");
		SayText("Backpacks can hold nearly anything, useful for more a more generalized inventory.");
		SayText("Spellbooks hold magic scrolls. The small sack can hold most items, but has very little room, so it can't hold much.");
		SayText("I also offer more specialized sheaths, that can only hold specific weapon types.");
		vend_mouth_move();
	}

}

}
