#pragma context server

#include "calruin/cavetroll.as"

namespace MS
{

class SkeletonGeric : CGameScript
{
	int NPC_IS_BOSS;

	SkeletonGeric()
	{
		NPC_IS_BOSS = 1;
		const float NPC_BOSS_REGEN_RATE = 0.05;
		const int FORCE_GERIC = 1;
	}

}

}
