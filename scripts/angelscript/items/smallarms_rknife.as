#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsRknife : CGameScript
{
	SmallarmsRknife()
	{
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 1;
		const int ANIM_LIFT1 = 27;
		const int ANIM_IDLE1 = 28;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 29;
		const int ANIM_ATTACK2 = 30;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MELEE_RANGE = 40;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 70;
		const int MELEE_DMG_RANGE = 50;
		const float MELEE_ACCURACY = 0.75;
		const float MELEE_PARRY_CHANCE = 0.2;
		const int MELEE_NEW_PARRY_CHANCE = 20;
		const int MODEL_BODY_OFS = 12;
		const string ANIM_PREFIX = "rdagger";
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
