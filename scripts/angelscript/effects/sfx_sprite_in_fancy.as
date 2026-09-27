#pragma context client

namespace MS
{

class SfxSpriteInFancy : CGameScript
{
	float FADE_COUNT;
	int FX_ACTIVE;
	string FX_ORG;
	string GLOW_COLOR;
	string GLOW_RAD;
	string LIGHT_ID;
	string SPRITE_FRAMES;
	string SPRITE_SCALE;

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_ORG = param1;
		string SPRITE_NAME = param2;
		SPRITE_FRAMES = param3;
		SPRITE_SCALE = param4;
		ClientEffect("tempent", "sprite", SPRITE_NAME, FX_ORG, "setup_spawn_sprite");
		GLOW_COLOR = param5;
		GLOW_RAD = param6;
		FADE_COUNT = 1.0;
		FX_ACTIVE = 1;
		ClientEffect("light", "new", FX_ORG, GLOW_RAD, GLOW_COLOR, 5.0);
		LIGHT_ID = "game.script.last_light_id";
		EmitSound3D(param7, 10, FX_ORG);
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void game_prerender()
	{
		FADE_COUNT -= 0.01;
		if (FADE_COUNT > 0)
		{
			string CUR_RAD = /* TODO: $ratio */ $ratio(FADE_COUNT, 0, GLOW_RAD);
			ClientEffect("light", LIGHT_ID, FX_ORG, CUR_RAD, GLOW_COLOR, 1.0);
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

	void setup_spawn_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 20);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_FRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
