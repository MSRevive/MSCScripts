#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsThornbow : CGameScript
{
	BowsThornbow()
	{
		const int BASE_LEVEL_REQ = 20;
		const int MODEL_VIEW_IDX = 6;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "standard";
		const int MODEL_BODY_OFS = 0;
		const int RANGED_FORCE = 1700;
		const int RANGED_ENERGY = 2;
		const string RANGED_ACCURACY = "1;0";
		const float RANGED_POSTFIRE_DELAY = 0.1;
		const float RANGED_ATK_DURATION = 0.1;
		const float RANGED_DMG_DELAY = 0.1;
		const float RANGED_DMG_MULTI = 1.75;
		const float RANGED_PULLTIME = 0.4;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
	}

	void bow_spawn()
	{
		SetName("Thornbow");
		SetDescription("Augments arrows with magical thorns");
		SetWeight(100);
		SetValue(1500);
		SetHUDSprite("trade", 123);
	}

}

}
