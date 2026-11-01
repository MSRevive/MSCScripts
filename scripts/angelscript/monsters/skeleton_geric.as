#pragma context server

#include "calruin/cavetroll.as"

namespace MS
{

class SkeletonGeric : CGameScript
{
	int FORCE_GERIC;
	float NPC_BOSS_REGEN_RATE;
	int NPC_IS_BOSS;

	SkeletonGeric()
	{
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.05;
		FORCE_GERIC = 1;
	}

}

}
