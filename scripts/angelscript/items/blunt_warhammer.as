#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntWarhammer : CGameScript
{
	BluntWarhammer()
	{
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 1;
		const int BASE_LEVEL_REQ = 6;
		const int MODEL_BODY_OFS = 80;
		const string ANIM_PREFIX = "warhammer";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 150;
		const int MELEE_DMG_RANGE = 20;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.05;
	}

	void weapon_spawn()
	{
		SetName("War Hammer");
		SetDescription("A heavy war hammer");
		SetWeight(30);
		SetSize(6);
		SetValue(45);
		SetHUDSprite("hand", 70);
		SetHUDSprite("trade", 70);
	}

}

}
