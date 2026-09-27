#pragma context client

#include "monsters/summon/client_side_fireball.as"

namespace MS
{

class ClientSideIceball : CGameScript
{
	string EMITTER_SPRITE;
	int FIREBALL_SPEED;
	string FIREBALL_SPRITE;
	float FREQ_LOOP_SOUND;
	int IS_COLORED;
	string NEW_COLOR;
	string SOUND_KABOOM;
	string SOUND_LOOP;
	int SPRITE_FRAMES_LARGE;
	int SPRITE_FRAMES_SMALL;
	float SPRITE_SCALE_KABOOM;
	float SPRITE_SCALE_LARGE;
	float SPRITE_SCALE_SMALL;

	ClientSideIceball()
	{
		FIREBALL_SPEED = 120;
		FIREBALL_SPRITE = "blueflare1.spr";
		EMITTER_SPRITE = "blueflare1.spr";
		SOUND_KABOOM = "magic/freeze.wav";
		SOUND_LOOP = "magic/pulsemachine_noloop.wav";
		FREQ_LOOP_SOUND = 1.88;
		IS_COLORED = 1;
		NEW_COLOR = Vector3(128, 164, 255);
		SPRITE_FRAMES_SMALL = 1;
		SPRITE_FRAMES_LARGE = 1;
		SPRITE_SCALE_SMALL = 0.5;
		SPRITE_SCALE_LARGE = 2.0;
		SPRITE_SCALE_KABOOM = 3.0;
	}

}

}
