#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class KillAllMonsters : CGameScript
{
	void OnSpawn() override
	{
		CallExternal("all", "npc_suicide", "no_pets");
	}

}

}
