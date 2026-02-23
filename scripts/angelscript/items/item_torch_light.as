#pragma context client

#include "items/base_lighted.as"

namespace MS
{

class ItemTorchLight : CGameScript
{
	ItemTorchLight()
	{
		const string SPRITE_FIRE = "fire1_fixed.spr";
		const string SPRITE_FIRE_FIXED = "fire1_fixed.spr";
		const string SOUND_BURN = "items/torch1.wav";
		const Vector3 LIGHT_COLOR = Vector3(255, 255, 128);
		const float LIGHT_PLAYER_SCALE = 0.3;
		const float LIGHT_DROPPED_SCALE = 0.5;
		Precache(SPRITE_FIRE);
		Precache(SPRITE_FIRE_FIXED);
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
