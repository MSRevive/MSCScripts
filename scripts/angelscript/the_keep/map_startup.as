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
		MAP_NAME = "the_keep";
		MAP_WEATHER = "clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Keep");
		SetGlobalVar("G_MAP_DESC", "The stronghold has been taken over by hearty adventurers that now terrorize the countryside as bandits.");
		SetGlobalVar("G_MAP_DIFF", "Levels 25-30 / HP 400-600");
		SetGlobalVar("G_WARN_HP", 400);
	}

	void game_newlevel()
	{
		string reg.texture.name = "reflective";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 1;
		string reg.texture.reflect.color = "1;1;1;0.2";
		int reg.texture.reflect.range = 256;
		int reg.texture.reflect.world = 1;
		int reg.texture.water = 0;
		// TODO: registertexture
	}

}

}
