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
		MAP_NAME = "highlands_msc";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Highlands by Crow");
		SetGlobalVar("G_MAP_DESC", "These tall mesas hold many secrets and many orcs.");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 150-400hp");
		SetGlobalVar("G_WARN_HP", 150);
	}

}

}
