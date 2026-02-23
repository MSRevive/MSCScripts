#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Barkeep : CGameScript
{
	int CANCHAT;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	string TALK_TARGET;

	Barkeep()
	{
		const string SOUND_DEATH = "none";
		STORE_NAME = "deralia_bar";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		CanSee("player");
		SayText("Hello there.");
		Say("*[20] *[20]");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Holten , the Bar Keep");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumour", "rumours");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_hi()
	{
		vendor_used();
	}

	void vendor_used()
	{
		SayText("What brings you here today? Business or pleasure?");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_HELLO);
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "drink_mead", 20, 100);
		AddStoreItem(STORE_NAME, "drink_ale", 20, 100);
		AddStoreItem(STORE_NAME, "drink_wine", 20, 100);
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[34] *[24] *[35] *[40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void say_job()
	{
		SayText("Eh , all staffed here , at the moment... But...");
		ScheduleDelayedEvent(3.0, "say_job2");
	}

	void say_job2()
	{
		if ((IsEntityAlive(param1)))
		{
			TALK_TARGET = param1;
		}
		else
		{
			TALK_TARGET = GetEntityIndex("ent_lastspoke");
		}
		convo_anim();
		SayText("I heard Cathain, the quartermaster, lost a sewer crew a little while ago.");
		ScheduleDelayedEvent(5.0, "say_job3");
	}

	void say_job3()
	{
		convo_anim();
		SayText("Usually when that happens, they send down a crew to find them, or at least clean up the mess.");
		ScheduleDelayedEvent(5.0, "say_job4");
	}

	void say_job4()
	{
		convo_anim();
		if (GetGender(TALK_TARGET) == "male")
		{
			SayText("A big strapping lad like you might fit the bill.");
		}
		else
		{
			SayText("A brave heroine like you might just fit the bill.");
		}
		ScheduleDelayedEvent(5.0, "say_job5");
	}

	void say_job5()
	{
		PlayAnim("critical", "give_shot");
		SayText("You can find Cathain inside the barracks - just left of the castle. Usually pacing a wear in the floor.");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("I ve heard from travelers coming to this tavern, telling about places outside of this village.");
		ScheduleDelayedEvent(3, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("This knight came here the other day , and he spoke of the path to Gatecity being cut off. If that s true, we can t visit the dwarves and elves anymore.");
	}

}

}
