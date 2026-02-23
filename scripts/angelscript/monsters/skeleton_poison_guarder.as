#pragma context server

#include "monsters/skeleton_poison_random.as"

namespace MS
{

class SkeletonPoisonGuarder : CGameScript
{
	SkeletonPoisonGuarder()
	{
		const int POISON_TYPE = 6;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

}

}
