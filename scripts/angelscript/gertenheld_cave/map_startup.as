#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "gertenheld_cave";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Vile Blood Goblin Caves");
		SetGlobalVar("G_MAP_DESC", "These caves are infested with the most tenacious goblins in all of daragoth");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 500-800hp");
		SetGlobalVar("G_WARN_HP", 500);
	}

}

}
