#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class CorpseOnce : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	CorpseOnce()
	{
		const int SKEL_HP = 100;
		const float ATTACK_HITCHANCE = 0.7;
		const int ATTACK_DAMAGE_LOW = 4;
		const int ATTACK_DAMAGE_HIGH = 5;
		NPC_GIVE_EXP = 35;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 2;
		DROP_GOLD_MAX = 9;
	}

	void skeleton_spawn()
	{
		SetName("Awakened Guardian");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(1, 0);
	}

}

}
