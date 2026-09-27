#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure500hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(500);
	}

}

}
