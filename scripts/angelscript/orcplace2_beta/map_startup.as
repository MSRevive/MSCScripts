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
		MAP_NAME = "orcplace_msc";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Orc Place");
		SetGlobalVar("G_MAP_DESC", "This is a secret orcish stronghold");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-30 / 300-500hp");
		SetGlobalVar("G_WARN_HP", 300);
	}

}

}
