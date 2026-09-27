#pragma context client

#include "items/base_lighted.as"

namespace MS
{

class ItemTorchLight : CGameScript
{
	string LIGHT_COLOR;
	float LIGHT_DROPPED_SCALE;
	float LIGHT_PLAYER_SCALE;
	string SOUND_BURN;
	string SPRITE_FIRE;
	string SPRITE_FIRE_FIXED;

	ItemTorchLight()
	{
		SPRITE_FIRE = "fire1_fixed.spr";
		SPRITE_FIRE_FIXED = "fire1_fixed.spr";
		SOUND_BURN = "items/torch1.wav";
		LIGHT_COLOR = Vector3(255, 255, 128);
		LIGHT_PLAYER_SCALE = 0.3;
		LIGHT_DROPPED_SCALE = 0.5;
		Precache(SPRITE_FIRE);
		Precache(SPRITE_FIRE_FIXED);
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
