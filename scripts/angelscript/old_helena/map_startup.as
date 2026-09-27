#pragma context server

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		SetGlobalVar("G_NO_DROP", 1);
		SetGlobalVar("G_EXP_MULTI", 1);
		SetGlobalVar("G_SIEGE_MAP", 1);
	}

}

}
