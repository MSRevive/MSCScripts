#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Slave : CGameScript
{
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ASKED_OK;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	int CHAT_STEPS;
	int DEAD_MASTER;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string NPC_MODEL;

	Slave()
	{
		NPC_MODEL = "npc/human1.mdl";
		ANIM_IDLE = "crouch_idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		Precache(NPC_MODEL);
		NO_JOB = 1;
		NO_RUMOR = 1;
		ASKED_OK = 0;
		NO_HAIL = 1;
	}

	void OnSpawn() override
	{
		SetName("Doran");
		SetHealth(1);
		SetInvincible(true);
		SetNoPush(true);
		SetRace("beloved");
		SetModel(NPC_MODEL);
		SetModelBody(0, 4);
		SetModelBody(1, 5);
		SetWidth(30);
		SetHeight(96);
		SetSayTextRange(1024);
		// TODO: menu.autopen 1
		ScheduleDelayedEvent(0.1, "be_scared");
	}

	void be_scared()
	{
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
	}

	void game_menu_getoptions()
	{
		if ((ASKED_OK)) return;
		if ((DEAD_MASTER))
		{
			string reg.mitem.title = "Are you okay?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ok";
		}
	}

	void say_ok()
	{
		ANIM_IDLE = "idle1";
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_IDLE);
		if ((IsValidPlayer(param1)))
		{
			face_speaker(GetEntityIndex(param1));
		}
		if ((IsValidPlayer("ent_lastspoke")))
		{
			face_speaker(GetEntityIndex("ent_lastspoke"));
		}
		CHAT_STEPS = 5;
		CHAT_STEP = 0;
		CHAT_STEP1 = "Yes, I'm fine now, adventurer.";
		CHAT_STEP2 = "Thanks to you.";
		CHAT_STEP3 = "...There is way out of here.";
		CHAT_STEP4 = "I believe there is a secret passage in the, er, LATE slave master's hut.";
		CHAT_STEP5 = "There's a cage in there I've never seen him use, and a cool wind that blows from it.";
		chat_loop();
		ASKED_OK = 1;
	}

	void slavemaster_dies()
	{
		DEAD_MASTER = 1;
	}

}

}
