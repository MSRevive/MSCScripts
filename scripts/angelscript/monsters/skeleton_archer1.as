#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher1 : CGameScript
{
	int C_SKELE_PUSH_STRENGTH;
	int DMG_ARROW;
	int DMG_SWIPE;
	int NPC_GIVE_EXP;
	int SKELE_GOLD;
	int SKELE_START_LIVES;

	SkeletonArcher1()
	{
		NPC_GIVE_EXP = 24;
		DMG_ARROW = 5;
		DMG_SWIPE = 3;
		SKELE_START_LIVES = RandomInt(1, 4);
		SKELE_GOLD = RandomInt(1, 10);
		C_SKELE_PUSH_STRENGTH = 0;
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
