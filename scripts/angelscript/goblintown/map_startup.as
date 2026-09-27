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
		MAP_NAME = "goblintown";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Goblin Town");
		SetGlobalVar("G_MAP_DESC", "The goblins have an extensive encampment here");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-25 / 100-400hp");
		SetGlobalVar("G_WARN_HP", 100);
	}

}

}
