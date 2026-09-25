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
		MAP_NAME = "shender_east";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "East Shender");
		SetGlobalVar("G_MAP_DESC", "A frozen wasteland that borders The Wall.");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-40 / 500-1250hp");
		SetGlobalVar("G_WARN_HP", 500);
		SetGlobalVar("G_MORC_CHESTS", 0);
	}

}

}
