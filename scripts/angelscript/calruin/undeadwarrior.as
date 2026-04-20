#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Undeadwarrior : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;

	Undeadwarrior()
	{
		SKEL_HP = 350;
		ATTACK_HITCHANCE = 1.0;
		ATTACK_DAMAGE_LOW = 10;
		ATTACK_DAMAGE_HIGH = 13;
		NPC_GIVE_EXP = 80;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 19;
		SKEL_RESPAWN_CHANCE = 0.75;
		SKEL_RESPAWN_LIVES = 3;
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
