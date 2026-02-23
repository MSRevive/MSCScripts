#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "sfor";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Dark Forest");
		SetGlobalVar("G_MAP_DESC", "This forest remains cursed by the power of the fallen Lord Undamael");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-15 / 75-200hp");
		SetGlobalVar("G_WARN_HP", 75);
	}

}

}
