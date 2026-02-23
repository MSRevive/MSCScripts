#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "challs";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
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
