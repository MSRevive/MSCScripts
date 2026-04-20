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
		MAP_NAME = "the_wall2";
		MAP_WEATHER = "clear;clear;clear;clear;clear;clear";
		MAP_ALLOWNIGHT = 0;
		SetGlobalVar("G_MAP_NAME", "The Wall by Skillasaur");
		SetGlobalVar("G_MAP_DESC", "Abandoned by the elves, this fortress is now a bastion for the undead.");
		SetGlobalVar("G_MAP_DIFF", "Levels 40+ / 700+hp");
		SetGlobalVar("G_WARN_HP", 700);
	}

	void game_newlevel()
	{
		string reg.texture.name = "reflective";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 0;
		string reg.texture.reflect.color = "1;1;1;0.2";
		int reg.texture.reflect.range = 256;
		int reg.texture.reflect.world = 1;
		int reg.texture.reflect.ents = 1;
		int reg.texture.water = 0;
		// TODO: registertexture
	}

}

}
