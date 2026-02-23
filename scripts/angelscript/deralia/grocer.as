#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_civilian.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Grocer : CGameScript
{
	int ASKED_APPLE;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;

	Grocer()
	{
		SOUND_IDLE1 = "voices/human/male_idle4.wav";
		SOUND_IDLE2 = "voices/human/male_idle5.wav";
		SOUND_IDLE3 = "voices/human/male_idle6.wav";
		const string SOUND_DEATH = "none";
		STORE_NAME = "deralia_grocer";
		STORE_TRIGGERTEXT = "store";
		const int NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(60);
		CanSee("player");
		SayText("An [apple] a day , keep the man eating giant insects away!");
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
		SayText("Hail traveler. Would you like an [apple] ? They re quite good!");
		ASKED_APPLE = 1;
	}

	void gossip_1()
	{
		SayText("Have you heard about the girls at the house? You look the type.");
	}

	void trade_done()
	{
		SayText("Have a nice day.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", 30, 100);
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Rumors? Well , I have heard about a rash of thievery!");
	}

}

}
