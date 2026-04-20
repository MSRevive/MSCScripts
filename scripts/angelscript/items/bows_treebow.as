#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsTreebow : CGameScript
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
	int RANGED_ENERGY;
	int RANGED_FORCE;
	float RANGED_POSTFIRE_DELAY;
	string SOUND_SHOOT;

	BowsTreebow()
	{
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "treebow";
		ANIM_PREFIX = "treebow";
		MODEL_BODY_OFS = 36;
		RANGED_FORCE = 750;
		RANGED_ENERGY = 1;
		RANGED_ACCURACY = "10;4";
		RANGED_POSTFIRE_DELAY = 0.3;
	}

	void bow_spawn()
	{
		SetName("Tree Bow");
		SetDescription("A roughly crafted bow of bark and leaves");
		SetWeight(10);
		SetSize(5);
		SetValue(3);
		SetHUDSprite("trade", 47);
	}

}

}
