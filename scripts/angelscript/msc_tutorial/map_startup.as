#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "tutorial";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Tutorial map by Dridje");
		SetGlobalVar("G_MAP_DESC", "A quick tutorial map for new MSC players.");
		SetGlobalVar("G_MAP_DIFF", "(Easy)");
		SetGlobalVar("G_WARN_HP", 0);
	}

}

}
