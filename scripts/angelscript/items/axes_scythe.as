#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesScythe : CGameScript
{
	AxesScythe()
	{
		const int BASE_LEVEL_REQ = 9;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxes.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 101;
		const string ANIM_PREFIX = "axe";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 190;
		const int MELEE_DMG_RANGE = 150;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.65;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.1;
	}

	void weapon_spawn()
	{
		SetName("Scythe");
		SetDescription("A scythe , usually a farming tool , useful axe weapon as well");
		SetWeight(60);
		SetSize(10);
		SetValue(65);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", "scythe");
	}

}

}
