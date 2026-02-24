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
		MAP_NAME = "ms_snow";
		MAP_WEATHER = "snow;snow;snow";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Frozen Summit by Avoozl & P.Barnum");
		SetGlobalVar("G_MAP_DESC", "Great evil lies in the frozen North. Its cold tendrils have sapped this once rich land.");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-35 / 400-700hp");
		SetGlobalVar("G_WARN_HP", 400);
		SetGlobalVar("G_NO_STEP_ADJ", 1);
	}

}

}
