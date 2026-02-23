#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "helena";
		const string MAP_WEATHER = "clear;clear;clear;rain;rain;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Town of Helena");
		SetGlobalVar("G_MAP_DESC", "This provincial village is in constant danger of attack.");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-15 / 100-250hp");
		SetGlobalVar("G_WARN_HP", 100);
	}

}

}
