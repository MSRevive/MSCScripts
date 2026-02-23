#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntCalrianmace : CGameScript
{
	BluntCalrianmace()
	{
		const int BASE_LEVEL_REQ = 15;
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 3;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 56;
		const string ANIM_PREFIX = "warhammer";
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
		SetName("Calrian's Mace");
		SetDescription("A one-handed mace previously used by Lord Calrian");
		SetWeight(35);
		SetSize(6);
		SetValue(1000);
		SetHUDSprite("hand", 98);
		SetHUDSprite("trade", 98);
		Precache(MODEL_VIEW);
	}

}

}
