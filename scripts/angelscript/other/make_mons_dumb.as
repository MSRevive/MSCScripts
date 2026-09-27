#pragma context server

namespace MS
{

class MakeMonsDumb : CGameScript
{
	void OnSpawn() override
	{
		SetGlobalVar("NO_ADVANCED_SEARCHES", 1);
	}

}

}
