#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Tao : CGameScript
{
	int BUSY_CHATTING;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEPS;
	int CONGRATS_MSG;
	string DID_CONGRATS;
	int SAID_HI;

	Tao()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const float CHAT_DELAY = 3.0;
	}

	void OnSpawn() override
	{
		SetName("Tao l");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetModel("npc/human1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 0);
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
			CHAT_STEPS = 2;
			CHAT_STEP = 0;
			CHAT_STEP1 = "Thank you for bringing us the key.";
			CHAT_STEP2 = "If you find something of interest in the cellar, feel free to have that too!";
			chat_loop();
			ScheduleDelayedEvent(2.0, "fix_anims");
		}
		if ((CONGRATS_MSG)) return;
		if ((BUSY_CHATTING)) return;
		if ((IsValidPlayer(param1)))
		{
			face_speaker(GetEntityIndex(param1));
		}
		if ((IsValidPlayer("ent_lastspoke")))
		{
			face_speaker(GetEntityIndex("ent_lastspoke"));
		}
		PlayAnim("critical", "converse1");
		CHAT_STEPS = 7;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Thank you so much for killing the orcs!";
		CHAT_STEP2 = "Take anything you want from my chest as a reward.";
		CHAT_STEP3 = "If you want to continue your journey, you can travel to the forest behind the rocks but be careful...";
		CHAT_STEP4 = "...there might be more orcs near the town and in the forest too!";
		CHAT_STEP5 = "Oh, also, the town cellar door is locked and we don't have the key.";
		CHAT_STEP6 = "I think it was left in the shed near the field when the orcs attacked...";
		CHAT_STEP7 = "Please, see if you can find it for us.";
		chat_loop();
		ScheduleDelayedEvent(2.0, "fix_anims");
	}

	void dungeon()
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
		PlayAnim("once", "idle1");
	}

}

}
