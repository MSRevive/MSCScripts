#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "orcplace_msc";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Orc Place");
		SetGlobalVar("G_MAP_DESC", "This is a secret orcish stronghold");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-30 / 300-500hp");
		SetGlobalVar("G_WARN_HP", 300);
	}

}

}
