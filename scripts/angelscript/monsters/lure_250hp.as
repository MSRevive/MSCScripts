#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure250hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(250);
	}

}

}
