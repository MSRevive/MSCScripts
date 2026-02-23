#pragma context client

#include "effects/sfx_fire_burst.as"

namespace MS
{

class SfxStunBurst : CGameScript
{
	SfxStunBurst()
	{
		const Vector3 SPRITE_COLOR = Vector3(0, 0, 255);
		const string SOUND_BURST = "magic/boom.wav";
		Precache(SOUND_BURST);
	}

}

}
