#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher2 : CGameScript
{
	int C_SKELE_PUSH_STRENGTH;
	int DMG_ARROW;
	int DMG_SWIPE;
	int NPC_GIVE_EXP;
	int SKELE_GOLD;
	int SKELE_START_LIVES;

	SkeletonArcher2()
	{
		NPC_GIVE_EXP = 200;
		DMG_ARROW = 75;
		DMG_SWIPE = 30;
		SKELE_GOLD = 25;
		SKELE_START_LIVES = RandomInt(1, 2);
		C_SKELE_PUSH_STRENGTH = 100;
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
