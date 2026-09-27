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
		MAP_NAME = "nightmare_thornlands";
		MAP_WEATHER = "clear;clear;clear;snow;clear;snow";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Nightmare Thornlands");
		SetGlobalVar("G_MAP_DESC", "This is the realm of Thornlands as it will be if Lor Malgorand is not stopped.");
		SetGlobalVar("G_MAP_DIFF", "Levels 30-35 / 400-700hp");
		SetGlobalVar("G_WARN_HP", 400);
	}

}

}
