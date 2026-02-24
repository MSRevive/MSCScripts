#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsSwiftbow : CGameScript
{
	string ANIM_PREFIX;
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
	int RANGED_ENERGY;
	int RANGED_FORCE;
	float RANGED_POSTFIRE_DELAY;
	float RANGED_PULLTIME;
	string SOUND_SHOOT;

	BowsSwiftbow()
	{
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_VIEW_IDX = 5;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "longbow";
		ANIM_PREFIX = "longbow";
		MODEL_BODY_OFS = 44;
		RANGED_FORCE = 1500;
		RANGED_ENERGY = 2;
		RANGED_ACCURACY = "1;1";
		RANGED_POSTFIRE_DELAY = 0.1;
		RANGED_ATK_DURATION = 0.1;
		RANGED_DMG_DELAY = 0.1;
		RANGED_PULLTIME = 0.4;
		RANGED_AIMANGLE = Vector3(0, 0, 0);
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
