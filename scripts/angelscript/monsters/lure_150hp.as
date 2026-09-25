#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure150hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(150);
	}

}

}
