#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Bryan : CGameScript
{
	int ASKED_APPLE;
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CIDER;
	int EVIDENCE_FOUND;
	string GOSSIP_LINE;
	int RATTING;
	int SAY_MAYOR_SENTENCE;
	string SPEECH_LINE;
	string STORE_TRIGGERTEXT;
	string WEATHER;

	Bryan()
	{
		const string SOUND_IDLE = "voices/human/male_idle4.wav";
		const string SOUND_IDLE2 = "voices/human/male_idle5.wav";
		const string SOUND_IDLE3 = "voices/human/male_idle6.wav";
		const string SOUND_DEATH = "none";
		const string STORE_NAME = "edana_merchant_3";
		STORE_TRIGGERTEXT = "store";
		const int NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(35);
		// PlayRandomSound from: "const.snd.maxvol", SOUND_IDLE, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {"const.snd.maxvol", SOUND_IDLE, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), "const.snd.voice", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(60);
		if ((CanSee("player", 128)))
		{
		}
		if (RATTING == 0)
		{
		}
		SPEECH_LINE = RandomInt(1, 2);
		if (SPEECH_LINE == 1)
		{
			SayText("Guards just love me [apples] . Keeps em strong.  Care to try one, mate?");
			CallExternal(FindEntityByName("mayorguard"), "bryan_said_so");
		}
		else
		{
			if (SPEECH_LINE == 2)
			{
			}
		}
		SayText("Care to try an apple , mate?");
		ASKED_APPLE = 1;
	}

	void OnSpawn() override
	{
		SetName("bryan");
		SetHealth(25);
		SetGold(30);
		SetName("Bryan the grocer");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		EVIDENCE_FOUND = 0;
		SAY_MAYOR_SENTENCE = 0;
		RATTING = 0;
		ASKED_APPLE = 0;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.6;
		CIDER = 0;
		if ((G_CHRISTMAS_MODE))
		{
			SetModelBody(2, 1);
		}
		ScheduleDelayedEvent(3.0, "check_hat");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("respond_yes", "yes");
		CatchSpeech("respond_no", "no");
		CatchSpeech("say_apple", "apple");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_cider", "cider");
		CatchSpeech("say_mayor", "mayor");
		CatchSpeech("say_rumor", "quest");
		Precache(SOUND_IDLE);
	}

	void check_hat()
	{
		if ((G_CHRISTMAS_MODE))
		{
			SetModelBody(2, 1);
		}
	}

	void say_hi()
	{
		SayText("Ello there. Care for one of me delicious [apples]?");
		ScheduleDelayedEvent(2, "say_hi2");
		ASKED_APPLE = 1;
	}

	void say_hi2()
	{
		if (!(WEATHER != "clear")) return;
		SayText("It ll keep you going in this poor weather we are having.");
	}

	void say_apple()
	{
		SayText("Guards just love me [apples] . Keeps em strong.  Care to try one, mate?");
		CallExternal(FindEntityByName("mayorguard"), "bryan_said_so");
	}

	void say_mayor()
	{
		RATTING = 1;
		ScheduleDelayedEvent(1, "say_mayor_delayed");
	}

	void say_mayor_delayed()
	{
		if (EVIDENCE_FOUND == 0)
		{
			GOSSIP_LINE = RandomInt(1, 3);
			if (GOSSIP_LINE == 1)
			{
				SayText("Word is , the mayor ain t such a good fella.");
			}
			else
			{
				if (GOSSIP_LINE == 2)
				{
					SayText("I hear Edrin s got a pretty colourful past.");
				}
				else
				{
					if (GOSSIP_LINE == 3)
					{
						SayText("Maybe... with the proper incentive... I d tell ya more.");
					}
				}
			}
		}
		else
		{
			SayText("I heard the mayor s been caught, and will be spendin a good amount of time locked up.");
			PlayAnim("once", "yes");
		}
		RATTING = 0;
	}

	void worldevent_evidence_found()
	{
		EVIDENCE_FOUND = 1;
	}

	void respond_yes()
	{
		if (!(ASKED_APPLE == 1)) return;
		say_apple();
		ASKED_APPLE = 0;
	}

	void respond_no()
	{
		if (!(ASKED_APPLE == 1)) return;
		SayText("But have ya tried one traveler? They re great apples!");
		ASKED_APPLE = 0;
	}

	void game_recvoffer_gold()
	{
		if (!(EVIDENCE_FOUND == 0)) return;
		if ("game.offer.gold" >= 15)
		{
			ReceiveOffer("accept");
			SayText("Tat s a good lad.  And here is what I know...");
			PlayAnim("once", "quicklook");
			RATTING = 1;
			ScheduleDelayedEvent(3, "give_mayor_info_1");
		}
		else
		{
			ReceiveOffer("reject");
			SayText("A lowly begger wouldn t take that offer.");
			PlayAnim("once", "no");
		}
	}

	void give_mayor_info_1()
	{
		SayText("Good , no one s around.");
		ScheduleDelayedEvent(2, "give_mayor_info_2");
	}

	void give_mayor_info_2()
	{
		SayText("I been seeing some unusual mail coming in to the mayor.");
		PlayAnim("once", "pondering3");
		ScheduleDelayedEvent(4, "give_mayor_info_3");
	}

	void give_mayor_info_3()
	{
		SayText("I been thinkin maybe him and the Orcs communicatin by letter.");
		PlayAnim("once", "converse2");
		ScheduleDelayedEvent(3, "give_mayor_info_4");
	}

	void give_mayor_info_4()
	{
		SayText("But I never had the gall to go check it out.");
		ScheduleDelayedEvent(4, "give_mayor_info_5");
	}

	void give_mayor_info_5()
	{
		SayText("The mayor is clever , if he s suspicious of you, he ll hide the evidence.");
		ScheduleDelayedEvent(3, "give_mayor_info_6");
	}

	void give_mayor_info_6()
	{
		SayText("So don t let  em know you re lookin for it mate.");
		ScheduleDelayedEvent(3, "give_mayor_info_7");
	}

	void give_mayor_info_7()
	{
		SayText("Him and his guard s are so corrupt, it makes me sick...they ll do anythin  for money.");
		ScheduleDelayedEvent(3, "give_mayor_info_8");
	}

	void give_mayor_info_8()
	{
		SayText("I m sure Edrin, the guard over there, will help us. Show him any evidence you find.");
		RATTING = 0;
	}

	void trade_done()
	{
		SayText("Have a nice day.");
		Say("[.3] [.3] [.3] [.5]");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", 30, 100);
	}

	void cider()
	{
		CIDER = 1;
	}

	void say_cider()
	{
		if (!(CIDER == 1)) return;
		SayText("Oh! Sylphiel s cider? Well I had thought she d gotten it already! Tell her the [cider] is on it s way.");
		Say("[.6] [.24] [.35] [.4] [.34] [.24] [.35] [.4]");
		PlayAnim("once", "converse1");
		CallExternal(FindEntityByName("wench"), "cider2");
		ScheduleDelayedEvent(1, "say_cider_2");
	}

	void say_cider_2()
	{
		CIDER = 3;
	}

	void cider3()
	{
		CIDER = 2;
	}

	void say_cider()
	{
		if (!(CIDER == 2)) return;
		SayText("Oh! She still hasn t gotten it? Well then you must head over to Krythos in the Merchant s Square immediately!");
		CallExternal(FindEntityByName("krythos"), "cider4");
		ScheduleDelayedEvent(1, "say_cider_2");
	}

	void say_cider()
	{
		if (!(CIDER == 3)) return;
		SayText("Well? You should get going!");
	}

	void say_rumor()
	{
		PlayAnim("once", "pondering");
		SayText("An old friend of mine , a hermit living in the Thornlands is looking for something precious.");
	}

	void worldevent_weather()
	{
		WEATHER = param1;
	}

}

}
