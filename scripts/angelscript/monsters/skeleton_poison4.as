#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoison4 : CGameScript
{
	int POISON_TYPE;

	SkeletonPoison4()
	{
		POISON_TYPE = 4;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

}

}
