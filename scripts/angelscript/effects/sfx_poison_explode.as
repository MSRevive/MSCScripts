#pragma context client

#include "effects/sfx_explode.as"

namespace MS
{

class SfxPoisonExplode : CGameScript
{
	string SOUND_BURST;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;

	SfxPoisonExplode()
	{
		SPRITE_NAME = "poison_cloud.spr";
		SPRITE_COLOR = Vector3(0, 255, 0);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 17;
		SPRITE_SCALE = 1.0;
		SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

}

}
