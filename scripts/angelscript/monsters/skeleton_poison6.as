#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoison6 : CGameScript
{
	int POISON_TYPE;

	SkeletonPoison6()
	{
		POISON_TYPE = 6;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

}

}
