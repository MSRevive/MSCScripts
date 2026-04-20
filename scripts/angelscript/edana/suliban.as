#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Suliban : CGameScript
{
	int ATTACK1_DAMAGE;
	int ATTACK_RANGE;
	int BRIBED;
	int CAN_BRIBE;
	int EVIDENCE_FOUND;
	int NO_RUMOR;

	Suliban()
	{
		NO_RUMOR = 1;
		// TODO: UNCONVERTED: say_mayor2
		SayText("Try not to kill him , will you? Would rather spare the bloodshed in town. He is human afterall. Try talking him out of it instead. ... That s all I know...");
		PlayAnim("once", "talkright");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(20);
		CanSee("player");
		if (BRIBED == 0)
		{
		}
		SayText("Stop pestering me. " + I + " ve got no time for the likes of you.");
	}

	void OnSpawn() override
	{
		SetHealth(3000);
		SetGold(340);
		SetName("Warrior");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetInvincible(true);
		SetActionAnim("swordswing1_L");
		EVIDENCE_FOUND = 0;
		BRIBED = 0;
		CAN_BRIBE = 0;
		ATTACK1_DAMAGE = 30;
		ATTACK_RANGE = 128;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_mayor", "mayor");
		CatchSpeech("say_edrin", "edrin");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_name", "name");
	}

	void say_name()
	{
		SetName("Suliban");
		SayText(I + "guess " + I + " can let you know now; my name is Suliban.");
		PlayAnim("once", "talkright");
	}

	void say_hi()
	{
		if (!(BRIBED == 0)) return;
		SetVolume(7);
		Say("edrin1[34]");
		SayText("Yes? What do you want?");
	}

	void say_mayor()
	{
		if (!(BRIBED == 0)) return;
		SayText("Old fellow Erkold? What ye need from him? Did [edrin] send you?");
		PlayAnim("once", "talkright");
		if (!(BRIBED == 1)) return;
		SayText(I + "already told you what " + I + " know.");
		PlayAnim("once", "talkright");
	}

	void say_edrin()
	{
		SayText(I + " don t speak with just anyone, nor do I speak for free. If you can offer me enough, I ll tell you everything.");
		CAN_BRIBE = 1;
	}

	void bribe()
	{
		ReceiveOffer("accept");
		SayText("Right... Here s what you need to do - The mayor is guarded by a hot-tempered guard. You must steer off him. You might need a friend to help you stalk the guard, while one of you goes inside to speak with Erkold.");
		PlayAnim("once", "talkleft");
		ScheduleDelayedEvent(7, "say_mayor2");
		UseTrigger("mayorsdoor");
		BRIBED = 1;
	}

	void bribe_failed()
	{
		ReceiveOffer("reject");
		SayText("What are you trying? Off with ye.");
		PlayAnim("once", "no");
	}

	void robbed()
	{
		SayText("Thief!");
		PlayAnim("once", "beatdoor");
	}

	void attack_1()
	{
		DoDamage("ent_laststole", ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void say_job()
	{
		SayText(I + " got nothing for you.");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Say Hello";
		string reg.mitem.type = "say";
		int l.say = RandomInt(1, 4);
		if (l.say == 1)
		{
			string reg.mitem.data = "Hello";
		}
		else
		{
			if (l.say == 2)
			{
				string reg.mitem.data = "Hi";
			}
			else
			{
				if (l.say == 3)
				{
					string reg.mitem.data = "Hail";
				}
				else
				{
					if (l.say == 4)
					{
						string reg.mitem.data = "Greetings!";
					}
				}
			}
		}
		if (CAN_BRIBE == 1)
		{
			string reg.mitem.title = "Bribe (15g)";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:15";
			string reg.mitem.callback = "bribe";
			string reg.mitem.cb_failed = "bribe_failed";
		}
	}

}

}
