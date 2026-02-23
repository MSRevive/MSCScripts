#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "mscave";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		SetGlobalVar("global.map.allownight", 0);
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Dark Caves");
		SetGlobalVar("G_MAP_DESC", "These caves are infested with orcs, although there are rumors that they hide yet a greater evil.");
		SetGlobalVar("G_MAP_DIFF", "Levels 5-20 / 50-300hp");
		SetGlobalVar("G_WARN_HP", 50);
		SetGlobalVar("G_NO_STEP_ADJ", 1);
	}

}

}
