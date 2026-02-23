#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Corpse : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	Corpse()
	{
		const int SKEL_HP = 100;
		const float ATTACK_HITCHANCE = 0.7;
		const int ATTACK_DAMAGE_LOW = 4;
		const int ATTACK_DAMAGE_HIGH = 5;
		NPC_GIVE_EXP = 35;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 2;
		DROP_GOLD_MAX = 9;
		const float SKEL_RESPAWN_CHANCE = 0.75;
		const int SKEL_RESPAWN_LIVES = 3;
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
