#pragma context server

#include "monsters/debug.as"

namespace MS
{

class TouchTest : CGameScript
{
	TouchTest()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
	}

	void game_used()
	{
		LogDebug("used by GetEntityName(param1) GetEntityName(param2) PARAM3 PARAM4");
	}

}

}
