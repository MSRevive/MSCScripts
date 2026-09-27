#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure1000hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(1000);
	}

}

}
