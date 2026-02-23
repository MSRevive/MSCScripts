#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher2 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcher2()
	{
		NPC_GIVE_EXP = 200;
		const int DMG_ARROW = 75;
		const int DMG_SWIPE = 30;
		const int SKELE_GOLD = 25;
		const string SKELE_START_LIVES = RandomInt(1, 2);
		const int C_SKELE_PUSH_STRENGTH = 100;
	}

	void skele_spawn()
	{
		SetName("Elite Skeletal Archer");
		SetHealth(600);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 1);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
