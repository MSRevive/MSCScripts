#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ms_underworldv2";
		const string MAP_WEATHER = "fog_red;fog_red;fog_red;fog_red;fog_red;fog_red";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Underworld");
		SetGlobalVar("G_MAP_DESC", "An old MS 1.35 map, converted for MS:C");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-20 / 200-400hp");
		SetGlobalVar("G_WARN_HP", 200);
		SetGlobalVar("G_FORCE_SPAWN_WEATHER", "fog_red");
	}

}

}
