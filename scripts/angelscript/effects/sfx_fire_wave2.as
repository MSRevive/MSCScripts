#pragma context client

#include "effects/sfx_ice_wave2.as"

namespace MS
{

class SfxFireWave2 : CGameScript
{
	string SOUND_BURST;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;
	int SPRITE_SPEED;

	SfxFireWave2()
	{
		SPRITE_NAME = "fire1_fixed.spr";
		SPRITE_COLOR = Vector3(255, 128, 64);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 23;
		SPRITE_SCALE = 1.75;
		SPRITE_SPEED = 400;
		SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

}

}
