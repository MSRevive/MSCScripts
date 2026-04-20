#pragma context server

#include "calruin/cavetroll.as"

namespace MS
{

class SkeletonGoldenGuard : CGameScript
{
	int FORCE_GERIC;
	int NPC_BASE_EXP;

	SkeletonGoldenGuard()
	{
		FORCE_GERIC = 1;
		NPC_BASE_EXP = 1000;
	}

	void OnPostSpawn() override
	{
		SetModelBody(0, 11);
	}

}

}
