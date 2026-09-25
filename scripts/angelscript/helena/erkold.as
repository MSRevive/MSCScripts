#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Erkold : CGameScript
{
	int ASKED;
	int CAN_RUN;
	int CAN_SCREAM;
	int FLEE_DISTANCE;
	int FRIGHTENED;
	int NO_RUMOR;
	int QUEST_3;
	int SEE_ENEMY;

	Erkold()
	{
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(0);
		SetName("Erkold");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 2);
		FRIGHTENED = 0;
		QUEST_3 = 0;
		SEE_ENEMY = 0;
		CAN_SCREAM = 1;
		CAN_RUN = 1;
		SetBloodType("red");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_sniff", "dorfgan");
		CatchSpeech("say_job", "orc");
		CatchSpeech("say_kidnapped", "kidnapped");
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
		SetAngles("face");
	}

	void say_hi()
	{
		SayText("..*sniff* ..hi there..");
		ScheduleDelayedEvent(1, "say_sniff");
	}

	void say_job()
	{
		PlayAnim("once", "panic1");
		SayText("Don t.. talk about those..  ..they [kidnapped] my wife and children..");
	}

	void say_sniff()
	{
		if (QUEST_3 == 0)
		{
			PlayAnim("once", "eye_wipe");
			SayText("...");
		}
		if (QUEST_3 == 1)
		{
			say_quest2();
		}
		if (QUEST_3 == 2)
		{
			say_quest3();
		}
	}

	void say_kidnapped()
	{
		if (QUEST_3 == 0)
		{
			PlayAnim("once", "eye_wipe");
			SayText("The orcs.. they took my wife and children.. " + I + " don t know if they are alive..");
			ScheduleDelayedEvent(5, "say_quest1");
		}
		if (QUEST_3 == 1)
		{
			say_quest2();
		}
		if (QUEST_3 == 2)
		{
			say_quest3();
		}
	}

	void say_quest1()
	{
		SayText("Perhaps... *sniff ...you could find them for me?");
		SendInfoMsg(GetEntityIndex("ent_lastspoke"), "DEVELOPER MESSAGE: QUEST NOT FINISHED Sorry, this quest can't be completed, yet.");
		ASKED = 1;
	}

	void say_yes()
	{
		if (!(ASKED == 1)) return;
		if (QUEST_3 == 0)
		{
			SayText("You will?! Thank you! Thank you!");
			QUEST_3 = 1;
		}
		if (QUEST_3 == 1)
		{
			say_quest2();
		}
		if (QUEST_3 == 2)
		{
			say_quest3();
		}
	}

	void say_quest2()
	{
		PlayAnim("once", "eye_wipe");
		SayText("Please don t return without them...");
	}

	void say_quest3()
	{
		PlayAnim("once", "eye_wipe");
		SayText("If you do not want to [help] me , then please leave! *sniff*");
	}

	void game_recvoffer_gold()
	{
		ReceiveOffer("accept");
		SayText("..thank you , but nothing.. .. can replace.. *sniff*");
		PlayAnim("once", "eye_wipe");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		FLEE_DISTANCE = 2048;
		run_away(m_hLastStruck, FLEE_DISTANCE, 15);
	}

	void run_away()
	{
		PlayAnim("once", "break");
		SetMoveDest(param1);
		SetMoveAnim("run1");
		ScheduleDelayedEvent(15, "stop_flee");
	}

	void stop_flee()
	{
		SetMoveAnim("walk_scared");
	}

}

}
