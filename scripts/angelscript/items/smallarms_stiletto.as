#pragma context server

#include "items/item_precache.as"
#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsStiletto : CGameScript
{
	SmallarmsStiletto()
	{
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 0;
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
		const int BASE_LEVEL_REQ = 3;
		const int MELEE_RANGE = 40;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 140;
		const int MELEE_DMG_RANGE = 100;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.75;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "dagger";
		const int ANIM_PARRY = 6;
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
