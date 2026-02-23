#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "lowlands";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Curse of the Bear Gods: Lowlands by Crow & Dridje");
		SetGlobalVar("G_MAP_DESC", "Foglund has been cursed by the Bear Gods. Can you save him?");
		SetGlobalVar("G_MAP_DIFF", "Levels 15-20 / 200-300hp");
		SetGlobalVar("G_WARN_HP", 200);
	}

}

}
