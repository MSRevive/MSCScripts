#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntMaul : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;

	BluntMaul()
	{
		BASE_LEVEL_REQ = 12;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 0;
		MODEL_BODY_OFS = 71;
		ANIM_PREFIX = "maul";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.8;
		MELEE_ATK_DURATION = 1.3;
		MELEE_ENERGY = 2;
		MELEE_DMG = 220;
		MELEE_DMG_RANGE = 20;
		MELEE_ACCURACY = 0.65;
		MELEE_PARRY_AUGMENT = 0.1;
	}

	void weapon_spawn()
	{
		SetName("Maul");
		SetDescription("A heavy two-handed maul");
		SetWeight(80);
		SetSize(10);
		SetValue(270);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", "maul");
	}

}

}
