#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "keledrosruins";
		const string MAP_WEATHER = "clear;snow;clear;storm;rain;rain";
		const int MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "Keledros Palace");
		SetGlobalVar("G_MAP_DESC", "The insane wizard Keledros has made his home here. Woe to those who find it.");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-25 / 250-400hp");
		SetGlobalVar("G_WARN_HP", 250);
	}

}

}
