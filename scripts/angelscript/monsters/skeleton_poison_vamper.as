#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoisonVamper : CGameScript
{
	int POISON_TYPE;

	SkeletonPoisonVamper()
	{
		POISON_TYPE = 2;
	}

}

}
