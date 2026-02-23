#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure50hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(50);
	}

}

}
