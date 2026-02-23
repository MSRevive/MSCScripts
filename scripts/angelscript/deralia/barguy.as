#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Barguy : CGameScript
{
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CANCHAT;
	string CURRENT_THIEF;
	int HAT_QUEST;
	string QUEST_WINNER;
	int REQ_QUEST_NOTDONE;
	int SAID_HELP;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;

	void OnRepeatTimer()
	{
		SetRepeatDelay(35);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(60);
		SayText("Give me another pint!");
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(30);
		SetName("Mosor");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, 2);
		CANCHAT = 1;
		HAT_QUEST = 0;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.6;
		CURRENT_THIEF = �PNULL�P;
		SOUND_IDLE1 = "voices/human/male_idle4.wav";
		SOUND_IDLE2 = "voices/human/male_idle5.wav";
		SOUND_IDLE3 = "voices/human/male_idle6.wav";
		REQ_QUEST_NOTDONE = 1;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_apple", "apple");
		CatchSpeech("respond_no", "no");
		CatchSpeech("say_job", "help");
		CatchSpeech("say_rumor", "rumours");
	}

	void say_hi()
	{
		SayText("What do you 'ant?");
	}

	void say_rumor()
	{
		SayText("Gossip?");
		if ((REQ_QUEST_NOTDONE))
		{
			ScheduleDelayedEvent(1, "helpeh");
		}
		else
		{
			ScheduleDelayedEvent(1, "say_a_really_important");
		}
	}

	void helpeh()
	{
		if ((SAID_HELP)) return;
		SayText("Bah, away with you, unless you can [help] me!");
		SAID_HELP = 1;
	}

	void respond_no()
	{
		if (!(SAID_HELP)) return;
		SayText("Then begone!");
		SAID_HELP = 0;
		HAT_QUEST = 0;
	}

	void say_job()
	{
		if ((HAT_QUEST)) return;
		PlayAnim("once", "converse1");
		SayText("Well, a few days ago I came home after a night like this, quite... happy.");
		ScheduleDelayedEvent(2, "say_thief2");
	}

	void say_thief2()
	{
		SayText("I walked through the door into my house only to find that everything was missing!");
		ScheduleDelayedEvent(2, "say_thief3");
	}

	void say_thief3()
	{
		SayText("Me gold, me weapons, even me hat! I must have me hat! I don't know what to do!");
		ScheduleDelayedEvent(2, "say_thief4");
	}

	void say_thief4()
	{
		PlayAnim("once", "pondering");
		SayText("Maybe you can get me hat back for me! I'll reward ye! Well!");
		HAT_QUEST = 1;
	}

	void say_a_really_important()
	{
		PlayAnim("once", "pondering");
		SayText("No rumors around here... only truths.");
	}

	void give_hat()
	{
		QUEST_WINNER = param1;
		ReceiveOffer("accept");
		SayText("MY HAT!");
		ScheduleDelayedEvent(5, "hat_2");
	}

	void hat_2()
	{
		SayText("Thank you so much! Heres your reward!");
		// TODO: offer QUEST_WINNER gold 25
		REQ_QUEST_NOTDONE = 0;
	}

	void game_menu_getoptions()
	{
		if (!(REQ_QUEST_NOTDONE)) return;
		if ((ItemExists(param1, "item_hat")))
		{
			string reg.mitem.title = "Return hat";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_hat";
			string reg.mitem.callback = "give_hat";
		}
		if ((HAT_QUEST))
		{
			string reg.mitem.title = "No";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "respond_no";
		}
		else
		{
			if ((SAID_HELP))
			{
				string reg.mitem.title = "Help";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_job";
			}
		}
	}

}

}
