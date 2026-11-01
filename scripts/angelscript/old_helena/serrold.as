#pragma context server

#include "monsters/base_chat.as"
#include "monsters/base_npc.as"
#include "old_helena/base_old_helena_npc.as"

namespace MS
{

class Serrold : CGameScript
{
	int CAN_RUN;
	int CAN_SCREAM;
	int DID_CATAPULT_COMMENT;
	int DID_GREET;
	int GAVE_MONEY;
	int GAVE_REWARD;
	int HELENA_SAVED;
	int INN_CLOSED;
	int NO_JOB;
	string PREF_LOCATION;
	int RETURN_PREF;
	int SEE_ENEMY;

	Serrold()
	{
		NO_JOB = 1;
		PREF_LOCATION = Vector3(64, 176, 0);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(20.0);
		if (!(DID_GREET))
		{
			if ((false))
			{
			}
			SetMoveDest(m_hLastSeen);
			ScheduleDelayedEvent(1.0, "greet_players");
		}
		if ((RETURN_PREF))
		{
		}
		if (!(HELENA_SAVED))
		{
		}
		LogDebug("moving to PREF_LOCATION");
		SetMoveAnim("run1");
		SetIdleAnim("crouch_idle");
		SetMoveDest(PREF_LOCATION);
	}

	void OnSpawn() override
	{
		SetHealth(800);
		SetGold(2);
		SetName("Serrold");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 0);
		INN_CLOSED = 0;
		SEE_ENEMY = 0;
		CAN_SCREAM = 1;
		CAN_RUN = 1;
		GAVE_MONEY = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_orcs", "orcs");
		CatchSpeech("say_rumor", "people");
		CatchSpeech("say_dorfgan", "dorfgan");
		CatchSpeech("say_erkold", "erkold");
		CatchSpeech("say_serrold", "serrold");
		CatchSpeech("say_harry", "harry");
		CatchSpeech("say_thanks", "ok");
		CatchSpeech("say_thanks", "okay");
		CatchSpeech("say_thanks", "sure");
	}

	void game_postspawn()
	{
		SetGlobalVar("G_SIEGE_MAP", 1);
		SetGlobalVar("G_NPC_REMAIN", 5);
	}

	void greet_players()
	{
		DID_GREET = 1;
		SetVolume(10);
		ScheduleDelayedEvent(0.1, "bchat_mouth_move");
		ScheduleDelayedEvent(1.0, "bchat_mouth_move");
		ScheduleDelayedEvent(4.0, "bchat_mouth_move");
		ScheduleDelayedEvent(6.0, "bchat_mouth_move");
		ScheduleDelayedEvent(8.0, "bchat_mouth_move");
		ScheduleDelayedEvent(10.0, "goto_pref");
		ScheduleDelayedEvent(5.0, "map_go");
	}

	void map_go()
	{
		UseTrigger("MSmm");
	}

	void goto_pref()
	{
		RETURN_PREF = 1;
		SetMoveAnim("run1");
		SetIdleAnim("crouch_idle");
		ScheduleDelayedEvent(20.0, "tele_pref");
	}

	void talksound1()
	{
		EmitSound(GetOwner(), 0, "npc/oldvillager1.wav", 10);
	}

	void say_hi()
	{
		if ((HELENA_SAVED)) return;
		PlayAnim("once", "panic");
		SayText("Please help our town! The [orcs] are attacking!");
		ScheduleDelayedEvent(2, "say_hi2");
	}

	void say_hi2()
	{
		SayText("Even if we survive the attack , we still need [people] to keep order in the town!");
	}

	void say_orcs()
	{
		PlayAnim("once", "fear1");
		SayText("Evil creatures spawned from hell!");
	}

	void say_rumor()
	{
		if ((HELENA_SAVED)) return;
		PlayAnim("once", "idle3");
		SayText("[dorfgan] , [erkold] , and myself are the only ones who can run this village! If we all die , the village will die with us!");
	}

	void say_dorfgan()
	{
		PlayAnim("once", "yes");
		SayText("The blacksmith. He is a good man , not even in times like this does he stop forgeing!");
	}

	void say_erkold()
	{
		PlayAnim("once", "yes");
		SayText("The man at the burnt down house. He and his family used to supply the village with food , but " + I + " am not sure how it will go now when the family has been kidnapped..");
	}

	void say_serrold()
	{
		PlayAnim("once", "yes");
		SayText(I + " am Serrold , the town elder.");
	}

	void say_harry()
	{
		PlayAnim("once", "no");
		SayText("That man is good for nothing. " + I + "closed down his Inn but " + I + " still get the feeling that something is going on in there..");
	}

	void say_thanks()
	{
		PlayAnim("once", "yes");
		SayText("Thank you! Now go out and kick some green butt!");
	}

	void old_helena_warboss_died()
	{
		SetMenuAutoOpen(1);
		HELENA_SAVED = 1;
		SetIdleAnim("idle1");
	}

	void game_menu_getoptions()
	{
		if (!(HELENA_SAVED)) return;
		if ((GAVE_REWARD)) return;
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "give_reward";
	}

	void give_reward()
	{
		if ((GAVE_REWARD))
		{
			PlayAnim("critical", "lean");
			bchat_mouth_move();
			SayText(I + "wish " + I + "had more to give , but " + I + " ll need what s left to help rebuild the town.");
		}
		if ((GAVE_REWARD)) return;
		GAVE_REWARD = 1;
		bchat_mouth_move();
		SayText(I + " can t believe it! You saved us! Take this as a reward!");
		// TODO: offer PARAM1 pack_boh_lesser
	}

	void catapults_fire()
	{
		if (!(DID_CATAPULT_COMMENT)) return;
		DID_CATAPULT_COMMENT = 1;
		SayText("By the gods! They ve brought siege weapons!");
	}

	void game_reached_dest()
	{
		SetAngles("face");
	}

	void tele_pref()
	{
		SetEntityOrigin(GetOwner(), PREF_LOCATION);
		SetIdleAnim("crouch_idle");
	}

}

}
