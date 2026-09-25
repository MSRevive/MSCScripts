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
		MAP_NAME = "edana";
		MAP_WEATHER = "clear;clear;clear;clear;rain;clear";
		MAP_ALLOWNIGHT = 1;
		SetGlobalVar("G_MAP_NAME", "The Village of Edana");
		SetGlobalVar("G_MAP_DESC", "This village grew around the temple of Urdual of the southern frontier.");
		SetGlobalVar("G_MAP_DIFF", "(Beginner/Safe Area)");
		SetGlobalVar("G_WARN_HP", 0);
	}

	void game_newlevel()
	{
		string reg.texture.name = "reflective";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 1;
		string reg.texture.reflect.color = "1;1;1;0.2";
		int reg.texture.reflect.range = 256;
		int reg.texture.reflect.world = 0;
		int reg.texture.water = 0;
		// TODO: registertexture
	}

}

}
