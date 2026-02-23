#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesDoubleaxe : CGameScript
{
	AxesDoubleaxe()
	{
		const int BASE_LEVEL_REQ = 12;
		const int BASE_LEVEL_REQ = 9;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		const int MODEL_VIEW_IDX = 3;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 89;
		const string ANIM_PREFIX = "smallaxe";
		const int MELEE_RANGE = 35;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.4;
		const int MELEE_DMG = 140;
		const int MELEE_DMG_RANGE = 75;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.8;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Dwarven Axe");
		SetDescription("A double-bladed one-handed Axe");
		SetWeight(10);
		SetSize(8);
		SetValue(250);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 177);
		Precache(MODEL_VIEW);
	}

}

}
