#pragma context client

namespace MS
{

class SfxSpriteIn : CGameScript
{
	string SOUND_SPAWN;
	string SPRITE_FRAMES;
	string SPRITE_SCALE;

	SfxSpriteIn()
	{
		SOUND_SPAWN = "magic/spawn_loud.wav";
	}

	void client_activate()
	{
		string FX_ORG = param1;
		string SPRITE_NAME = param2;
		SPRITE_FRAMES = param3;
		SPRITE_SCALE = param4;
		EmitSound3D(SOUND_SPAWN, 10, FX_ORG);
		ClientEffect("tempent", "sprite", SPRITE_NAME, FX_ORG, "setup_spawn_sprite");
		ScheduleDelayedEvent(2.0, "remove_fx");
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
