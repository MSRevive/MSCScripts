#pragma context client

#include "effects/sfx_fire_burst.as"

namespace MS
{

class SfxStunBurst : CGameScript
{
	string SOUND_BURST;
	string SPRITE_COLOR;

	SfxStunBurst()
	{
		SPRITE_COLOR = Vector3(0, 0, 255);
		SOUND_BURST = "magic/boom.wav";
		Precache(SOUND_BURST);
	}

}

}
