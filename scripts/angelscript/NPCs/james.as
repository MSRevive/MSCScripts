#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class James : CGameScript
{
	int BUSY_CHATTING;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	int CHAT_STEPS;
	int CONGRATS_MSG;
	string DID_CONGRATS;
	int SAID_HI;

	James()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const float CHAT_DELAY = 3.0;
	}

	void OnSpawn() override
	{
		SetName("Jae em");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetModel("npc/human1.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 5);
		SetRoam(false);
		SetMoveAnim("idle1");
		SetHearingSensitivity(10);
		SetSayTextRange(1024);
		CatchSpeech("say_hi", "hi");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(IsValidPlayer(LAST_HEARD))) return;
		if (!(false)) return;
		if (!(GetEntityRange(LAST_HEARD) < 200)) return;
		if ((CONGRATS_MSG))
		{
			face_speaker(LAST_HEARD);
			if (!(DID_CONGRATS))
			{
			}
			say_hi();
		}
		if ((SAID_HI)) return;
		face_speaker(LAST_HEARD);
		say_hi();
	}

	void say_hi()
	{
		if ((IsValidPlayer(param1)))
		{
			face_speaker(GetEntityIndex(param1));
		}
		if ((IsValidPlayer("ent_lastspoke")))
		{
			face_speaker(GetEntityIndex("ent_lastspoke"));
		}
		SAID_HI = 1;
		if ((CONGRATS_MSG))
		{
			DID_CONGRATS = 1;
			PlayAnim("critical", "eye_wipe");
			bchat_mouth_move();
			SayText("Thank you for driving the orcs away! I hope our people will return soon...");
			ScheduleDelayedEvent(2.0, "fix_anims");
		}
		if ((CONGRATS_MSG)) return;
		if ((BUSY_CHATTING)) return;
		PlayAnim("critical", "fear1");
		CHAT_STEPS = 5;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		EmitSound(GetOwner(), 0, "npc/oldvillager2.wav", 10);
		CHAT_STEP1 = "Please help us! The orcs have taken over our town!";
		CHAT_STEP2 = "Most of the town's people fled but Taol and I got trapped here.";
		CHAT_STEP3 = "I've been hiding in this room and Taol has locked himself in the room below.";
		CHAT_STEP4 = "He won't let anyone in until the orcs are gone.";
		CHAT_STEP5 = "If you slay the orcs, I'll open two of the city gates for you and perhaps we'll get to see Taol again.";
		chat_loop();
	}

	void wavend()
	{
		CONGRATS_MSG = 1;
		string NEARBY_PLAYER = /* TODO: $get_insphere */ $get_insphere("player", 512);
		if (NEARBY_PLAYER != 0)
		{
			face_speaker(NEARBY_PLAYER);
			say_hi();
		}
	}

	void fix_anims()
	{
		SetMoveAnim("idle1");
		SetIdleAnim("idle1");
		PlayAnim("critical", "idle1");
	}

}

}
