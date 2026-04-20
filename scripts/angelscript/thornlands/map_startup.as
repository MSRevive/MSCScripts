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
		MAP_NAME = "thornlands";
		MAP_WEATHER = "clear;clear;clear;storm;clear;rain";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Thornlands");
		SetGlobalVar("G_MAP_DESC", "These untamed plains and mesas form crossroads to many lands");
		SetGlobalVar("G_MAP_DIFF", "Levels 5-10 / 35-150hp");
		SetGlobalVar("G_WARN_HP", 35);
	}

}

}
