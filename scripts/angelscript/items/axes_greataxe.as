#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesGreataxe : CGameScript
{
	AxesGreataxe()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 0;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 92;
		const string ANIM_PREFIX = "axe";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 3;
		const int MELEE_DMG = 300;
		const int MELEE_DMG_RANGE = 25;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.25;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Great Axe");
		SetDescription("A great two-handed Axe");
		SetWeight(90);
		SetSize(25);
		SetValue(900);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", "greataxe");
		Precache(MODEL_VIEW);
	}

}

}
