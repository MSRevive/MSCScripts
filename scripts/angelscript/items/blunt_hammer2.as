#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntHammer2 : CGameScript
{
	BluntHammer2()
	{
		const int BASE_LEVEL_REQ = 3;
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 65;
		const string ANIM_PREFIX = "hammer";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const float MELEE_ENERGY = 0.4;
		const int MELEE_DMG = 120;
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
		SetName("Heavy Hammer");
		SetDescription("A large heavy Hammer");
		SetWeight(30);
		SetSize(5);
		SetValue(15);
		SetHUDSprite("trade", 26);
	}

}

}
