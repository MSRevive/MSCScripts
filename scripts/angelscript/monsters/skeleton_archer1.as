#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher1 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcher1()
	{
		NPC_GIVE_EXP = 24;
		const int DMG_ARROW = 5;
		const int DMG_SWIPE = 3;
		const string SKELE_START_LIVES = RandomInt(1, 4);
		const string SKELE_GOLD = RandomInt(1, 10);
		const int C_SKELE_PUSH_STRENGTH = 0;
	}

	void skele_spawn()
	{
		SetName("Skeletal Archer");
		SetHealth(80);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 0);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
