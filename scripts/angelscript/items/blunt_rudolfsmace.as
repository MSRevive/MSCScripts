#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntRudolfsmace : CGameScript
{
	BluntRudolfsmace()
	{
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 3;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 56;
		const string ANIM_PREFIX = "mace";
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 150;
		const int MELEE_DMG_RANGE = 110;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Odd Mace");
		SetDescription("An odd one-handed mace");
		SetWeight(35);
		SetSize(6);
		SetValue(30);
		SetHUDSprite("trade", 98);
	}

}

}
