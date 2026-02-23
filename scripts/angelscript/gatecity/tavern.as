#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Tavern : CGameScript
{
	int CANCHAT;
	int JOB;
	int STORE_CLOSED;
	string STORE_TRIGGERTEXT;

	Tavern()
	{
		const string SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		const string STORE_NAME = "gatecity_tavern";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int STORE_SELLMENU = 1;
		const float SELL_RATIO = 0.75;
		const int NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("Stein");
		SetHealth(25);
		SetGold(25);
		SetName("Stein the Barkeep");
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
				SayText("Care for a sip of ale?");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("What can I get fer you?");
			}
		}
	}

	void say_job()
	{
		SayText("I have all the help I could use now.");
	}

	void say_rumor()
	{
		SayText("Kendra has been upset recently. Maybe you can cheer her up?");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", RandomInt(12, 15), 100);
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(3, 5), 115);
		AddStoreItem(STORE_NAME, "drink_mead", RandomInt(15, 20), 100);
		AddStoreItem(STORE_NAME, "drink_ale", RandomInt(15, 20), 100);
		AddStoreItem(STORE_NAME, "drink_wine", RandomInt(7, 10), 300);
		if (!(RandomInt(1, 5) == 1)) return;
		AddStoreItem(STORE_NAME, "drink_forsuth", RandomInt(1, 2), 300);
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
