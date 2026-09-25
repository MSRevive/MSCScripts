#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Innkeeper : CGameScript
{
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int BUSY_CHATTING;
	int CANCHAT;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	int SAID_WELCOME;
	string SOUND_HELLO;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	string TALK_TARGET;

	Innkeeper()
	{
		SOUND_HELLO = "npc/hello1.wav";
		STORE_NAME = "deralia_bar";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2);
		if (CANCHAT != 0)
		{
		}
		CanSee("player");
		say_hi();
		ScheduleDelayedEvent(20, "chatreset");
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetMaxHealth(25);
		SetGold(26);
		SetName("Gerald the Inn Keeper");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 1);
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.6;
		resetchat();
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumour", "news");
		CatchSpeech("say_sewer", "sewer");
		CatchSpeech("say_rudolf", "rudolf");
	}

	void say_rudolf()
	{
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Rudolf? What do you want with him?";
		CHAT_STEP2 = "He came in here a couple nights ago before leaving the city.";
		CHAT_STEP3 = "Said something about finding riches in an abandoned mine.";
		CHAT_STEP4 = "The fool has more rocks in his head than in that mine.";
		chat_loop();
		SetGlobalVar("RudolfQuest", 1);
	}

	void say_rumor()
	{
		say_rumour();
	}

	void chatreset()
	{
		CANCHAT = 1;
	}

	void say_hi()
	{
		if ((SAID_WELCOME)) return;
		PlayAnim("once", "studycart");
		SayText("Welcome to Deralia Inn!");
		ScheduleDelayedEvent(2, "say_hi_2");
		CANCHAT = 0;
	}

	void say_hi_2()
	{
		SayText("Finest booze and most comfortable lodging this side of Daragoth!");
		SAID_WELCOME = 1;
	}

	void game_recvoffer_gold()
	{
		recv_moregold();
		recv_enoughgold();
		recv_notenoughgold();
	}

	void recv_moregold()
	{
		if (!(OFFER_AMT > 5)) return;
		ReceiveOffer("accept");
		SayText("That be some good gold there.");
		UseTrigger("door01");
		PlayAnim("once", "yes");
	}

	void recv_enoughgold()
	{
		if (!(OFFER_AMT == 5)) return;
		ReceiveOffer("accept");
		SayText("Best be quick , the doors open and there s lots of people wanting a room.");
		UseTrigger("door01");
		PlayAnim("once", "yes");
	}

	void recv_notenoughgold()
	{
		if (!(OFFER_AMT < 5)) return;
		ReceiveOffer("reject");
		SayText("This isn t charity boy, it s an Inn.");
		PlayAnim("once", "no");
	}

	void robbed()
	{
		SayText("Bastard! Thief!");
		PlayAnim("once", "beatdoor");
	}

	void attack_1()
	{
		DoDamage("ent_laststole", ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void say_job()
	{
		SayText(I + " ve got Bob the door guard, but he s a little afraid of rats. And my basement is full of them.");
		SayText("If you could clear the place up , it would be greatly appreciated and you can stay the night.");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Rumour has it that this place has rooms real cheap , get my drift?");
		PlayAnim("once", "pondering");
		SayText(I + " ve heard from travelers coming to this tavern, telling about places outside of this village.");
		ScheduleDelayedEvent(3, "say_rumour2");
	}

	void vendor_used()
	{
		SayText("Careful! This isn t that watered down stuff you boys drink in Edana!");
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

	void say_sewer()
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
		SayText("Well , if hunting rats is beneath you...");
		ScheduleDelayedEvent(3.0, "say_job2");
	}

	void say_job2()
	{
		convo_anim();
		SayText("I heard Cathain, the quartermaster, lost a sewer crew a little while ago.");
		ScheduleDelayedEvent(5.0, "say_job3");
	}

	void say_job3()
	{
		convo_anim();
		SayText("Usually when that happens, they send militiamen to find them, or at least clean up the mess.");
		ScheduleDelayedEvent(5.0, "say_job4");
	}

	void say_job4()
	{
		convo_anim();
		if (GetGender(TALK_TARGET) == "male")
		{
			SayText("A big strapping lad like yourself might fit the bill.");
		}
		else
		{
			SayText("A brave heroine like yourself might just fit the bill.");
		}
		ScheduleDelayedEvent(5.0, "say_job5");
	}

	void say_job5()
	{
		PlayAnim("critical", "give_shot");
		SayText("You can find Cathain inside the barracks - just left of the castle. Usually pacing a wear in the floor.");
	}

	void say_rumour2()
	{
		SayText("This knight came here the other day , and he spoke of the path to Gatecity being cut off. If that s true, we can t visit the dwarves and elves anymore.");
	}

	void bchat_after_menus()
	{
		string reg.mitem.title = "Sewer Job";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_sewer";
	}

}

}
