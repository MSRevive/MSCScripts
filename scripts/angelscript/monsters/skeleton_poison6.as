#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoison6 : CGameScript
{
	SkeletonPoison6()
	{
		const int POISON_TYPE = 6;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

}

}
