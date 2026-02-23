#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntHammer1 : CGameScript
{
	BluntHammer1()
	{
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 1;
		const int MODEL_BODY_OFS = 77;
		const string ANIM_PREFIX = "hammer";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 20;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.7;
		const float MELEE_PARRY_CHANCE = 0.05;
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
