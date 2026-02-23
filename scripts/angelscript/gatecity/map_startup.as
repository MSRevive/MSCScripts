#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "gatecity";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Gatecity");
		SetGlobalVar("G_MAP_DESC", "This Dwarven capital is carved deep inside the mountains.");
		SetGlobalVar("G_MAP_DIFF", "Levels 10-25 / 100-400hp");
		SetGlobalVar("G_WARN_HP", 100);
		SetGlobalVar("G_NO_STEP_ADJ", 1);
	}

	void game_newlevel()
	{
		SetGlobalVar("global.map.allownight", 0);
	}

}

}
