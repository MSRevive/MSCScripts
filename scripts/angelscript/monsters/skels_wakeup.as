#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class SkelsWakeup : CGameScript
{
	void OnSpawn() override
	{
		CallExternal("all", "skeleton_wakeup_call");
	}

}

}
