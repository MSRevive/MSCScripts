#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsHuggerdagger : CGameScript
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
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;

	SmallarmsHuggerdagger()
	{
		BASE_LEVEL_REQ = 9;
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 3;
		ANIM_LIFT1 = 18;
		ANIM_IDLE1 = 19;
		ANIM_IDLE_TOTAL = 1;
		ANIM_WIELD = 20;
		ANIM_UNWIELD = 21;
		ANIM_WIELDEDIDLE1 = 22;
		ANIM_ATTACK1 = 23;
		ANIM_ATTACK2 = 24;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MELEE_RANGE = 22;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.65;
		MELEE_ENERGY = 1;
		MELEE_DMG = 170;
		MELEE_DMG_RANGE = 90;
		MELEE_ACCURACY = 0.8;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_PARRY_CHANCE = 0.3;
		MODEL_BODY_OFS = 24;
		ANIM_PREFIX = "thiefdagger";
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
