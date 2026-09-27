#pragma context server

#include "other/lure.as"

namespace MS
{

class Lure25hp : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(25);
	}

}

}
