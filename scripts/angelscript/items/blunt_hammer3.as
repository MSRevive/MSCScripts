#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntHammer3 : CGameScript
{
	BluntHammer3()
	{
		const int BASE_LEVEL_REQ = 9;
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 80;
		const string ANIM_PREFIX = "warhammer";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 180;
		const int MELEE_DMG_RANGE = 20;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.65;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.1;
	}

	void weapon_spawn()
	{
		SetName("Heavy War Hammer");
		SetDescription("A large heavy war hammer");
		SetWeight(50);
		SetSize(6);
		SetValue(135);
		SetHUDSprite("trade", 70);
	}

}

}
