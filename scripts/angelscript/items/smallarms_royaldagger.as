#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsRoyaldagger : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_UNWIELD;
	int ANIM_WIELD;
	int ANIM_WIELDEDIDLE1;
	float MELEE_ACCURACY;
	float MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;

	SmallarmsRoyaldagger()
	{
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 7;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_WIELD = 2;
		ANIM_UNWIELD = 3;
		ANIM_WIELDEDIDLE1 = 4;
		ANIM_ATTACK1 = 5;
		ANIM_ATTACK2 = 6;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_DMG = 189;
		MELEE_DMG_RANGE = 90;
		MELEE_ACCURACY = 0.8;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_PARRY_CHANCE = 0.3;
		MODEL_BODY_OFS = 16;
		ANIM_PREFIX = "craftedknife";
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
