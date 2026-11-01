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
		MAP_NAME = "challs";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Halls of Charthane");
		SetGlobalVar("G_MAP_DESC", "Once a hall of heroes, now a den of evi.l");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-25 / 200-450hp");
		SetGlobalVar("G_WARN_HP", 200);
	}

	void game_newlevel()
	{
		SetGlobalVar("global.map.allownight", 0);
	}

}

}
