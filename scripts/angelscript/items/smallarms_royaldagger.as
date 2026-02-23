#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsRoyaldagger : CGameScript
{
	SmallarmsRoyaldagger()
	{
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 7;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 2;
		const int ANIM_UNWIELD = 3;
		const int ANIM_WIELDEDIDLE1 = 4;
		const int ANIM_ATTACK1 = 5;
		const int ANIM_ATTACK2 = 6;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 189;
		const int MELEE_DMG_RANGE = 90;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MODEL_BODY_OFS = 16;
		const string ANIM_PREFIX = "craftedknife";
	}

	void weapon_spawn()
	{
		SetName("Royal Dagger");
		SetDescription("A Royal Dagger");
		SetWeight(3);
		SetSize(2);
		SetValue(50);
		SetHUDSprite("hand", 170);
		SetHUDSprite("trade", 170);
	}

}

}
