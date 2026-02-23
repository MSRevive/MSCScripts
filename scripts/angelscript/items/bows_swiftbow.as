#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsSwiftbow : CGameScript
{
	BowsSwiftbow()
	{
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const int MODEL_VIEW_IDX = 5;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "longbow";
		const int MODEL_BODY_OFS = 44;
		const int RANGED_FORCE = 1500;
		const int RANGED_ENERGY = 2;
		const string RANGED_ACCURACY = "1;1";
		const float RANGED_POSTFIRE_DELAY = 0.1;
		const float RANGED_ATK_DURATION = 0.1;
		const float RANGED_DMG_DELAY = 0.1;
		const float RANGED_PULLTIME = 0.4;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
	}

	void bow_spawn()
	{
		SetName("Elven Longbow");
		SetDescription("One of the finest elven longbows made out of the Sylven wood");
		SetWeight(60);
		SetSize(10);
		SetValue(100);
		SetHUDSprite("trade", ITEM_NAME);
	}

}

}
