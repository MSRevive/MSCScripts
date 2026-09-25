#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class EndSiege : CGameScript
{
	int G_SIEGE_MAP;

	EndSiege()
	{
	}

	void OnSpawn() override
	{
		SetGlobalVar("G_CRITICAL_NPCS", "");
		G_SIEGE_MAP = 0;
	}

}

}
