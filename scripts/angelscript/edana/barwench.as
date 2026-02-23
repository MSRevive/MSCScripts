#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Barwench : CGameScript
{
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CANCHAT;
	int CIDER_DONE;
	int CIDER_FINISHED;
	string GAVE_SOUP_LIST;
	string GAVE_SOUP_LIST2;
	string NEXT_THANK_YOU;
	string STORE_NAME;
	string STORE_SOUND;
	string STORE_TRIGGERTEXT;
	int VENDOR_NOT_ON_USE;
	int cider_1;
	int cider_2;
	int cider_3;

	Barwench()
	{
		GAVE_SOUP_LIST = "";
		GAVE_SOUP_LIST2 = "";
		const string SOUND_DEATH = "none";
		const float VENDOR_DELAY = 0.5;
		STORE_NAME = "edana_barwench";
		STORE_SOUND = "voices/female_vendor2";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int NO_HAIL = 1;
		const int VEND_INDIVIDUAL = 1;
		VENDOR_NOT_ON_USE = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(30, 45));
		if ((CanSee("player", 128)))
		{
		}
		SayText("Hello there.");
		Say("[.2] [.2] [.1]");
		SetMoveDest(m_hLastSeen);
		convo_anim();
	}

	void OnSpawn() override
	{
		SetName("wench");
		SetHealth(25);
		SetGold(25);
		SetName("Sylphiel , the waitress");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human2.mdl");
		SetInvincible(true);
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.6;
		cider_1 = 0;
		cider_2 = 0;
		cider_3 = 0;
		CatchSpeech("say_job", "job");
		CatchSpeech("say_wench", "wench");
		CatchSpeech("say_cider", "cider");
		CatchSpeech("say_reward", "cider");
		CatchSpeech("say_rumor", "rumours");
	}

	void vendor_used()
	{
		EmitSound(GetOwner(), 0, "voices/human/female_vendor2.wav", 10);
		SayText("What brings you here today? Business or pleasure?");
		Say("[.3] [.3] [.3] [.2] [.1] [.3] [.1]");
		convo_anim();
		SetMoveDest(param1);
		string L_GOT_SOUP = GetPlayerQuestData(VENDOR_TARGET, "sy");
		if (!(L_GOT_SOUP > 0)) return;
		if (FindToken(GAVE_SOUP_LIST, L_PLR_STEAMID, ";") > -1)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAVE_SOUP_LIST.length() > 0) GAVE_SOUP_LIST += ";";
		GAVE_SOUP_LIST += L_PLR_STEAMID;
		bchat_mouth_move(4.0);
		SayText("Oh hi there. I remember you. Come for some of Sylphee s soup? It s not cheap - no more free samples!");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "drink_mead", 20, 100);
		AddStoreItem(STORE_NAME, "drink_ale", 20, 100);
		AddStoreItem(STORE_NAME, "drink_wine", 20, 100);
		string L_PLR_STEAMID = GetPlayerAuthId(VENDOR_TARGET);
		string L_GOT_SOUP = GetPlayerQuestData(VENDOR_TARGET, "sy");
		if (!(L_GOT_SOUP > 0)) return;
		if (L_GOT_SOUP > 5)
		{
			int L_GOT_SOUP = 5;
		}
		AddStoreItem(STORE_NAME, "mana_soup", L_GOT_SOUP, 100);
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.34] [.24] [.35] [.40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void say_job()
	{
		if (!(cider_1 == 0)) return;
		if (!(CanSee("player", 128))) return;
		SetMoveDest(m_hLastSeen);
		SayText("I have a task for you , now that you ask. Head across the way to Bryan and check on my cider shipment.");
		PlayAnim("once", "pondering3");
		CallExternal(FindEntityByName("bryan"), "cider");
		stoproam();
		ScheduleDelayedEvent(4, "reset");
	}

	void reset()
	{
		cider_1 = 1;
	}

	void say_job()
	{
		if (!(cider_1 == 1)) return;
		SayText("Didn t I ask you to check with Bryan on that cider shipment? Get on with it then!");
		SetMoveDest("ent_lastspoke");
		PlayAnim("once", "converse1");
		stoproam();
		ScheduleDelayedEvent(2, "stop_converse_anim");
	}

	void say_cider()
	{
		if (!(cider_1 == 1)) return;
		SayText("Didn t I ask you to check with Bryan on that cider shipment? Get on with it then!");
		SetMoveDest("ent_lastspoke");
		PlayAnim("once", "converse1");
		stoproam();
		ScheduleDelayedEvent(2, "stop_converse_anim");
	}

	void stop_converse_anim()
	{
		PlayAnim("critical", "idle1");
	}

	void cider2()
	{
		cider_1 = 2;
		cider_2 = 1;
	}

	void cider3()
	{
		cider_1 = 3;
	}

	void say_cider()
	{
		if (!(cider_1 == 3)) return;
		SetMoveDest("ent_lastspoke");
		PlayAnim("once", "converse1");
		SayText("Look , I still haven t gotten that cider shipment, maybe you should check with Bryan again.");
		cider_1 = 1;
		CallExternal(FindEntityByName("bryan"), "cider3");
		stoproam();
	}

	void say_cider()
	{
		say_reward();
	}

	void ciderreward()
	{
		cider_2 = 3;
		cider_1 = 4;
	}

	void say_reward()
	{
		if (!(cider_2 == 1)) return;
		SayText("Thanks for the help.");
		SetRoam(false);
		SetMoveDest("ent_lastspoke");
		PlayAnim("once", "converse1");
		ScheduleDelayedEvent(2, "say_reward2");
		stoproam();
	}

	void say_reward2()
	{
		SayText("Come back in a bit and I ll have some cider for ya.  Just ask when you come in next.");
		ScheduleDelayedEvent(3, "say_reward3");
	}

	void say_reward3()
	{
		if ((CIDER_DONE)) return;
		CIDER_DONE = 1;
		SayText("Here s something for helpin out.");
		ScheduleDelayedEvent(2, "cider3");
		// TODO: offer ent_lastspoke gold 5
		cider_1 = 99;
		cider_2 = 2;
		PlayAnim("critical", "pull_needle");
	}

	void say_reward()
	{
		if (!(cider_2 == 3)) return;
		if (!(cider_3 == 0)) return;
		cider_3 = 1;
		SayText("Well , you ve done more than your share. Seeing as how I don t have any cider to give you...");
		SetRoam(false);
		SetMoveDest("ent_lastspoke");
		PlayAnim("once", "converse1");
		stoproam();
		ScheduleDelayedEvent(3, "say_reward2_1");
	}

	void say_reward2_1()
	{
		SayText("...this ll have to do.  Take this with my thanks.");
		PlayAnim("critical", "pull_needle");
		ScheduleDelayedEvent(2, "say_reward2_2");
	}

	void say_reward2_2()
	{
		if ((CIDER_FINISHED)) return;
		CIDER_FINISHED = 1;
		cider_1 = 99;
		cider_2 = 99;
		// TODO: offer ent_lastspoke gold 7
	}

	void say_rumor()
	{
		if (param1 == "PARAM1")
		{
			if (GetEntityRange("ent_lastspoke") > 128)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayAnim("once", "pondering");
		SayText("I ve heard from travelers coming to this tavern, telling about places outside of this village.");
		ScheduleDelayedEvent(3, "say_rumour2");
	}

	void say_rumour2()
	{
		SayText("This knight came here the other day , and he spoke of the path to Gatecity being cut off.");
		ScheduleDelayedEvent(3, "say_rumour3");
	}

	void say_rumour3()
	{
		SayText("If that s true, we can t go and see the dwarves or elves anymore.");
	}

	void game_gave_player()
	{
		if (!((GetEntityProperty(param2, "itemname")).findFirst("soup") >= 0)) return;
		if (!(GetGameTime() > NEXT_THANK_YOU)) return;
		NEXT_THANK_YOU = GetGameTime();
		NEXT_THANK_YOU += 60.0;
		SayText("Thanks again for helping out with those goblins at gran s old place. Come by again sometime!");
		Say("[.3] [.3] [.3] [.2] [.1] [.3] [.1]");
		convo_anim();
	}

}

}
