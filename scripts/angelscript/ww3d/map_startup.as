#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ww3d";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "World Walker - Series One, Finale by Crow");
		SetGlobalVar("G_MAP_DESC", "The lower catacombs and the tomb Sir Geric.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-30 / 200-600hp");
		SetGlobalVar("G_WARN_HP", 200);
	}

}

}
