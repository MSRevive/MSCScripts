#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_npc.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Edrin : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int GOT_HOME;
	string HOME_LOC;
	string HOME_YAW;
	int QUEST_1;
	int QUEST_1_ACCEPTED;
	int QUEST_1_ASKEDMAYOR;
	string QUEST_1_WINNER;
	int REQ_QUEST_NOTDONE;
	int THIEF_1;
	string script.targetplayer;

	Edrin()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "swordswing1_L";
		const int NO_RUMOR = 1;
		const int NO_HAIL = 1;
		const float CHAT_DELAY = 6.0;
		const int XMASS_OLD_GUY = 1;
	}

	void OnSpawn() override
	{
		SetHealth(700);
		SetMaxHealth(700);
		SetGold(50);
		SetName("Edrin , Captain of the Guard");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		SetMoveAnim("walk");
		SetInvincible(true);
		THIEF_1 = 2;
		QUEST_1 = 0;
		QUEST_1_ASKEDMAYOR = 0;
		REQ_QUEST_NOTDONE = 1;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_mayor", "mayor");
		CatchSpeech("say_ok", "aye");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_pretend", "pretend");
		CatchSpeech("say_thief", "cutpurse");
		CatchSpeech("say_rumour", "rumour");
		CatchSpeech("say_xmass", "christmas");
		ScheduleDelayedEvent(1.0, "set_home_loc");
	}

	void set_home_loc()
	{
		HOME_LOC = GetMonsterProperty("origin");
		HOME_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_hi()
	{
		EmitSound(GetOwner(), CHAN_VOICE, "npc/edrin1.wav", "game.sound.maxvol");
		SayText("Hail , traveller.");
		ScheduleDelayedEvent(2, "say_hi_2");
	}

	void say_hi_2()
	{
		if (!(QUEST_1 < 2)) return;
		SayText("...damn that [mayor]");
		QUEST_1_ASKEDMAYOR = 1;
		ScheduleDelayedEvent(20, "reset_askedmayor");
	}

	void reset_askedmayor()
	{
		QUEST_1_ASKEDMAYOR = 0;
	}

	void say_mayor()
	{
		if (!(QUEST_1 < 2)) return;
		EmitSound(GetOwner(), CHAN_VOICE, "npc/edrin2.wav", "game.sound.maxvol");
		SayText("I suspect the mayor is a traitor , working with the Orcs.");
		script.targetplayer = GetEntityIndex("ent_lastspoke");
		ScheduleDelayedEvent(5, "say_mayor_2");
	}

	void say_mayor_2()
	{
		SayText("If you find evidence of this , you will be well rewarded. I will brief you through it. Is that all right?");
		QUEST_1 = 1;
		OpenMenu(script.targetplayer);
	}

	void say_ok()
	{
		if (!(QUEST_1 < 2)) return;
		QUEST_1_ACCEPTED = 1;
		SayText("Recently , there has been a courier passing in and out Edana , only delivering a letter to the mayor.");
		ScheduleDelayedEvent(4, "say_brief");
	}

	void say_brief()
	{
		SayText("You ll have to pretend to be him. I ve found out his name is Suliban , so that should be your answer should the mayor ask who you are.");
	}

	void game_recvoffer_item()
	{
		if (param1 == "item_letter_mayor")
		{
			if (QUEST_1 == 1)
			{
			}
			ReceiveOffer("accept");
			mayorq_done(GetEntityIndex("ent_lastgave"));
		}
		else
		{
			if (param1 == "item_thiefmap")
			{
				if (THIEF_1 == 4)
				{
				}
				ReceiveOffer("accept");
				PlayAnim("once", "return_needle");
				SayText("Ah , what s this? A map of the thieves whereabouts? You have done well, my friend.");
				ScheduleDelayedEvent(4, "say_thiefloc");
			}
		}
	}

	void mayorq_done()
	{
		SayText("Ahh! That will certainly be enough evidence... Thank you traveller..");
		EmitSound(GetOwner(), CHAN_VOICE, "npc/edrin3.wav", 10);
		CallExternal("all", "worldevent_evidence_found");
		QUEST_1 = 2;
		REQ_QUEST_NOTDONE = 0;
		QUEST_1_WINNER = param1;
		ScheduleDelayedEvent(6, "recvletter_2");
	}

	void mayorq_badevidence()
	{
		SayText("You ll need to return with solid evidence, worthy of a swift conviction.");
		PlayAnim("once", "no");
	}

	void recvletter_2()
	{
		SayText("And please , take this gift.");
		// TODO: offer QUEST_1_WINNER gold RandomInt(12, 15)
		UseTrigger("evidence_found");
		CallExternal("all", "global_mayorquest_done");
	}

	void trig_flowercompliant()
	{
		SayText("Hey! Stay out of there!");
		PlayAnim("once", "wave");
		ScheduleDelayedEvent(1.5, "flowers_2");
	}

	void flowers_2()
	{
		PlayAnim("critical", "idle7");
		ScheduleDelayedEvent(0.2, "go_home");
	}

	void go_home()
	{
		GOT_HOME = 0;
		SetMoveDest(HOME_LOC);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "check_home_loop");
	}

	void check_home_loop()
	{
		if ((GOT_HOME)) return;
		ScheduleDelayedEvent(1.0, "check_home_loop");
		if (Distance(GetMonsterProperty("origin"), HOME_LOC) <= 5)
		{
			SetMoveDest("none");
			SetAngles("face");
			GOT_HOME = 1;
			SetMoveAnim(ANIM_IDLE);
		}
		if (!(Distance(GetMonsterProperty("origin"), HOME_LOC) > 5)) return;
		SetMoveAnim(ANIM_WALK);
		SetMoveDest(HOME_LOC);
	}

	void say_job()
	{
		SayText("The sewers has been off limits to civilians for quite some time now , due to the aggressive bats that swarmed the place as of late...");
		ScheduleDelayedEvent(8, "say_job2");
	}

	void say_job2()
	{
		SayText("... and seeing as we re rather short on guards, perhaps you could help us out and clear the place?");
		ScheduleDelayedEvent(7, "say_job3");
	}

	void say_job3()
	{
		SayText("Be sure to gear up with some proper weapons , though. Those bats rarely sleep alone...");
		ScheduleDelayedEvent(6, "say_job4");
	}

	void say_job4()
	{
		PlayAnim("once", "talkright");
		SayText("You ll find the entrance to the sewers by the prison, down to the right, by the armorsmith.");
		ScheduleDelayedEvent(5, "say_job5");
	}

	void say_job5()
	{
		SayText("Just move the hay we used to block the hatch.");
		ScheduleDelayedEvent(4, "say_job6");
	}

	void say_job6()
	{
		SayText("Of course , we can t pay you, at the moment, but it is good training.");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering3");
		SayText("Do I look like a gossiping mongrel? Be off!");
	}

	void say_thief()
	{
		if (!(THIEF_1 == 2)) return;
		THIEF_1 = 3;
		Say("suspicious");
		SayText("If you see anything suspicious around here , you let me know.");
		if (!(THIEF_1 == 3)) return;
		THIEF_1 = 4;
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
		SayText("There will probably be thieves around the area. If not , look in the caves near the road to Edana.");
		ScheduleDelayedEvent(4, "say_thiefloc3");
	}

	void say_thiefloc3()
	{
		SayText("Bring me proof that you ve killed them and I ll reward you , if not killing them is reward enough.");
		ScheduleDelayedEvent(4, "say_thiefloc4");
	}

	void say_thiefloc4()
	{
		SetVolume(8);
		Say("guardwarn");
		SayText("Be wary , it is dangerous outside.");
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if (QUEST_1 < 2)
		{
			OpenMenu(GetEntityIndex(m_hLastUsed));
		}
	}

	void game_menu_getoptions()
	{
		if (QUEST_1 == 0)
		{
			if (!(QUEST_1_ASKEDMAYOR))
			{
				string reg.mitem.title = "Say Hello";
				string reg.mitem.type = "say";
				string rnd = RandomInt(0, 3);
				if (rnd == 0)
				{
					string reg.mitem.data = "Hail!";
				}
				else
				{
					if (rnd == 1)
					{
						string reg.mitem.data = "Hello";
					}
					else
					{
						if (rnd == 2)
						{
							string reg.mitem.data = "Greetings";
						}
						else
						{
							if (rnd == 3)
							{
								string reg.mitem.data = "Hi";
							}
						}
					}
				}
			}
			else
			{
				string reg.mitem.title = "Inquire About Mayor";
				string reg.mitem.type = "say";
				string rnd = RandomInt(0, 2);
				if (rnd == 0)
				{
					string reg.mitem.data = "Mayor?";
				}
				else
				{
					if (rnd == 1)
					{
						string reg.mitem.data = "What's the mayor done this time?";
					}
					else
					{
						if (rnd == 2)
						{
							string reg.mitem.data = "Damn the mayor?";
						}
					}
				}
			}
		}
		else
		{
			if (QUEST_1 == 1)
			{
				if (!(QUEST_1_ACCEPTED))
				{
					string reg.mitem.title = "Accept";
					string rnd = RandomInt(0, 3);
					if (rnd == 0)
					{
						string reg.mitem.data = "Aye!";
					}
					else
					{
						if (rnd == 1)
						{
							string reg.mitem.data = "Alright";
						}
						else
						{
							if (rnd == 2)
							{
								string reg.mitem.data = "Yes";
							}
							else
							{
								if (rnd == 3)
								{
									string reg.mitem.data = "Of course";
								}
							}
						}
					}
				}
				else
				{
					string reg.mitem.title = "Ask About quest";
					string reg.mitem.data = "What should I do?";
					string reg.mitem.callback = "say_ok";
				}
				string reg.mitem.type = "say";
				if ((QUEST_1_ACCEPTED))
				{
					if ((ItemExists(param1, "item_letter_mayor")))
					{
					}
					string reg.mitem.title = "Present Evidence";
					string reg.mitem.type = "payment";
					string reg.mitem.data = "item_letter_mayor";
					string reg.mitem.callback = "mayorq_done";
				}
			}
		}
	}

}

}
