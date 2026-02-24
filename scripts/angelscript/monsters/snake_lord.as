#pragma context server

#include "slithar/slithar.as"

namespace MS
{

class SnakeLord : CGameScript
{
	string ANIM_RUN;
	int CYCLES_ON;
	int GENERIC_LORD;
	int LOOKING_FOR_PLAYERS;
	int NPC_GIVE_EXP;
	int SNAKE_SLOT;
	float SUMMON_SNAKE_FREQ;

	SnakeLord()
	{
		GENERIC_LORD = 1;
		NPC_GIVE_EXP = 400;
	}

	void OnSpawn() override
	{
		SetName("Snake Lord");
		SetRace("demon");
		SetHealth(3000);
		SetWidth(32);
		SetHeight(84);
		SetRoam(true);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetIdleAnim(ANIM_IDLE);
		SetHearingSensitivity(10);
		SetInvincible(false);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("holy", 1.5);
		SNAKE_SLOT = 0;
		LOOKING_FOR_PLAYERS = 0;
	}

	void npc_targetsighted()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		SUMMON_SNAKE_FREQ = 2.0;
		ANIM_RUN = ANIM_RUNFAST;
		ScheduleDelayedEvent(25.0, "snake_slowdown");
		ScheduleDelayedEvent(5.0, "summon_snake");
	}

	void cycle_up()
	{
		ANIM_RUN = ANIM_RUNFAST;
		SetMoveAnim(ANIM_RUN);
		SUMMON_SNAKE_FREQ = 5.0;
	}

	void cycle_down()
	{
		SUMMON_SNAKE_FREQ = 30.0;
	}

	void look_for_players()
	{
		LOOKING_FOR_PLAYERS = 0;
	}

	void me_pouncie()
	{
	}

}

}
