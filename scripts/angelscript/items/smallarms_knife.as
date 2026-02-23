#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsKnife : CGameScript
{
	SmallarmsKnife()
	{
		const int BASE_LEVEL_REQ = 3;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MELEE_RANGE = 40;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.4;
		const int MELEE_DMG = 80;
		const int MELEE_DMG_RANGE = 60;
		const float MELEE_ACCURACY = 0.75;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.2;
		const int MODEL_BODY_OFS = 0;
		const string ANIM_PREFIX = "craftedknife";
	}

	void weapon_spawn()
	{
		SetName("Sharp Knife");
		SetDescription("A sharpened knife");
		SetWeight(3);
		SetSize(3);
		SetValue(15);
		SetHUDSprite("hand", "merldagger");
		SetHUDSprite("trade", "crafted");
	}

}

}
