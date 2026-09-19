#pragma context server

#include "ms_soccer/base_soccer.as"
#include "monsters/base_monster_new.as"

namespace MS
{

class Sorc1 : CGameScript
{
	int AM_LEADER;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_KICK;
	string ANIM_ROUND_LOST1;
	string ANIM_ROUND_LOST2;
	string ANIM_ROUND_WIN1;
	string ANIM_ROUND_WIN2;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DOING_JUMP;
	int MOVE_RANGE;
	int NPC_FIGHTS_NPCS;
	string SOUND_DEATH;

	Sorc1()
	{
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_JUMP = "jump_hop";
		ANIM_KICK = "kick";
		ANIM_ATTACK = "kick";
		ANIM_ROUND_WIN1 = "warcry";
		ANIM_ROUND_WIN2 = "nod_yes";
		ANIM_ROUND_LOST1 = "neigh";
		ANIM_ROUND_LOST2 = "kneel";
		ATTACK_MOVERANGE = 20;
		MOVE_RANGE = 20;
		ATTACK_RANGE = 30;
		ATTACK_HITRANGE = 48;
		SOUND_DEATH = "voices/orc/die.wav";
		NPC_FIGHTS_NPCS = 1;
	}

	void OnSpawn() override
	{
		SetName("Soccer Sorc");
		SetModel("soccer/sorc_soccer1.mdl");
		SetWidth(32);
		SetHeight(72);
		SetHealth(400);
		SetRace("human");
		SetRoam(false);
		SetHearingSensitivity(0);
		SetModelBody(0, 3);
		SetModelBody(1, 1);
		SetModelBody(2, 0);
	}

	void setsoc_leader()
	{
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetHealth(800);
		AM_LEADER = 1;
	}

	void setsoc_def()
	{
		SetModelBody(1, 4);
	}

	void jump_start()
	{
	}

	void jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 400));
		DOING_JUMP = 1;
		ScheduleDelayedEvent(0.2, "check_boost2");
		ScheduleDelayedEvent(0.4, "check_boost2");
		ScheduleDelayedEvent(0.6, "check_boost2");
		ScheduleDelayedEvent(0.8, "check_boost2");
	}

	void check_boost2()
	{
		if (!(DOING_JUMP)) return;
		string BALL_ORG = GetEntityOrigin(BALL_ID);
		string MY_ORG = GetEntityOrigin(GetOwner());
		float BALL_FROM_GOAL = Distance(BALL_ORG, NME_GOAL_LOC);
		int KEEP_GOING = 0;
		float MY_FROM_GOAL = Distance(MY_ORG, NME_GOAL_LOC);
		if (MY_FROM_GOAL < BALL_FROM_GOAL)
		{
			int KEEP_GOING = 1;
		}
		if (GetEntityProperty(BALL_ID, "range2d") < 30)
		{
			int KEEP_GOING = 1;
		}
		if ((KEEP_GOING))
		{
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
		}
		else
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
		}
	}

	void jump_land()
	{
		DOING_JUMP = 0;
		npcatk_resume_ai();
	}

	void kick_land()
	{
		soc_kickball();
	}

}

}
