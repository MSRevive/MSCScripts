#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntHammer1 : CGameScript
{
	string ANIM_PREFIX;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;

	BluntHammer1()
	{
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_BODY_OFS = 77;
		ANIM_PREFIX = "hammer";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.2;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 100;
		MELEE_DMG_RANGE = 20;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.7;
		MELEE_PARRY_CHANCE = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Training Hammer");
		SetDescription("Rusted metal makes this hammer light and easy to swing");
		SetWeight(10);
		SetSize(5);
		SetValue(3);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "rustyhammer");
	}

}

}
