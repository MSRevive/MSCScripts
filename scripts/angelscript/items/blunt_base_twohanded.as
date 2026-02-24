#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntBaseTwohanded : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	BluntBaseTwohanded()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		PLAYERANIM_AIM = "bluntdouble";
		PLAYERANIM_SWING = "swing_bluntdouble";
		SOUND_HITWALL1 = "weapons/xbow_hitbod1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
	}

	void weapon_spawn()
	{
		SetHand("both");
	}

}

}
