#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsDagger : CGameScript
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
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND_DELAY;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;

	SmallarmsDagger()
	{
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 0;
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
		BASE_LEVEL_REQ = 6;
		MELEE_RANGE = 40;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_DMG = 100;
		MELEE_DMG_RANGE = 70;
		MELEE_ACCURACY = 0.75;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
		PLAYERANIM_AIM = "knife";
		PLAYERANIM_SWING = "swing_knife";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "dagger";
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
