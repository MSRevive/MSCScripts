#pragma context server

#include "items/base_melee.as"

namespace MS
{

class SwordsBaseOnehanded : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_SHEATH;
	int ATTACK_ANIMS;
	string MELEE_VIEWANIM_ATK;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SWING_ANIM;

	SwordsBaseOnehanded()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		ATTACK_ANIMS = 3;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		MODEL_HANDS = MODEL_WORLD;
		PLAYERANIM_AIM = "sword_idle";
		PLAYERANIM_SWING = "sword_swing";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
	}

	void melee_start()
	{
		int SWING = RandomInt(1, ATTACK_ANIMS);
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
