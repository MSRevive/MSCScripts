#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "skycastle";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Sky Castle by Crow");
		SetGlobalVar("G_MAP_DESC", "The once hollowed home of the fallen Bear Gods.");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-35 / 300-500hp");
		SetGlobalVar("G_WARN_HP", 300);
	}

}

}
