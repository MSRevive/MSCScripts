#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsCraftedknife : CGameScript
{
	SmallarmsCraftedknife()
	{
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int BASE_LEVEL_REQ = 6;
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 190;
		const int MELEE_DMG_RANGE = 90;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MODEL_BODY_OFS = 0;
		const string ANIM_PREFIX = "craftedknife";
	}

	void weapon_spawn()
	{
		SetName("Dull Finely Crafted Knife");
		SetDescription("A deadly looking dagger of high craftsmanship");
		SetWeight(3);
		SetSize(2);
		SetValue(50);
		SetHUDSprite("hand", "merldagger");
		SetHUDSprite("trade", "crafted");
	}

}

}
