#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure200hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(200);
	}

}

}
