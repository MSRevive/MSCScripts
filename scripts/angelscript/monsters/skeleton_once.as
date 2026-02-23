#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonOnce : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	SkeletonOnce()
	{
		const int SKEL_HP = 40;
		const float ATTACK_HITCHANCE = 0.7;
		const float ATTACK_DAMAGE_LOW = 0.9;
		const float ATTACK_DAMAGE_HIGH = 2.7;
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
