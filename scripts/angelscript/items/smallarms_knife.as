#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsKnife : CGameScript
{
	string ANIM_PREFIX;
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
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;

	SmallarmsKnife()
	{
		BASE_LEVEL_REQ = 3;
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MELEE_RANGE = 40;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.4;
		MELEE_DMG = 80;
		MELEE_DMG_RANGE = 60;
		MELEE_ACCURACY = 0.75;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_PARRY_CHANCE = 0.2;
		MODEL_BODY_OFS = 0;
		ANIM_PREFIX = "craftedknife";
	}

	void weapon_spawn()
	{
		SetName("Sharp Knife");
		SetDescription("A sharpened knife");
		SetWeight(3);
		SetSize(3);
		SetValue(15);
		SetHUDSprite("hand", "merldagger");
		SetHUDSprite("trade", "crafted");
	}

}

}
