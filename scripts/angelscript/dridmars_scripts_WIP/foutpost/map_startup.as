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
		MAP_NAME = "foutpost";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("MAP_CON", 1);
		SetGlobalVar("G_MAP_NAME", "The Forgotten Outpost by Evil Squirrel");
		SetGlobalVar("G_MAP_DESC", "This outpost holds by a thread against an impending orc invasion");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-35 / 300-700hp");
		SetGlobalVar("G_WARN_HP", 300);
		ScheduleDelayedEvent(1, "deralia_spawn");
	}

	void deralia_spawn()
	{
		if ("SpawnAllies" == 1)
		{
			UseTrigger("NPCTransition");
		}
	}

}

}
