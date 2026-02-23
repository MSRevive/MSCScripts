#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntMace : CGameScript
{
	BluntMace()
	{
		const int BASE_LEVEL_REQ = 6;
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 0;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 68;
		const string ANIM_PREFIX = "mace";
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
		SetName("Mace");
		SetDescription("A one-handed mace");
		SetWeight(30);
		SetSize(6);
		SetValue(45);
		SetHUDSprite("hand", "mace");
		SetHUDSprite("trade", "mace");
	}

}

}
