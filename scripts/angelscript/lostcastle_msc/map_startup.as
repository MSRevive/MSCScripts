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
		MAP_NAME = "lostcastle_msc";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Lost Castle by Crow");
		SetGlobalVar("G_MAP_DESC", "The undead guardians of the Bear Gods dwell in this cursed castle.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 150-400hp");
		SetGlobalVar("G_WARN_HP", 150);
	}

}

}
