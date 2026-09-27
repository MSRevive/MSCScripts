#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	int MAP_ALLOWNIGHT;
	string MAP_NAME;
	string MAP_WEATHER;

	MapStartup()
	{
		MAP_NAME = "tutorial";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Tutorial map by Dridje");
		SetGlobalVar("G_MAP_DESC", "A quick tutorial map for new MSC players.");
		SetGlobalVar("G_MAP_DIFF", "(Easy)");
		SetGlobalVar("G_WARN_HP", 0);
	}

}

}
