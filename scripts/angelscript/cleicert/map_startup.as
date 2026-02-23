#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "cleicert";
		const string MAP_WEATHER = "clear";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The cleicert Temple by Dridje");
		SetGlobalVar("G_MAP_DESC", "This elemental temple imprisons a great evil.");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-35 / 400-700hp");
		SetGlobalVar("G_WARN_HP", 400);
	}

}

}
