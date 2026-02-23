#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"

namespace MS
{

class Guard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string NO_STUCK_CHECKS;
	string TRAVEL_HOME_TIME;

	Guard()
	{
		ATTACK_MOVERANGE = 32;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.85;
		ANIM_DEATH = "death";
		const int ATTACK_DAMAGE = 50;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_IDLE = "idle";
		const int BG_MAX_HEAR_CIV = 1024;
		const float ATTACK_HITCHANCE = 0.85;
	}

	void OnSpawn() override
	{
		SetHealth(700);
		SetGold(10);
		SetName("Gate City Guard");
		SetFOV(359);
		SetWidth(32);
		SetHeight(64);
		SetRace("hguard");
		SetRoam(false);
		if (StringToLower(GetMapName()) == "gatecity")
		{
			SetMonsterClip(0);
			SetStepSize(256);
		}
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 3);
		SetMoveAnim("walk");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumour", "rumour");
		CatchSpeech("say_mayor", "mayor");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_hi()
	{
		SayText("Welcome to Gate City , Adventurer!");
	}

	void say_job()
	{
		SayText("I have no work for you. However...");
		ScheduleDelayedEvent(3, "say_rumour");
	}

	void say_rumour()
	{
		SayText("The [mayor] is looking for some help. Why not pay him a visit?");
	}

	void say_mayor()
	{
		SayText("The mayor can be found inside his office in the town hall.");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > TRAVEL_HOME_TIME)) return;
		TRAVEL_HOME_TIME = GetGameTime();
		TRAVEL_HOME_TIME += 3.0;
		if (Distance(NPC_HOME_LOC, GetMonsterProperty("origin")) > 32)
		{
			NO_STUCK_CHECKS = 0;
			npcatk_walk();
			npcatk_setmovedest(NPC_HOME_LOC, 10);
		}
		else
		{
			SetRoam(false);
			NO_STUCK_CHECKS = 1;
			SetAngles("face");
		}
	}

	void cycle_up()
	{
		NO_STUCK_CHECKS = 0;
	}

	void civilian_attacked()
	{
		string OFFENDER = param1;
		if (!(GetEntityRace(OFFENDER) != "hguard")) return;
		if (!(GetEntityRange(OFFENDER) <= BG_MAX_HEAR_CIV)) return;
		if (!(m_hAttackTarget == "unset")) return;
		NO_STUCK_CHECKS = 0;
		npcatk_settarget(param1);
		if (!(false)) return;
		SetSayTextRange(1024);
		string RAND_HALT = RandomInt(1, 4);
		if (RAND_HALT == 1)
		{
			SayText("Hey you! Leave him alone!");
		}
		if (RAND_HALT == 2)
		{
			SayText("You there , leave him be I said!");
		}
		if (RAND_HALT == 3)
		{
			SayText("Stop that!");
		}
		if (RAND_HALT == 4)
		{
			SayText("Halt! We ll have no trouble making around here!");
		}
	}

}

}
