#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsRknife : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	float MELEE_ENERGY;
	int MELEE_NEW_PARRY_CHANCE;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;

	SmallarmsRknife()
	{
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 1;
		ANIM_LIFT1 = 27;
		ANIM_IDLE1 = 28;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 29;
		ANIM_ATTACK2 = 30;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MELEE_RANGE = 40;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 70;
		MELEE_DMG_RANGE = 50;
		MELEE_ACCURACY = 0.75;
		MELEE_PARRY_CHANCE = 0.2;
		MELEE_NEW_PARRY_CHANCE = 20;
		MODEL_BODY_OFS = 12;
		ANIM_PREFIX = "rdagger";
	}

	void weapon_spawn()
	{
		SetName("Dull Knife");
		SetDescription("This knife has seen better days");
		SetWeight(2);
		SetSize(2);
		SetValue(3);
		SetHUDSprite("hand", "merldagger");
		SetHUDSprite("trade", "rdagger");
	}

}

}
