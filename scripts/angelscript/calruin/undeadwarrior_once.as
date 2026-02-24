#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class UndeadwarriorOnce : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;

	UndeadwarriorOnce()
	{
		SKEL_HP = 350;
		ATTACK_HITCHANCE = 1.0;
		ATTACK_DAMAGE_LOW = 10;
		ATTACK_DAMAGE_HIGH = 13;
		NPC_GIVE_EXP = 80;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 19;
	}

	void skeleton_spawn()
	{
		SetName("Fallen Knight");
		SetRoam(true);
		SetHearingSensitivity(6);
		SetModelBody(1, 0);
	}

}

}
