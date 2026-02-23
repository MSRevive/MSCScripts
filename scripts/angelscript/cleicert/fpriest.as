#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Fpriest : CGameScript
{
	int ALREADYTALKING;
	int BREAK_FADE;
	int BUSY_CHATTING;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP10;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEP9;
	int CHAT_STEPS;
	string CHAT_TYPE;
	int FADE_LOOP;
	int FADING_IN;
	int IS_ACTIVE;
	string MY_LIGHT_SCRIPT;
	string MY_YAW;
	string PLAYER_DETECT;
	int USED_TRIGGER;

	Fpriest()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const float CHAT_DELAY = 5.75;
	}

	void OnSpawn() override
	{
		SetHealth(40);
		SetMaxHealth(40);
		SetGold(0);
		SetName("Ghostly Priest");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		SetModelBody(1, 3);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ALREADYTALKING = 0;
		SetSayTextRange(2048);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_stfu", "stfu");
		ScheduleDelayedEvent(0.1, "scan_for_players");
		ScheduleDelayedEvent(0.1, "get_angles");
	}

	void get_angles()
	{
		MY_YAW = GetMonsterProperty("angles.yaw");
	}

	void scan_for_players()
	{
		if ((IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "scan_for_players");
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			check_near();
		}
	}

	void check_near()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < 512)) return;
		IS_ACTIVE = 1;
		PLAYER_DETECT = CUR_PLAYER;
		do_intro();
	}

	void do_intro()
	{
		light_up();
		face_speaker(PLAYER_DETECT);
		PlayAnim("critical", "comehere");
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		FADE_LOOP = 0;
		fade_in_loop();
		SayText("Pssst... Over here.");
		ScheduleDelayedEvent(5.0, "say_hi");
	}

	void fade_in_loop()
	{
		FADE_LOOP += 1;
		FADING_IN = 1;
		if (FADE_LOOP == 255)
		{
			FADING_IN = 0;
		}
		if (!(FADE_LOOP < 255)) return;
		ScheduleDelayedEvent(0.1, "fade_in_loop");
		SetProp(GetOwner(), "renderamt", FADE_LOOP);
	}

	void fade_out()
	{
		FADE_LOOP -= 1;
		if (FADE_LOOP == 0)
		{
			DeleteEntity(GetOwner());
		}
		if (FADE_LOOP == 1)
		{
			remove_light();
		}
		if (!(FADE_LOOP > 0)) return;
		if (!(BREAK_FADE))
		{
			ScheduleDelayedEvent(0.1, "fade_out");
		}
		SetProp(GetOwner(), "renderamt", FADE_LOOP);
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		BREAK_FADE = 1;
		BUSY_CHATTING = 1;
		CHAT_STEP = 0;
		CHAT_TYPE = "intro";
		CHAT_STEP1 = "Thank the gods! You've come just in time... I've not much time to explain...";
		CHAT_STEP2 = "Long ago we imprisoned a great evil in this temple: a dreaded lightning Djinn of the Shadahar Orc Tribe.";
		CHAT_STEP3 = "We were able to weaken him, and seal him here inside the temple, but we lacked the power to slay him.";
		CHAT_STEP4 = "...As such, we felt the only option, to prevent his escape, was to fortify the temple's defenses and seal it, from the inside.";
		CHAT_STEP5 = "As you can see by my current, ghostly state, that was quite some time ago, and alas, we have all long since perished.";
		CHAT_STEP6 = "My spirit was bound here in hopes that I could somehow influence someone of power to the temple, to finish our task, and destroy the Djinn.";
		CHAT_STEP7 = "However, it maybe too late, it seems the Shadahar Orcs have also found our temple, and are breaking in as we speak!";
		CHAT_STEP8 = "If they find the Djinn first, they will be able to rejuvenate and release him at full power! You must find the Djinn before they do, and destroy it!";
		CHAT_STEP9 = "There are four crystals that lock the beast in its cage within the temple - find them, use them to release him.";
		CHAT_STEP10 = "You MAY be able to defeat him while he is still in his weakened state! My time here has nearly ended, so hurry! You are now our only hope!";
		CHAT_STEPS = 10;
		chat_loop();
	}

	void chat_loop()
	{
		if (CHAT_TYPE == "intro")
		{
			if (CHAT_STEP != 9)
			{
				face_speaker(PLAYER_DETECT);
			}
			if (CHAT_STEP == 1)
			{
				PlayAnim("critical", "comehere");
			}
			if (CHAT_STEP == 3)
			{
				PlayAnim("critical", "converse1");
			}
			if (CHAT_STEP == 5)
			{
				PlayAnim("critical", "converse2");
			}
			if (CHAT_STEP == 7)
			{
				PlayAnim("critical", "talkright");
			}
			if (CHAT_STEP == 8)
			{
				PlayAnim("critical", "pondering2");
			}
			if (CHAT_STEP == 9)
			{
				SetAngles("face");
				PlayAnim("critical", "dryhands");
				ScheduleDelayedEvent(0.25, "use_trig");
			}
			if (CHAT_STEP == 10)
			{
				PlayAnim("critical", "wave");
				SetMoveAnim("none");
				SetIdleAnim("none");
				FADING_OUT = 1;
				BREAK_FADE = 0;
				ScheduleDelayedEvent(2.0, "fade_out");
			}
			if ((FADING_OUT))
			{
				if ((BREAK_FADE))
				{
				}
				if (!(FADING_IN))
				{
				}
				fade_in_loop();
			}
		}
	}

	void use_trig()
	{
		if ((USED_TRIGGER)) return;
		USED_TRIGGER = 1;
		UseTrigger("GiveCrystalOne");
	}

	void light_up()
	{
		Vector3 LIGHT_COLOR = Vector3(200, 200, 255);
		int LIGHT_RAD = 128;
		ClientEvent("persist", "all", "monsters/lighted_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void remove_light()
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		ClientEvent("update", "all", MY_LIGHT_SCRIPT, "remove_me");
	}

	void say_hi_old()
	{
		if (ALREADYTALKING == 0)
		{
			ALREADYTALKING = 1;
			PlayAnim("critical", "crouch");
			SayText("Cowards! Cowards you all are! Oh , you are not one of those [orcs] , are you?");
			ScheduleDelayedEvent(5, "greet1");
		}
	}

	void greet1()
	{
		SayText("Well , this certainly changes things. Anyone who fights against those creatures certainly deserves my help.");
		ScheduleDelayedEvent(5, "greet2");
	}

	void greet2()
	{
		SayText("I am unsure as to who their master is or what their master plan is , but I think I know why they re here.");
		ScheduleDelayedEvent(5, "greet3");
	}

	void greet3()
	{
		SayText("Our temple worshipped lightning , perhaps more than we should have.");
		ScheduleDelayedEvent(5, "greet4");
	}

	void greet4()
	{
		SayText("For our 100 year celebration , we thought that we should create a symbol for ourselves.");
		ScheduleDelayedEvent(5, "greet5");
	}

	void greet5()
	{
		SayText("We wanted something powerful , something moving. We didn t count on it actually moving..");
	}

	void greet6()
	{
		SayText("We created a being of pure lightning , and during our celebrations , it started killing.");
	}

	void greet7()
	{
		SayText("It took our strongest mages to stop the beast. They managed to drain it s magic into [crystals].");
	}

	void greet8()
	{
		SayText("The process drained them so much that they died in the process. I fear that these orcs are intending");
	}

	void greet9()
	{
		SayText("to return the beast s magic and release him into the world. Here, take this crystal and do with it what you will.");
		UseTrigger("GiveCrystalOne");
	}

	void greet10()
	{
		SayText("I fear that the orcs may continue to try to release him if something isn t done...");
		ALREADYTALKING = 0;
	}

	void crystal()
	{
		if (ALREADYTALKING == 0)
		{
			ALREADYTALKING = 1;
			SayText("Ah , yes. The magic crystals contain all of the beast s powers. They have been scattered through the temple, but");
			ScheduleDelayedEvent(5, "crystal1");
		}
	}

	void crystal1()
	{
		SayText("I fear the orcs may be attempting to gather them to release the monster. When the crystals have");
		ScheduleDelayedEvent(5, "crystal2");
	}

	void crystal2()
	{
		SayText("been placed into the base of the monster s statue, he will be released.");
		ALREADYTALKING = 0;
	}

	void say_stfu()
	{
		if ((USED_TRIGGER)) return;
		SayText("My werd , so rude...");
		ScheduleDelayedEvent(1.0, "use_trig");
	}

}

}
