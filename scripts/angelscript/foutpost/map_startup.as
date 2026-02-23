#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "foutpost";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Forgotten Outpost by Evil Squirrel");
		SetGlobalVar("G_MAP_DESC", "This outpost holds by a thread against an impending orc invasion");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-35 / 300-700hp");
		SetGlobalVar("G_WARN_HP", 300);
	}

}

}
