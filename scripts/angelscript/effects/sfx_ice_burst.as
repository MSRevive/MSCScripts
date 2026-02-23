#pragma context client

#include "effects/sfx_fire_burst.as"

namespace MS
{

class SfxIceBurst : CGameScript
{
	SfxIceBurst()
	{
		const Vector3 SPRITE_COLOR = Vector3(64, 64, 255);
		const string SOUND_BURST = "magic/frost_reverse.wav";
		Precache(SOUND_BURST);
	}

}

}
