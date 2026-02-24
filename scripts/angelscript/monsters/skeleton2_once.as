#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Skeleton2Once : CGameScript
{
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;

	Skeleton2Once()
	{
		SKEL_HP = 70;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE_LOW = 0.9;
		ATTACK_DAMAGE_HIGH = 2.7;
		NPC_GIVE_EXP = 26;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 7;
	}

	void skeleton_spawn()
	{
		SetName("Walking Ashes");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(1, 0);
	}

}

}
