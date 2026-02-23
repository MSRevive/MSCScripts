#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure100hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(100);
	}

}

}
