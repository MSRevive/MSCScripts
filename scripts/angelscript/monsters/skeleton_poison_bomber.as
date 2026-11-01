#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoisonBomber : CGameScript
{
	int POISON_TYPE;

	SkeletonPoisonBomber()
	{
		POISON_TYPE = 3;
	}

}

}
