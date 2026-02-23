#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Livingdead : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	Livingdead()
	{
		const int SKEL_HP = 120;
		const float ATTACK_HITCHANCE = 0.7;
		const int ATTACK_DAMAGE_LOW = 4;
		const int ATTACK_DAMAGE_HIGH = 7;
		NPC_GIVE_EXP = 40;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 9;
		const float SKEL_RESPAWN_CHANCE = 0.75;
		const int SKEL_RESPAWN_LIVES = 2;
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
