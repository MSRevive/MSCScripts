#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoisonSworder : CGameScript
{
	SkeletonPoisonSworder()
	{
		const int POISON_TYPE = 4;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

}

}
