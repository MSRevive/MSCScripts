#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesRuneaxe : CGameScript
{
	AxesRuneaxe()
	{
		const int BASE_LEVEL_REQ = 20;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 9;
		const int ANIM_ATTACK2 = 10;
		const int ANIM_ATTACK3 = 11;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		Precache(MODEL_VIEW);
		const int MODEL_BODY_OFS = 95;
		const string ANIM_PREFIX = "axe";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 0.7;
		const int MELEE_ENERGY = 4;
		const int MELEE_DMG = 160;
		const int MELEE_DMG_RANGE = 70;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Rune Axe");
		SetDescription("An axe hastened by ancient magiks");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", "runeaxe");
		Precache(MODEL_VIEW);
	}

}

}
