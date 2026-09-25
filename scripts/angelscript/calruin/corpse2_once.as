#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Corpse2Once : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;

	Corpse2Once()
	{
		SKEL_HP = 100;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE_LOW = 9;
		ATTACK_DAMAGE_HIGH = 11;
		NPC_GIVE_EXP = 35;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 2;
		DROP_GOLD_MAX = 11;
	}

	void skeleton_spawn()
	{
		SetName("Enraged Skeleton");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(1, 0);
	}

}

}
