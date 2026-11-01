#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class MummiesGetup : CGameScript
{
	void OnSpawn() override
	{
		CallExternal("all", "mummy_getup_now");
	}

}

}
