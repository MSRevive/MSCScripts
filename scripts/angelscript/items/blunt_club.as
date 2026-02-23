#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntClub : CGameScript
{
	BluntClub()
	{
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_ATTACK4 = 5;
		const int ANIM_ATTACK5 = 6;
		const int ANIM_SHEATH = 1;
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 59;
		const string ANIM_PREFIX = "club";
		const int MELEE_RANGE = 90;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 60;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.5;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Wooden Club");
		SetDescription("A big wooden club");
		SetWeight(10);
		SetSize(5);
		SetValue(10);
		SetHUDSprite("hand", "club");
		SetHUDSprite("trade", 73);
	}

}

}
