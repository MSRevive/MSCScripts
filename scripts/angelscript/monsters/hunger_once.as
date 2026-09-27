#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class HungerOnce : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;
	int SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	HungerOnce()
	{
		SKEL_HP = 70;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE_LOW = 0.9;
		ATTACK_DAMAGE_HIGH = 10;
		NPC_GIVE_EXP = 50;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 7;
		SKEL_RESPAWN_CHANCE = 0;
		SKEL_RESPAWN_LIVES = 0;
	}

	void skeleton_spawn()
	{
		SetName("Hungry Skeleton");
		SetMoveSpeed(2);
		SetRoam(true);
		SetHearingSensitivity(3);
		SetBloodType("none");
	}

}

}
