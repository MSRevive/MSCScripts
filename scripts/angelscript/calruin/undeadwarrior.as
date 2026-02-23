#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Undeadwarrior : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	Undeadwarrior()
	{
		const int SKEL_HP = 350;
		const float ATTACK_HITCHANCE = 1.0;
		const int ATTACK_DAMAGE_LOW = 10;
		const int ATTACK_DAMAGE_HIGH = 13;
		NPC_GIVE_EXP = 80;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 19;
		const float SKEL_RESPAWN_CHANCE = 0.75;
		const int SKEL_RESPAWN_LIVES = 3;
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
