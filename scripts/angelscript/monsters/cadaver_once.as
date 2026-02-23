#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class CadaverOnce : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	CadaverOnce()
	{
		const int SKEL_HP = 150;
		const float ATTACK_HITCHANCE = 0.7;
		const int ATTACK_DAMAGE_LOW = 14;
		const int ATTACK_DAMAGE_HIGH = 17;
		NPC_GIVE_EXP = 48;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 11;
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
	}

	void skeleton_spawn()
	{
		SetName("Ghastly Knight");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(0, 5);
		SetModelBody(1, 4);
	}

}

}
