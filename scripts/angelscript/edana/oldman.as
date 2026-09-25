#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Oldman : CGameScript
{
	int CANCHAT;
	int CAN_ASKPOTION;
	int NO_RUMOR;
	int QUEST_BOAR;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_POTION;
	string STORENAME;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	int VENDOR_NOT_ON_USE;
	int letter;
	int quest.ledger;
	string quest.ledger.target;
	string quest.letter.target;

	Oldman()
	{
		SOUND_IDLE1 = "voices/human/male_oldidle.wav";
		SOUND_IDLE2 = "voices/human/male_oldidle2.wav";
		SOUND_IDLE3 = "voices/human/male_oldidle3.wav";
		SOUND_POTION = "voices/human/male_oldpotion.wav";
		NO_RUMOR = 1;
		SOUND_DEATH = "none";
		STORE_NAME = "edana_merchant_2";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		NO_RUMOR = 1;
		VENDOR_NOT_ON_USE = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(30, 45));
		if ((CAN_ASKPOTION))
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 6);
		Say("[.3] [.3] [.3] [.3]");
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(RandomInt(60, 120));
		if ((CAN_ASKPOTION))
		{
		}
		int POTION_CHAT = RandomInt(1, 3);
		if (POTION_CHAT == 1)
		{
			SayText("How about a [potion] ?");
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_POTION, 6);
		}
		else
		{
			if (POTION_CHAT == 2)
			{
				SayText("Did you need some [potions] , lad?.");
			}
			else
			{
				if (POTION_CHAT == 3)
				{
					SayText(I + " ve got something that ll heal you up.");
				}
			}
		}
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(25);
		SetName("Old man");
		SetName("abulurd");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		STORENAME = "edanaoldmans_shop";
		letter = 0;
		QUEST_BOAR = 0;
		CAN_ASKPOTION = 1;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("npc_say_store", "buy");
		CatchSpeech("say_ledger", "ledger");
		CatchSpeech("say_job", "boar");
		CatchSpeech("say_shutup", "shut up");
	}

	void say_hi()
	{
		PlayAnim("once", "talkleft");
		SayText("New folk around here , eh? And the adventerous kind , " + I + " see.");
		Say("[.3] [.1] [.2] [.3] [.4] [.2] [.2] [.3] [.1]");
		ScheduleDelayedEvent(3, "say_hi2");
	}

	void say_hi2()
	{
		SayText("Well , then , you are free to use my garden for practicing your skills.");
		Say("[.2] [.2] [.3] [.1] [.2] [.2] [.2] [.3] [.1] [.3] [.1] [.4]");
		ScheduleDelayedEvent(3, "say_hi3");
	}

	void say_hi3()
	{
		SayText("If you re lucky, the real big one ll be there. Real tough one , aye...");
		Say("[.10] [.10] [.10] [.20] [.7] [.7] [.10] [.20] [.1] [.1] [.1] [.3]");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", 4, 80);
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void reset()
	{
		letter = 0;
	}

	void game_recvoffer_item()
	{
		if (!(param1 == "item_ikeletter")) return;
		if (!(letter == 0)) return;
		ReceiveOffer("accept");
		quest_letter_done(GetEntityIndex("ent_lastgave"));
	}

	void global_quest_letter()
	{
		SetName("Abulurd");
	}

	void quest_letter_done()
	{
		PlayAnim("once", "pondering3");
		SayText("So Ike s looking for some good firewood eh? My son does some good work, give him this sample.");
		letter = 1;
		quest.letter.target = param1;
		ScheduleDelayedEvent(300, "reset");
		ScheduleDelayedEvent(3, "quest_letter_done_2");
	}

	void quest_letter_done_2()
	{
		// TODO: offer quest.letter.target item_ikelog
	}

	void global_quest_ledger()
	{
		quest.ledger = 1;
	}

	void say_ledger()
	{
		if (!(quest.ledger == 1)) return;
		quest.ledger = 2;
		quest.ledger.target = GetEntityIndex("ent_lastspoke");
		PlayAnim("once", "pondering2");
		SayText("Hmmm... " + I + "think " + I + " have that ledger around here somewhere...");
		ScheduleDelayedEvent(4, "quest_ledger_done");
	}

	void quest_ledger_done()
	{
		PlayAnim("critical", "pull_needle");
		SayText("Ah! Here it is! Now hurry and take it to Ike.");
		ScheduleDelayedEvent(2, "quest_ledger_done_2");
	}

	void quest_ledger_done_2()
	{
		// TODO: offer quest.ledger.target item_ledger
	}

	void trig_boarsdead()
	{
		QUEST_BOAR = 2;
	}

	void global_quest_boars_done()
	{
		QUEST_BOAR = 3;
	}

	void say_job()
	{
		if (QUEST_BOAR == 0)
		{
			QUEST_BOAR = 1;
			SayText("They re trapped in the backyard!");
			PlayAnim("once", "converse2");
			Say("[.30] [.30] [.30] [.40] [.20]");
			ScheduleDelayedEvent(2.3, "say_boar2");
		}
		else
		{
			if (QUEST_BOAR == 1)
			{
				SayText("Head out back and train up. " + I + " don  mind.");
				Say("[.20] [.10] [.10] [.10] [.10] [.10] [.15] [.10]");
			}
			else
			{
				if (QUEST_BOAR == 2)
				{
					SayText("Did ya get all the little rascals?  A fine job lad.");
					PlayAnim("once", "yes");
					Say("[.20] [.10] [.10] [.30] [.10] [.10] [.15] [.10]");
					ScheduleDelayedEvent(3, "say_boar_done2");
				}
			}
		}
	}

	void say_boar2()
	{
		SayText(I + " just send people there so they can train their skills.");
		Say("[.30] [.20] [.30] [.40] [.20] [.20] [.30] [.10]");
		ScheduleDelayedEvent(4, "say_boar3");
	}

	void say_boar3()
	{
		SayText("Nobody can afford a mentor these days...");
		Say("[.20] [.20] [.30] [.10] [.20] [.20] [.20]");
		ScheduleDelayedEvent(3, "say_boar4");
	}

	void say_boar4()
	{
		SayText("Oh , and Ike the Armourer might have a job for ye when you re done.");
		Say("[.20] [.20] [.30] [.10] [.20] [.20] [.20] [.10] [.10] [.10] [.10] [.10]");
		ScheduleDelayedEvent(5, "say_boar5");
	}

	void say_boar5()
	{
		SayText("...Care for a [potion] , by the way?");
		Say("[.10] [.10] [.10] [.10] [.10]");
	}

	void say_boar_done2()
	{
		SayText("Head to town and Ike can use the skins");
		Say("[.20] [.20] [.30] [.10] [.20] [.10] [.10] [.10] [.10]");
	}

	void say_shutup()
	{
		if (!(CAN_ASKPOTION)) return;
		CAN_ASKPOTION = 0;
		SayText(I + " m sorry, was I bothering you?");
		PlayAnim("once", "panic");
		Say("[.3] [.1] [.4] [.1] [.1] [.7] [.7] [.7] [.4]");
	}

	void game_menu_getoptions()
	{
		if (!(letter))
		{
			if ((ItemExists(param1, "item_ikeletter")))
			{
			}
			string reg.mitem.title = "Give Letter";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_ikeletter";
			string reg.mitem.callback = "quest_letter_done";
		}
		if (quest.ledger == 1)
		{
			string reg.mitem.title = "Ask About Ledger";
			string reg.mitem.type = "say";
			string reg.mitem.data = "Do you have Ike's Ledger?";
		}
		if ((ItemExists(param1, "skin_boar_heavy")))
		{
			string reg.mitem.title = "Give Pelt";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "quest_heavypelt_done";
		}
	}

}

}
