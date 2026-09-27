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
		MAP_NAME = "ww2b";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "World Walker - Series One, Part II by Crow");
		SetGlobalVar("G_MAP_DESC", "The upper catacombs of an ancient tomb.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 200-500hp");
		SetGlobalVar("G_WARN_HP", 200);
	}

}

}
