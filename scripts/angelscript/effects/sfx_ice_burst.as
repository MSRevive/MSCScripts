#pragma context client

#include "effects/sfx_fire_burst.as"

namespace MS
{

class SfxIceBurst : CGameScript
{
	string SOUND_BURST;
	string SPRITE_COLOR;

	SfxIceBurst()
	{
		SPRITE_COLOR = Vector3(64, 64, 255);
		SOUND_BURST = "magic/frost_reverse.wav";
		Precache(SOUND_BURST);
	}

}

}
