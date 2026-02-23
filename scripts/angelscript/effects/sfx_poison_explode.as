#pragma context client

#include "effects/sfx_explode.as"

namespace MS
{

class SfxPoisonExplode : CGameScript
{
	SfxPoisonExplode()
	{
		const string SPRITE_NAME = "poison_cloud.spr";
		const Vector3 SPRITE_COLOR = Vector3(0, 255, 0);
		const int SPRITE_RENDERAMT = 200;
		const string SPRITE_RENDERMODE = "add";
		const int SPRITE_FRAMERATE = 30;
		const int SPRITE_NFRAMES = 17;
		const float SPRITE_SCALE = 1.0;
		const string SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

}

}
