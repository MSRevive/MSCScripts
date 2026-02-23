#pragma context client

#include "effects/sfx_ice_wave2.as"

namespace MS
{

class SfxFireWave2 : CGameScript
{
	SfxFireWave2()
	{
		const string SPRITE_NAME = "fire1_fixed.spr";
		const Vector3 SPRITE_COLOR = Vector3(255, 128, 64);
		const int SPRITE_RENDERAMT = 200;
		const string SPRITE_RENDERMODE = "add";
		const int SPRITE_FRAMERATE = 30;
		const int SPRITE_NFRAMES = 23;
		const float SPRITE_SCALE = 1.75;
		const int SPRITE_SPEED = 400;
		const string SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

}

}
