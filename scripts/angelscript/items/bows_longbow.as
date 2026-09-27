#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsLongbow : CGameScript
{
	string ANIM_PREFIX;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WEAR;
	string MODEL_WORLD;
	string RANGED_ACCURACY;
	string RANGED_AIMANGLE;
	int RANGED_ENERGY;
	int RANGED_FORCE;
	float RANGED_POSTFIRE_DELAY;
	string SOUND_SHOOT;

	BowsLongbow()
	{
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "longbow";
		ANIM_PREFIX = "longbow";
		MODEL_BODY_OFS = 44;
		RANGED_FORCE = 2100;
		RANGED_ENERGY = 4;
		RANGED_ACCURACY = "3;0";
		RANGED_POSTFIRE_DELAY = 0.3;
		RANGED_AIMANGLE = Vector3(0, 3, 0);
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
