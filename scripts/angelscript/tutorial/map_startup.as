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
		MAP_NAME = "tutorial";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		SetGlobalVar("global.map.allownight", 0);
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_NO_STEP_ADJ", 1);
	}

}

}
