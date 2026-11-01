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
		MAP_NAME = "b_castle";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Castle by P.Barnum");
		SetGlobalVar("G_MAP_DESC", "The warriors of this cursed castle are animated by an ancient magic.");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-35 / 450-700hp");
		SetGlobalVar("G_WARN_HP", 450);
	}

}

}
