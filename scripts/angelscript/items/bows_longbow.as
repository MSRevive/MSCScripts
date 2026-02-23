#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsLongbow : CGameScript
{
	BowsLongbow()
	{
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "longbow";
		const int MODEL_BODY_OFS = 44;
		const int RANGED_FORCE = 2100;
		const int RANGED_ENERGY = 4;
		const string RANGED_ACCURACY = "3;0";
		const float RANGED_POSTFIRE_DELAY = 0.3;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 3, 0);
	}

	void bow_spawn()
	{
		SetName("Wooden Long bow");
		SetDescription("A long bow , elegantly carved and made for range");
		SetWeight(70);
		SetSize(12);
		SetValue(50);
		SetHUDSprite("trade", ITEM_NAME);
	}

}

}
