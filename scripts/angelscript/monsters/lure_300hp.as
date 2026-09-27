#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure300hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(300);
	}

}

}
