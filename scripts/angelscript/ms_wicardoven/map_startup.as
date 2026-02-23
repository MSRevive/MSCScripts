#pragma context server

#include "worlditems/map_startup.as"

namespace MS
{

class MapStartup : CGameScript
{
	MapStartup()
	{
		const string MAP_NAME = "ms_wicardoven";
		const string MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		const int MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "Wicard Oven");
		SetGlobalVar("G_MAP_DESC", "This ancient orc stronghold has recently seen its masters return.");
		SetGlobalVar("G_MAP_DIFF", "Levels 20-30 / HP 300-600");
		SetGlobalVar("G_WARN_HP", 300);
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
