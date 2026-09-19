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
		MAP_NAME = "skycastle";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Sky Castle by Crow");
		SetGlobalVar("G_MAP_DESC", "The once hollowed home of the fallen Bear Gods.");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-35 / 300-500hp");
		SetGlobalVar("G_WARN_HP", 300);
	}

}

}
