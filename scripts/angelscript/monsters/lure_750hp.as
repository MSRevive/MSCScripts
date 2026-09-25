#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure750hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(750);
	}

}

}
