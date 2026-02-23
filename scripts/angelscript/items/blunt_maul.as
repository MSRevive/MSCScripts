#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntMaul : CGameScript
{
	BluntMaul()
	{
		const int BASE_LEVEL_REQ = 12;
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 0;
		const int MODEL_BODY_OFS = 71;
		const string ANIM_PREFIX = "maul";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.8;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 220;
		const int MELEE_DMG_RANGE = 20;
		const float MELEE_ACCURACY = 0.65;
		const float MELEE_PARRY_AUGMENT = 0.1;
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
