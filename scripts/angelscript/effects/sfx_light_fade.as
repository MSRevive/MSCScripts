#pragma context server

namespace MS
{

class SfxLightFade : CGameScript
{
	float FADE_COUNT;
	int FX_ACTIVE;
	string FX_ORIGIN;
	string GLOW_COLOR;
	string GLOW_RAD;
	string LIGHT_ID;

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_ORIGIN = param1;
		GLOW_COLOR = param2;
		GLOW_RAD = param3;
		FADE_COUNT = 1.0;
		FX_ACTIVE = 1;
		ClientEffect("light", "new", FX_ORIGIN, GLOW_RAD, GLOW_COLOR, 5.0);
		LIGHT_ID = "game.script.last_light_id";
		if (!(param4)) return;
		EmitSound3D(param5, param6, FX_ORIGIN);
	}

	void game_prerender()
	{
		FADE_COUNT -= 0.01;
		if (FADE_COUNT > 0)
		{
			string CUR_RAD = /* TODO: $ratio */ $ratio(FADE_COUNT, 0, GLOW_RAD);
			ClientEffect("light", LIGHT_ID, FX_ORIGIN, CUR_RAD, GLOW_COLOR, 1.0);
		}
		else
		{
			if ((FX_ACTIVE))
			{
			}
			FX_ACTIVE = 0;
			remove_fx();
		}
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
