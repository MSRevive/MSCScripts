#pragma context server

#include "items/base_melee.as"

namespace MS
{

class AxesBaseOnehanded : CGameScript
{
	string SWING_ANIM;

	AxesBaseOnehanded()
	{
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const int ATTACK_ANIMS = 3;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string MODEL_HANDS = MODEL_WORLD;
		const string PLAYERANIM_AIM = "axe_onehand";
		const string PLAYERANIM_SWING = "axe_onehand_swing";
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "weapons/axemetal2.wav";
	}

	void melee_start()
	{
		string SWING = RandomInt(1, ATTACK_ANIMS);
		string SWING_ANIM = ANIM_ATTACK1;
		if (SWING == 2)
		{
			SWING_ANIM = ANIM_ATTACK2;
		}
		else
		{
			if (SWING == 3)
			{
				SWING_ANIM = ANIM_ATTACK3;
			}
			else
			{
				if (SWING == 4)
				{
					SWING_ANIM = ANIM_ATTACK4;
				}
				else
				{
					if (SWING == 5)
					{
						SWING_ANIM = ANIM_ATTACK5;
					}
				}
			}
		}
		PlayViewAnim(SWING_ANIM);
	}

}

}
