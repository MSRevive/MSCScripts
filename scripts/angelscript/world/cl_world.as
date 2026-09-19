#pragma context server

namespace MS
{

class ClWorld : CGameScript
{
	void game_newlevel()
	{
		SetGlobalVar("global.map.allownight", 1);
		testmap_newlevel(param1);
	}

	void testmap_newlevel()
	{
		if (param1 == "test")
		{
			string reg.texture.name = "black";
			int reg.texture.reflect = 1;
			int reg.texture.reflect.blend = 1;
			string reg.texture.reflect.color = "1;1;1;0.1";
			int reg.texture.reflect.range = 300;
			int reg.texture.water = 1;
			// TODO: registertexture
			string reg.texture.name = "Drapery2";
			int reg.texture.reflect = 1;
			int reg.texture.reflect.blend = 1;
			string reg.texture.reflect.color = "1;1;1;0.8";
			int reg.texture.reflect.range = 512;
			int reg.texture.water = 0;
			int reg.texture.reflect.world = 1;
			// TODO: registertexture
		}
		if (param1 == "simple")
		{
			string reg.texture.name = "black";
			int reg.texture.reflect = 1;
			int reg.texture.reflect.blend = 1;
			string reg.texture.reflect.color = "1;1;1;0.8";
			int reg.texture.reflect.range = 512;
			int reg.texture.water = 0;
			// TODO: registertexture
		}
		string reg.texture.name = "reflect_full";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 1;
		string reg.texture.reflect.color = "1;1;1;0.5";
		int reg.texture.reflect.range = 1024;
		int reg.texture.reflect.world = 1;
		int reg.texture.water = 1;
		// TODO: registertexture
		string reg.texture.name = "reflective";
		int reg.texture.reflect = 1;
		int reg.texture.reflect.blend = 1;
		string reg.texture.reflect.color = "1;1;1;0.8";
		int reg.texture.reflect.range = 512;
		int reg.texture.reflect.world = 0;
		int reg.texture.water = 0;
		// TODO: registertexture
	}

}

}
