#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ww1";
		const string MAP_WEATHER = "clear;clear;rain;clear;clear;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "World Walker - Series One, Part I by Crow");
		SetGlobalVar("G_MAP_DESC", "The First of three gauntlet maps: Entrance to the tomb of Sir Geric");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 200-500hp");
		SetGlobalVar("G_WARN_HP", 200);
	}

}

}
