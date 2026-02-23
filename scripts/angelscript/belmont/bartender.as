#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Bartender : CGameScript
{
	string BAR_ID;
	string MY_SAVIOR;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int QUESTS_ACTIVE;
	int SKEL_RESPAWN_TIMES;

	Bartender()
	{
		const string SOUND_DEATH = "xxx";
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("bartender");
		SetHealth(30);
		SetInvincible(true);
		SetName("Helga , The Barkeep");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetModel("npc/human1.mdl");
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
		SetSayTextRange(1024);
		SetModelBody(0, 4);
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
		CatchSpeech("say_hi", "hi");
		ScheduleDelayedEvent(2.0, "get_extorter_id");
	}

	void get_extorter_id()
	{
		BAR_ID = FindEntityByName("extorter");
	}

	void say_hi()
	{
		if (!(QUESTS_ACTIVE)) return;
		convo_anim();
		SayText("I m glad you saved me and all, but he has a lot of nasty friends who will follow.");
		ScheduleDelayedEvent(3.0, "say_hi2");
	}

	void say_hi2()
	{
		convo_anim();
		SayText("I d just get up and leave here, but they have all my money.");
		ScheduleDelayedEvent(3.0, "say_hi2b");
	}

	void say_hi2b()
	{
		SayText("It was all sealed in a magic coffer. I doubt they ll be able to open it anytime soon. But so long as they have it, I can t go anywhere.");
		ScheduleDelayedEvent(3.0, "say_hi3");
	}

	void say_hi3()
	{
		convo_anim();
		SayText("If you could get it back for me , I d be sure to give you a handsom portion before I run off to Deralia!");
	}

	void ext_harass1()
	{
		SayText("For the last time , I told you , we don t have that kind of money. You already took everything we had!");
		PlayAnim("critical", "converse1");
	}

	void ext_harass2()
	{
		SayText("How could we possibly have made the money with your thugs scaring away all the customers?");
		PlayAnim("critical", "converse2");
	}

	void ext_harass3()
	{
		SayText("NO! PLEASE DON T!!!");
		PlayAnim("critical", "fear");
	}

	void npc_suicide()
	{
		if (param1 == "no_pets")
		{
			if ((I_R_PET))
			{
			}
			int EXIT_SUB = 1;
		}
		if (param1 == "only_bad")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "hguard")
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetInvincible(false);
		SetRace("hated");
		SKEL_RESPAWN_TIMES = 99;
		DoDamage(GetOwner(), "direct", 30000, 100, GAME_MASTER);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		PlayAnim("critical", "diesimple");
		EmitSound(GetOwner(), 0, SOUND_DEATH, 10);
	}

	void extorter_slain()
	{
		MY_SAVIOR = GetEntityIndex(param1);
		SayText("Thank Felewyn! You ve saved my life!");
		QUESTS_ACTIVE = 1;
		NO_JOB = 0;
	}

	void say_job()
	{
		say_hi();
	}

	void game_menu_getoptions()
	{
		if (!(ItemExists(param1, "item_bar_coffer"))) return;
		string reg.mitem.title = "Return Coffer";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "item_bar_coffer";
		string reg.mitem.callback = "return_coffer";
	}

	void return_coffer()
	{
		SayText("Thank you so very much! Now maybe I can setup some place more reputable...");
		UseTrigger("coffer_returned");
		// TODO: offer PARAM1 gold 200
		ScheduleDelayedEvent(3.0, "next_quest");
	}

	void next_quest()
	{
		SayText("[Insert text for next quest here].");
	}

}

}
