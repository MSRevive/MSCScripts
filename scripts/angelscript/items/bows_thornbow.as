#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsThornbow : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WEAR;
	string MODEL_WORLD;
	string RANGED_ACCURACY;
	string RANGED_AIMANGLE;
	float RANGED_ATK_DURATION;
	float RANGED_DMG_DELAY;
	float RANGED_DMG_MULTI;
	int RANGED_ENERGY;
	int RANGED_FORCE;
	float RANGED_POSTFIRE_DELAY;
	float RANGED_PULLTIME;
	string SOUND_SHOOT;

	BowsThornbow()
	{
		BASE_LEVEL_REQ = 20;
		MODEL_VIEW_IDX = 6;
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_WEAR = "weapons/p_weapons3.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "longbow";
		ANIM_PREFIX = "standard";
		MODEL_BODY_OFS = 0;
		RANGED_FORCE = 1700;
		RANGED_ENERGY = 2;
		RANGED_ACCURACY = "1;0";
		RANGED_POSTFIRE_DELAY = 0.1;
		RANGED_ATK_DURATION = 0.1;
		RANGED_DMG_DELAY = 0.1;
		RANGED_DMG_MULTI = 1.75;
		RANGED_PULLTIME = 0.4;
		RANGED_AIMANGLE = Vector3(0, 0, 0);
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
