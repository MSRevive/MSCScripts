#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsFangstooth : CGameScript
{
	SmallarmsFangstooth()
	{
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
		const int BASE_LEVEL_REQ = 12;
		const int MELEE_RANGE = 35;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 150;
		const int MELEE_DMG_RANGE = 100;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.3;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const int MODEL_BODY_OFS = 24;
		const string ANIM_PREFIX = "thiefdagger";
	}

	void weapon_spawn()
	{
		SetName("Fang s Tooth");
		SetDescription("Fang s Tooth");
		SetWeight(1);
		SetSize(1);
		SetValue(50);
		SetHUDSprite("trade", 171);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string random = RandomInt(0, 99);
		if (!(random < 15)) return;
		ApplyEffect(param2, "effects/dot_poison", RandomInt(3, 6), GetEntityIndex(GetOwner()), Random(0.5, 1.5), "smallarms");
	}

}

}
