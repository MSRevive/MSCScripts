#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonOnce : CGameScript
{
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;

	SkeletonOnce()
	{
		SKEL_HP = 40;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE_LOW = 0.9;
		ATTACK_DAMAGE_HIGH = 2.7;
		NPC_GIVE_EXP = 16;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 1;
		DROP_GOLD_MAX = 3;
	}

	void skeleton_spawn()
	{
		SetName("Skeleton Warrior");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(1, 0);
	}

}

}
