#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Msqguard : CGameScript
{
	int DID_TAUNT;
	int NO_TALK;
	int QUEST_1;
	string QUEST_WINNER;
	string SOUND_HAIL;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	int THIEF_QUEST;
	int THIEF_QUEST_DONE;

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (NO_TALK == 0)
		{
		}
		CanSee("player");
		if (!(DID_TAUNT))
		{
		}
		DID_TAUNT = 1;
		ScheduleDelayedEvent(120.0, "taunt_reset");
		SayText("Why are you sneaking around here? Go around to the entrance if you wish to enter the merchant's square.");
	}

	void OnSpawn() override
	{
		SetHealth(100);
		SetMaxHealth(100);
		SetGold(0);
		SetName("Tristan");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetInvincible(true);
		NO_TALK = 0;
		QUEST_1 = 0;
		THIEF_QUEST = 2;
		SOUND_HAIL = "voices/human/male_hail_guard.wav";
		SOUND_IDLE2 = "voices/human/male_idle7.wav";
		SOUND_IDLE3 = "voices/human/male_idle8.wav";
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_mayor", "mayor");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_job", "work");
		CatchSpeech("say_job", "money");
		CatchSpeech("say_job", "gold");
		CatchSpeech("say_thief", "thief");
		CatchSpeech("say_thief", "thieves");
		CatchSpeech("say_thief", "bandit");
		CatchSpeech("say_thief", "cutpurse");
		CatchSpeech("say_thief", "poacher");
		ScheduleDelayedEvent(5, "idle");
	}

	void idle()
	{
		SetRepeatDelay(35);
		SetVolume(2);
		// PlayRandomSound from: SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void say_hi()
	{
		SetVolume(7);
		EmitSound(GetOwner(), SOUND_HAIL);
		SayText("I'm on duty, but go ahead.");
	}

	void say_mayor()
	{
		if (!(QUEST_1 == 2)) return;
		SayText("Thanks for helping us out.");
		PlayAnim("once", "yes");
	}

	void say_mayor()
	{
		if (!(QUEST_1 == 0)) return;
		SayText("I know that old man is up to something...");
		PlayAnim("once", "no");
		ScheduleDelayedEvent(5, "say_mayor2");
	}

	void say_mayor2()
	{
		SayText("Fetch me evidence that he is a traitor, and I will give you a little something.");
		PlayAnim("once", "no");
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_letter_mayor")))
		{
			string reg.mitem.title = "Present Evidence";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_letter_mayor";
			string reg.mitem.callback = "got_letter";
		}
		if ((ItemExists(param1, "item_thiefmap")))
		{
			string reg.mitem.title = "Give Thief Map";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_thiefmap";
			string reg.mitem.callback = "got_theif_map";
		}
		if (THIEF_QUEST == 2)
		{
			string reg.mitem.title = "Ask about thieves";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_thief";
		}
	}

	void got_letter()
	{
		QUEST_WINNER = param1;
		ReceiveOffer("accept");
		SayText("Thank you! Thank you very much. At last we can get that scumbag out of the way.");
		UseTrigger("evidence_found");
		QUEST_1 = 2;
		ScheduleDelayedEvent(6, "recvletter_2");
	}

	void got_theif_map()
	{
		QUEST_WINNER = param1;
		THIEF_QUEST_DONE = 1;
		ReceiveOffer("accept");
		PlayAnim("once", "return_needle");
		SayText("Ah, what's this? A map of the thieves whereabouts? You have done well, my friend.");
		ScheduleDelayedEvent(4, "say_thiefloc");
	}

	void recvletter_2()
	{
		SayText("Here, I found it on a dead body. Supposedly it's answers to some riddles. Perhaps you should keep it safe. Might be valueable to you some day.");
		// TODO: offer QUEST_WINNER item_riddleanswers
		UseTrigger("evidence_found");
	}

	void taunt_reset()
	{
		DID_TAUNT = 0;
	}

	void say_nothing()
	{
		NO_TALK = 1;
		ScheduleDelayedEvent(9, "say_something");
	}

	void say_something()
	{
		NO_TALK = 0;
	}

	void game_recvoffer_gold()
	{
		ReceiveOffer("reject");
		SayText("A bribe?? I should expect more upstanding behavior than that , citizen.");
		PlayAnim("once", "no");
	}

	void say_job()
	{
		SayText("Hmmmmm... I just recently got hired and I don't think they need another guard.");
		PlayAnim("once", "shrug");
	}

	void say_thief()
	{
		if (!(THIEF_QUEST == 2)) return;
		THIEF_QUEST = 3;
		Say("suspicious");
		SayText("If you see anything suspicious around here , you let me know.");
	}

	void say_thief()
	{
		if (!(THIEF_QUEST == 3)) return;
		THIEF_QUEST = 6;
		SayText("If you see any thieves , try bribing them for information , or give threats that I will lock them up for good.");
		ScheduleDelayedEvent(4, "say_thief2");
	}

	void say_thief2()
	{
		SayText("Aye , I will have them thieves locked up , if not killed should I get my hands on them.");
	}

	void say_thiefloc()
	{
		SayText("Hmmmm... this map shows bandits in a few of the local areas , one being in the Thornlands.");
		ScheduleDelayedEvent(4, "say_thiefloc2");
	}

	void say_thiefloc2()
	{
		SayText("There will probably be thieves around the area. If not , look in the caves near the road to Edana or Helena.");
		ScheduleDelayedEvent(4, "say_thiefloc3");
	}

	void say_thiefloc3()
	{
		SayText("Bring me proof that you ve killed them and I ll reward you , if killing them is not reward enough.");
		ScheduleDelayedEvent(4, "say_thiefloc4");
	}

	void say_thiefloc4()
	{
		SetVolume(8);
		Say("guardwarn");
		string QUEST_WINNER_NAME = GetEntityName(QUEST_WINNER);
		QUEST_WINNER_NAME += ",";
		SayText("Here's some incentive. Be wary, QUEST_WINNER_NAME it is dangerous outside.");
		// TODO: offer QUEST_WINNER gold 30
	}

	void say_rumor()
	{
		say_mayor();
	}

}

}
