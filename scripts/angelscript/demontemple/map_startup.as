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
		MAP_NAME = "demontemple";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Demonic Temple by AmIAnnoyingNow");
		SetGlobalVar("G_MAP_DESC", "You seem to have stumbled on a stronghold of the Kharaztorant cult.");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-25 / 350-600hp");
		SetGlobalVar("G_WARN_HP", 350);
	}

	void game_newlevel()
	{
		SetGlobalVar("global.map.allownight", 0);
	}

}

}
