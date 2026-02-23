#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "deralia";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;fog_blue";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The City of Deralia");
		SetGlobalVar("G_MAP_DESC", "The Human capital is known as the Jewel of Daragoth.");
		SetGlobalVar("G_MAP_DIFF", "(Beginner/Safe Area)");
		SetGlobalVar("G_WARN_HP", 0);
	}

	void game_newlevel()
	{
		string reg.texture.name = "reflective";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 1;
		string reg.texture.reflect.color = "1;1;1;0.4";
		int reg.texture.reflect.range = 512;
		int reg.texture.reflect.world = 1;
		int reg.texture.water = 0;
		// TODO: registertexture
	}

}

}
