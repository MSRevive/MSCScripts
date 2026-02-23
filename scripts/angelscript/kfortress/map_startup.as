#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "kfortress";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Kharaztorant Fortress");
		SetGlobalVar("G_MAP_DESC", "You've found what is rumored to be a fortress of the dragon worshipper's cult");
		SetGlobalVar("G_MAP_DIFF", "Levels 30-40 / 600-800hp");
		SetGlobalVar("G_WARN_HP", 600);
	}

}

}
