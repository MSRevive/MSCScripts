#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class LivingdeadOnce : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;

	LivingdeadOnce()
	{
		SKEL_HP = 120;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE_LOW = 4;
		ATTACK_DAMAGE_HIGH = 7;
		NPC_GIVE_EXP = 40;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 9;
	}

	void skeleton_spawn()
	{
		SetName("Living Dead");
		SetRoam(true);
		SetHearingSensitivity(4);
		SetModelBody(1, 0);
	}

}

}
