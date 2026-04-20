#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Grocer : CGameScript
{
	int CANCHAT;
	int JOB;
	int NPC_REACTS;
	float SELL_RATIO;
	string SOUND_DEATH;
	int STORE_CLOSED;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Grocer()
	{
		SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		STORE_NAME = "gatecity_grocery";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		SELL_RATIO = 0.75;
		NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("Garin");
		SetHealth(25);
		SetGold(25);
		SetName("Garin the Grocer");
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
				SayText("Fresh fruit!");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("Can " + I + " get you an apple?");
			}
		}
	}

	void say_job()
	{
		SayText("I can't afford to hire any help.");
	}

	void say_rumor()
	{
		SayText("I don't hear too much that goes on around here.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", RandomInt(25, 30), 100);
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
