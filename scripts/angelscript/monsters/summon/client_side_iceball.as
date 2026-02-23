#pragma context client

#include "monsters/summon/client_side_fireball.as"

namespace MS
{

class ClientSideIceball : CGameScript
{
	ClientSideIceball()
	{
		const int FIREBALL_SPEED = 120;
		const string FIREBALL_SPRITE = "blueflare1.spr";
		const string EMITTER_SPRITE = "blueflare1.spr";
		const string SOUND_KABOOM = "magic/freeze.wav";
		const string SOUND_LOOP = "magic/pulsemachine_noloop.wav";
		const float FREQ_LOOP_SOUND = 1.88;
		const int IS_COLORED = 1;
		const Vector3 NEW_COLOR = Vector3(128, 164, 255);
		const int SPRITE_FRAMES_SMALL = 1;
		const int SPRITE_FRAMES_LARGE = 1;
		const float SPRITE_SCALE_SMALL = 0.5;
		const float SPRITE_SCALE_LARGE = 2.0;
		const float SPRITE_SCALE_KABOOM = 3.0;
	}

}

}
