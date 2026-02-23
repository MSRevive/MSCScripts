#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsDagger : CGameScript
{
	SmallarmsDagger()
	{
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 0;
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
		const int BASE_LEVEL_REQ = 6;
		const int MELEE_RANGE = 40;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 70;
		const float MELEE_ACCURACY = 0.75;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "dagger";
	}

	void weapon_spawn()
	{
		SetName("Small Dagger");
		SetDescription("A small dagger");
		SetWeight(3);
		SetSize(3);
		SetValue(45);
		SetHUDSprite("hand", 169);
		SetHUDSprite("trade", 169);
	}

}

}
