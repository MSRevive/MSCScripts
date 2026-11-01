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
		MAP_NAME = "edanasewers_old";
		MAP_WEATHER = "fog_green;fog_green;fog_green;fog_green;fog_red;fog_red";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Sewers of Edana");
		SetGlobalVar("G_MAP_DESC", "These sewers predate the town above by hundreds of years and are now the haunted remnants of a once great city");
		SetGlobalVar("G_MAP_DIFF", "Levels 5-10 / 50-100hp");
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
