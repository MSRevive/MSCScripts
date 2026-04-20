#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Rudolf : CGameScript
{
	string ANIM_DEATH;
	string ANIM_WALK;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_RETALIATE;
	float FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int I_GOT_MY_MACE;
	int NO_JOB;
	int NO_RUMOR;
	string QUEST_WINNER;
	int REQ_QUEST_NOTDONE;
	string SOUND_DEATH;
	int SPOKE;
	int recievedit;

	Rudolf()
	{
		CAN_ATTACK = 0;
		CAN_FLEE = 1;
		FLEE_HEALTH = 34;
		FLEE_CHANCE = 1.0;
		FLEE_DISTANCE = 1000;
		CAN_RETALIATE = 0;
		CAN_FLINCH = 1;
		FLINCH_ANIM = "llflinch";
		FLINCH_CHANCE = 0.5;
		FLINCH_DELAY = 1;
		ANIM_DEATH = "dieforward";
		SOUND_DEATH = "player/stomachhit1.wav";
		ANIM_WALK = "run";
		NO_RUMOR = 1;
		NO_JOB = 1;
	}

	void OnSpawn() override
	{
		REQ_QUEST_NOTDONE = 1;
		SetHealth(35);
		SetName("Scared Rudolf");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(5, 3);
		SetAngles("face");
		recievedit = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_what", "hammer");
		CatchSpeech("say_where", "where");
		CatchSpeech("say_thank", "thank");
		CatchSpeech("say_reward", "gold");
		CatchSpeech("say_thing", "things");
	}

	void say_hi()
	{
		if ((IS_FLEEING)) return;
		if ((I_GOT_MY_MACE)) return;
		SayText("Please help me , " + I + " lost my very valuable mace! Please recover it!");
		ScheduleDelayedEvent(3, "say_hi2");
		SPOKE = 1;
	}

	void say_hi2()
	{
		SayText(.....I + "was venturing in the caves...I think " + I + " remember where...");
		ScheduleDelayedEvent(4, "say_hi3");
		PlayAnim("once", "panic");
	}

	void say_hi3()
	{
		SayText("All of a sudden , a bunch of things attacked me! " + I + "ran out as fast as " + I + " could...");
		ScheduleDelayedEvent(4, "say_hi4");
		PlayAnim("once", "panic");
	}

	void say_hi4()
	{
		SayText("When " + I + "came back out , " + I + " realized my mace was gone!");
		PlayAnim("once", "beatdoor");
		ScheduleDelayedEvent(4, "say_hi5");
	}

	void say_hi5()
	{
		SayText("It was a family heirloom...!");
		PlayAnim("once", "crouch_idle");
	}

	void say_where()
	{
		SayText("Well , you enter in here , then go across the bridge , then a right...");
		ScheduleDelayedEvent(3, "say_where2");
		if ((recievedit)) return;
		SayText("There ll will be those things... I hope you re strong enough... here , take these.");
		// TODO: offer ent_lastspoke health_mpotion
		// TODO: offer ent_lastspoke item_torch
		recievedit = 1;
	}

	void say_thank()
	{
		SayText("Good luck!");
	}

	void say_what()
	{
		SayText("Yes , " + I + "lost my mace , please help me find it. " + I + "think " + I + " remember where..");
		ScheduleDelayedEvent(3, "say_what2");
		PlayAnim("once", "eye_wipe");
	}

	void say_what2()
	{
		SayText(I + " ll be happy to reward you!");
		PlayAnim("once", "idle2");
	}

	void say_reward()
	{
		SayText(I + " ll give you gold! Please, no more talking, find my mace!");
		PlayAnim("once", "llflinch");
	}

	void say_thing()
	{
		SayText("There were about 4 things that attacked me!");
		PlayAnim("once", "fear");
		ScheduleDelayedEvent(2, "say_thing2");
	}

	void say_thing2()
	{
		SayText("You ll probably have to kill them all to find my mace");
		PlayAnim("once", "fear");
	}

	void give_mace()
	{
		ReceiveOffer("accept");
		PlayAnim("once", "eye_wipe");
		SayText(THANK + YOU!!!);
		QUEST_WINNER = param1;
		ScheduleDelayedEvent(2, "recvmace_2");
	}

	void recvmace_2()
	{
		I_GOT_MY_MACE = 1;
		SayText("As " + I + " promised you...");
		// TODO: offer QUEST_WINNER bows_crossbow_light
		ScheduleDelayedEvent(3, "recvmace_3");
		if (!(ItemExists(QUEST_WINNER, "item_ring"))) return;
		string RQUEST_STAGE = GetPlayerQuestData(QUEST_WINNER, "r");
		if (!(RQUEST_STAGE == 4)) return;
		ScheduleDelayedEvent(0.1, "ring_comment");
	}

	void ring_comment()
	{
		SayText("Nice ring by the way! You know , " + I + " think Vadrel used to have one just like it!");
		SetPlayerQuestData(QUEST_WINNER, "r");
		REQ_QUEST_NOTDONE = 0;
	}

	void recvmace_3()
	{
		SayText("Goodbye now! " + I + " must hurry!");
		SetMoveDest(Vector3(-3101, 351, 64));
		ScheduleDelayedEvent(5, "rudolfdelete");
	}

	void rudolfdelete()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void game_menu_getoptions()
	{
		if (SAY_SPOKE == 1)
		{
			string reg.mitem.title = "Mace?";
			string reg.mitem.type = "say";
			string reg.mitem.data = "Mace?";
			string reg.mitem.title = "Where?";
			string reg.mitem.type = "say";
			string reg.mitem.data = "Where?";
			string reg.mitem.title = "Say thanks";
			string reg.mitem.type = "say";
			string reg.mitem.data = "Thank you!";
			string reg.mitem.title = "Reward?";
			string reg.mitem.type = "say";
			string reg.mitem.data = "What do I get out of it?";
			string reg.mitem.title = "Things?";
			string reg.mitem.type = "say";
			string reg.mitem.data = "What about those things?";
		}
		if ((ItemExists(param1, "blunt_rudolfsmace")))
		{
			string reg.mitem.title = "Return mace";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "blunt_rudolfsmace";
			string reg.mitem.callback = "give_mace";
		}
		if ((ItemExists(param1, "item_ring")))
		{
			string RQUEST_STAGE = GetPlayerQuestData(param1, "r");
			if (RQUEST_STAGE == 5)
			{
				string reg.mitem.title = "Ask about the ring";
				string reg.mitem.type = "callback";
				string reg.mitem.data = RQUEST_STAGE;
				string reg.mitem.callback = "ring_comment";
			}
		}
		if ("RudolfQuest" == 1)
		{
			string reg.mitem.title = "Ask about Drayke";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "ask_drayke";
			string reg.mitem.callback = "ask_drayke";
		}
	}

	void ask_drayke()
	{
		SayText(AUUUUUGH!);
	}

}

}
