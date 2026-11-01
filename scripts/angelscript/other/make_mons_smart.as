#pragma context server

namespace MS
{

class MakeMonsSmart : CGameScript
{
	void OnSpawn() override
	{
		SetGlobalVar("NO_ADVANCED_SEARCHES", 0);
	}

}

}
