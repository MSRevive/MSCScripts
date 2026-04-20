#pragma context server

#include "items/item_precache.as"
#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsStiletto : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_PARRY;
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
	string MELEE_SOUND_DELAY;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;

	SmallarmsStiletto()
	{
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 0;
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
		BASE_LEVEL_REQ = 3;
		MELEE_RANGE = 40;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 1;
		MELEE_DMG = 140;
		MELEE_DMG_RANGE = 100;
		MELEE_ACCURACY = 0.8;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.75;
		PLAYERANIM_AIM = "knife";
		PLAYERANIM_SWING = "swing_knife";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "dagger";
		ANIM_PARRY = 6;
	}

	void weapon_spawn()
	{
		SetName("Stiletto");
		SetDescription("A pointed stiletto , taking advantage of exposed gaps on armored enemies");
		SetWeight(3);
		SetSize(3);
		SetValue(30);
		SetHUDSprite("trade", 169);
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), SOUND_HITMETAL1);
		PlayOwnerAnim("break");
		PlayViewAnim(ANIM_PARRY);
		weapon_parry();
	}

}

}
