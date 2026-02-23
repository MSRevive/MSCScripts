#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "tutorial";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		SetGlobalVar("global.map.allownight", 0);
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_NO_STEP_ADJ", 1);
	}

}

}
