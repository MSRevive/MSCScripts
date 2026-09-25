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
		MAP_NAME = "nashalrath";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Temple of Nashalrath");
		SetGlobalVar("G_MAP_DESC", "An ancient labrynth once belonging to The Lost.");
		SetGlobalVar("G_MAP_DIFF", "Levels 30-40 / 500-800hp");
		SetGlobalVar("G_WARN_HP", 500);
	}

}

}
