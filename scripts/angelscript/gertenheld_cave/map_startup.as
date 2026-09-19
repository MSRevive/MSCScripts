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
		MAP_NAME = "gertenheld_cave";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Vile Blood Goblin Caves");
		SetGlobalVar("G_MAP_DESC", "These caves are infested with the most tenacious goblins in all of daragoth");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-40 / 500-800hp");
		SetGlobalVar("G_WARN_HP", 500);
	}

}

}
