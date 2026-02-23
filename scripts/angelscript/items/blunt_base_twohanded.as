#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntBaseTwohanded : CGameScript
{
	BluntBaseTwohanded()
	{
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const string PLAYERANIM_AIM = "bluntdouble";
		const string PLAYERANIM_SWING = "swing_bluntdouble";
		const string SOUND_HITWALL1 = "weapons/xbow_hitbod1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
	}

	void weapon_spawn()
	{
		SetHand("both");
	}

}

}
