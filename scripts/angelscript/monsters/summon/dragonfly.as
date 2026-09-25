#pragma context server

#include "monsters/dragonfly.as"

namespace MS
{

class Dragonfly : CGameScript
{
	string ATTACK_DAMAGE;
	string FIRST_TARGET;
	string MY_DURATION;
	string MY_OWNER;
	int NPC_GIVE_EXP;
	string SUMMON_HP;

	Dragonfly()
	{
	}

	void OnSpawn() override
	{
		SetName("Dragonfly Spawn");
		SetModel("monsters/dragonfly.mdl");
		SetFly(true);
		SetRace("demon");
		SetHealth(30);
		SetWidth(24);
		SetHeight(24);
		SetHearingSensitivity(2);
		SetVolume(5);
		SetRoam(true);
		SetDamageResistance("pierce", 0.5);
		SetMonsterClip(0);
		NPC_GIVE_EXP = 10;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void OnPostSpawn() override
	{
		SetHealth(SUMMON_HP);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		ATTACK_DAMAGE = param2;
		SUMMON_HP = param3;
		MY_DURATION = param4;
		FIRST_TARGET = param5;
		ScheduleDelayedEvent(1.5, "set_firstarg");
		MY_DURATION("fade_out");
	}

	void set_firstarg()
	{
		npcatk_settarget(FIRST_TARGET);
	}

	void fade_out()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
