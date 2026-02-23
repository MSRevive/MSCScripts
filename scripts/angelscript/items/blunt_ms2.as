#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntMs2 : CGameScript
{
	BluntMs2()
	{
		const int BASE_LEVEL_REQ = 15;
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 7;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 87;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 8;
		const int MELEE_DMG = 230;
		const int MELEE_DMG_RANGE = 140;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "bluntarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Morning Star");
		SetDescription("A heavy spiked mace");
		SetWeight(35);
		SetSize(6);
		SetValue(1000);
		SetHUDSprite("hand", "mace");
		SetHUDSprite("trade", 187);
	}

}

}
