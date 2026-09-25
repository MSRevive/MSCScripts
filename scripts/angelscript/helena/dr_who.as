#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class DrWho : CGameScript
{
	string BUSY_CHATTING;
	float CHAT_DELAY;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEPS;
	string DID_CONFUSED;
	int DID_INTRO;
	int HEARD_APPLE;
	int NO_JOB;
	int NO_RUMOR;
	int PORTAL_OPEN;
	int RANT_STEP;
	int RESPONDED_NO;
	string SPELL_PATIENTS;

	DrWho()
	{
		NO_JOB = 1;
		NO_RUMOR = 1;
		CHAT_DELAY = 4.0;
		SetName("Torwhodoc Sa thraz, Keeper of Time");
		SetHealth(1);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest2.mdl");
		SetWidth(32);
		SetHeight(72);
		SetSayTextRange(512);
		SetIdleAnim("idle1");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("hear_no", "no");
		CatchSpeech("hear_apple", "apple");
		SPELL_PATIENTS = "";
		ScheduleDelayedEvent(1.0, "scan_for_ally");
	}

	void hear_apple()
	{
		if ((PORTAL_OPEN)) return;
		PlayAnim("critical", "eye_wipe");
		SayText("An... An apple you say?");
		HEARD_APPLE = 1;
	}

	void scan_for_ally()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(2.0, "scan_for_ally");
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) < 512)) return;
		DID_INTRO = 1;
		say_hi();
	}

	void say_hi()
	{
		if (!(IsEntityAlive(param1)))
		{
			if ((IsEntityAlive("ent_lastspoke")))
			{
				if (GetEntityRange("ent_lastspoke") > 256)
				{
				}
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((BUSY_CHATTING)) return;
		if (!(DID_CONFUSED))
		{
			PlayAnim("critical", "eye_wipe");
			CHAT_STEPS = 3;
			CHAT_STEP = 0;
			BUSY_CHATTING = 1;
			CHAT_STEP1 = "At last, we meet! ...or is this the second time...?";
			CHAT_STEP2 = "I'm always getting confused about these things you see...";
			CHAT_STEP3 = "You'd be confused too, if you were as unstuck in time as I...";
			chat_loop();
			DID_CONFUSED = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((DID_CONFUSED))
		{
			CHAT_STEPS = 8;
			CHAT_STEP = 0;
			BUSY_CHATTING = 1;
			CHAT_STEP1 = "Huh? Oh, yes, sorry... I am Torwhodoc Sa'thraz - last of the time wizards!";
			CHAT_STEP2 = "...and you... You are the one who was... or is... or will be... or...";
			CHAT_STEP3 = "No matter, you'll have to do, assuming, you have the gold I asked for...";
			CHAT_STEP4 = "Surely you remember, after you saved Helena? I asked for... Oh nevermind.";
			CHAT_STEP5 = "It doesn't matter if you remember or not, I need 1000 gold to eat *cough* I mean, open the portal.";
			CHAT_STEP6 = "Granted, if you don't go through the portal and save the town, there'll be no place to eat at...";
			CHAT_STEP7 = "...but if I don't get the gold, I'll have nothing to eat with so....";
			CHAT_STEP8 = "Don't worry, I gave you something to make it worth the money. Remember?";
			chat_loop();
		}
	}

	void hear_no()
	{
		if ((TALKING)) return;
		if ((RESPONDED_NO)) return;
		SayText("Oh , you will.... You will... Or... Maybe you already have?");
		RESPONDED_NO = 1;
	}

	void open_portal()
	{
		string NAME_STR = GetEntityName(param1);
		NAME_STR += "!";
		SayText("Quickly " + NAME_STR + " This time portal , it will not last long!");
		RANT_STEP = 0;
		ScheduleDelayedEvent(20.0, "timer_rant_loop");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetSolid("none");
		PORTAL_OPEN = 1;
		UseTrigger("time_tele");
	}

	void game_menu_getoptions()
	{
		if ((PORTAL_OPEN)) return;
		string reg.mitem.title = "Give 1000 gold";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:1000";
		string reg.mitem.callback = "open_portal";
		string reg.mitem.cb_failed = "payment_failed";
		if (!(HEARD_APPLE)) return;
		if (!(ItemExists(param1, "health_apple"))) return;
		string reg.mitem.title = "Give Apple";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "health_apple";
		string reg.mitem.callback = "open_portal";
	}

	void payment_failed()
	{
		PlayAnim("critical", "no");
		int RND_RESP = RandomInt(1, 2);
		if (RND_RESP == 1)
		{
			SayText("Come now , the last of the time wizards deserves better food than that will buy.");
		}
		if (RND_RESP == 2)
		{
			SayText("Now what sort of apples am " + I + " going to buy with that sort of cash? Bryan s of Edana, mayhaps?");
		}
	}

	void timer_rant_loop()
	{
		SetSayTextRange(200);
		float RND_DELAY = Random(40, 80);
		RND_DELAY("timer_rant_loop");
		RANT_STEP += 1;
		if (RANT_STEP > 9)
		{
			RANT_STEP = 1;
		}
		if ((BUSY_TALKING)) return;
		convo_anim();
		if (RANT_STEP == 1)
		{
			SayText("Actually , now that " + I + " think of it.... Take your time.");
		}
		if (RANT_STEP == 2)
		{
			SayText(I + " mean , cannot run out of time. After all , time is infinite...");
		}
		if (RANT_STEP == 3)
		{
			SayText("You are finite , Torwhodoc is finite... This... This is wrong tool.");
		}
		if (RANT_STEP == 4)
		{
			SayText("Do you know " + I + " had five brothers?");
		}
		if (RANT_STEP == 5)
		{
			SayText("You would say we all have the same name , but all pronounced slightly differently...");
		}
		if (RANT_STEP == 6)
		{
			SayText("TorwhoDOC... TORwhodoc... TorWHOdoc... TORwhoDOC... TorWHODOC.... TORWHOdoc...");
		}
		if (RANT_STEP == 7)
		{
			SayText("So , you see , how " + I + " am become so very easily confused...");
		}
		if (RANT_STEP == 8)
		{
			SayText("Torwhodoc have very sad life , probably have very sad death , but at least , there is symmetry.");
		}
		if (RANT_STEP == 9)
		{
			SayText("Wow , you re still here!? Comeon " + I + " gotta eat sometime!");
		}
	}

	void chat_loop()
	{
		if (CHAT_STEP == 2)
		{
			convo_anim();
		}
		if (CHAT_STEP == 4)
		{
			convo_anim();
		}
		if (CHAT_STEP == 6)
		{
			convo_anim();
		}
		if (CHAT_STEP == 8)
		{
			convo_anim();
		}
		if (CHAT_STEP == 10)
		{
			convo_anim();
		}
	}

}

}
