#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class TcadaverOnce : CGameScript
{
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;

	TcadaverOnce()
	{
		const int SKEL_HP = 100;
		const float ATTACK_HITCHANCE = 0.7;
		const int ATTACK_DAMAGE_LOW = 14;
		const int ATTACK_DAMAGE_HIGH = 17;
		NPC_GIVE_EXP = 40;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 2;
		DROP_GOLD_MAX = 10;
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
	}

	void skeleton_spawn()
	{
		SetName("Fragile Knight");
		SetRoam(true);
		SetHearingSensitivity(3);
		SetModelBody(1, 0);
	}

}

}
