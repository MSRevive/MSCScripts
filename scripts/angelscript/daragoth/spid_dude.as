#pragma context server

#include "monsters/base_npc_attack.as"
#include "monsters/base_chat.as"

namespace MS
{

class SpidDude : CGameScript
{
	int ATTACK_RANGE;
	int REQ_QUEST_NOTDONE;

	SpidDude()
	{
		const int MOVE_RANGE = 64;
		const string ANIM_WALK = "walk";
		const string ANIM_RUN = "run";
		const string ANIM_ATTACK = "beatdoor";
		const int CAN_HUNT = 0;
		const int HUNT_AGRO = 0;
		const int CAN_ATTACK = 0;
		ATTACK_RANGE = 90;
		const int CAN_FLEE = 1;
		const int FLEE_HEALTH = 25;
		const float FLEE_CHANCE = 1.0;
		const int CAN_HEAR = 1;
		const int CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		const int CAN_FLINCH = 1;
		const string FLINCH_ANIM = "flinch1";
		const float FLINCH_CHANCE = 0.5;
		const int FLINCH_DELAY = 1;
		REQ_QUEST_NOTDONE = 1;
		Precache(SOUND_IDLE1);
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
		const int NO_HAIL = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		SetVolume(2);
		Say("chitchat[.5] [.2] [.55] [.55] [.23] [.22]");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_help";
	}

	void OnSpawn() override
	{
		SetName("Narad");
		SetHealth(25);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetMenuAutoOpen(1);
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 3);
		SetMoveAnim("walk");
		CatchSpeech("say_help", "hi");
	}

	void say_help()
	{
		if (!(REQ_QUEST_NOTDONE))
		{
			SayText("Thank you very much. Hopefully you found a treat in the chest.");
		}
		if (!(REQ_QUEST_NOTDONE)) return;
		string L_SPEAKER = param1;
		if (L_SPEAKER == "PARAM1")
		{
			string L_SPEAKER = GetEntityIndex("ent_lastspoke");
		}
		face_speaker(L_SPEAKER);
		SayText("Oh, hello...can you help me?");
		ScheduleDelayedEvent(3, "say_help2");
	}

	void say_help2()
	{
		SayText("You see, I keep all of my supplies in the basement. However...");
		ScheduleDelayedEvent(3, "say_help3");
	}

	void say_help3()
	{
		SayText("Quite recently, a family of spiders seemed to have moved in.");
		UseTrigger("spawn_spiders");
		ScheduleDelayedEvent(3, "say_help4");
	}

	void say_help4()
	{
		SayText("Can you get rid of them for me? I'm afraid I have nothing of much value to give...");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void spider_chest_used()
	{
		REQ_QUEST_NOTDONE = 0;
	}

}

}
