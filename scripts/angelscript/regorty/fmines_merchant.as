#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_civilian.as"
#include "monsters/base_xmass.as"

namespace MS
{

class FminesMerchant : CGameScript
{
	int ASKED_APPLE;
	int NPC_NO_PLAYER_DMG;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;

	FminesMerchant()
	{
		SOUND_IDLE1 = "voices/human/male_idle4.wav";
		SOUND_IDLE2 = "voices/human/male_idle5.wav";
		SOUND_IDLE3 = "voices/human/male_idle6.wav";
		const string SOUND_DEATH = "none";
		STORE_NAME = "deralia_grocer";
		STORE_TRIGGERTEXT = "store";
		const int NO_JOB = 1;
		NPC_NO_PLAYER_DMG = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(60);
		CanSee("player");
		SayText("These apples are normally only sold to Regorty , but today is your lucky day!");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetMaxHealth(1);
		SetGold(30);
		SetName("Friendly grocer");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetModelBody(1, 3);
		SetRoam(false);
		SetModel("npc/human1.mdl");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_apple", "apple");
		CatchSpeech("say_rumour", "rumours");
		ScheduleDelayedEvent(10, "idle");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void idle()
	{
		SetRepeatDelay(35);
		SetVolume(3);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void say_hi()
	{
		SayText("Hey there buddy , I got something to help take the edge off.");
		ASKED_APPLE = 1;
	}

	void gossip_1()
	{
		SayText("I heard that there are going to be more variety of apples coming soon.");
	}

	void trade_done()
	{
		SayText("Enjoy and praise the Apple Lord!");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", 420, 100);
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Regorty loves us this I know , for the apples tell me so.");
	}

	void OnDamage(int damage) override
	{
		if ((NPC_NO_PLAYER_DMG))
		{
			if ((IsValidPlayer(param1)))
			{
			}
			SetDamage("dmg");
			SetDamage("hit");
			ReturnData(0);
		}
	}

}

}
