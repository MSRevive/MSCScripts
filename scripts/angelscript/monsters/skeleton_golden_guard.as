#pragma context server

#include "calruin/cavetroll.as"

namespace MS
{

class SkeletonGoldenGuard : CGameScript
{
	SkeletonGoldenGuard()
	{
		const int FORCE_GERIC = 1;
		const int NPC_BASE_EXP = 1000;
	}

	void OnPostSpawn() override
	{
		SetModelBody(0, 11);
	}

}

}
