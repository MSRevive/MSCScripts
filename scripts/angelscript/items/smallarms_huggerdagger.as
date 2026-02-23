#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsHuggerdagger : CGameScript
{
	SmallarmsHuggerdagger()
	{
		const int BASE_LEVEL_REQ = 9;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 3;
		const int ANIM_LIFT1 = 18;
		const int ANIM_IDLE1 = 19;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 20;
		const int ANIM_UNWIELD = 21;
		const int ANIM_WIELDEDIDLE1 = 22;
		const int ANIM_ATTACK1 = 23;
		const int ANIM_ATTACK2 = 24;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MELEE_RANGE = 22;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.65;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 170;
		const int MELEE_DMG_RANGE = 90;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MODEL_BODY_OFS = 24;
		const string ANIM_PREFIX = "thiefdagger";
	}

	void weapon_spawn()
	{
		SetName("Hugger Dagger");
		SetDescription("A dagger only useful if you re close enough to give the enemy a big warm hug");
		SetWeight(1);
		SetSize(1);
		SetValue(50);
		SetHUDSprite("hand", 171);
		SetHUDSprite("trade", 171);
	}

}

}
