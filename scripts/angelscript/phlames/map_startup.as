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
		Precache("fire1_fixed2.spr");
		Precache("fire1_fixed.spr");
		MAP_NAME = "phlames";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Phlames Fortress by Caluminium");
		SetGlobalVar("G_MAP_DESC", "The occupants of this Fortress make great use of the fire influence within.");
		SetGlobalVar("G_MAP_DIFF", "Levels 35-45 / HP 800+");
		SetGlobalVar("G_WARN_HP", 800);
	}

}

}
