#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsTreebow : CGameScript
{
	BowsTreebow()
	{
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "treebow";
		const string ANIM_PREFIX = "treebow";
		const int MODEL_BODY_OFS = 36;
		const int RANGED_FORCE = 750;
		const int RANGED_ENERGY = 1;
		const string RANGED_ACCURACY = "10;4";
		const float RANGED_POSTFIRE_DELAY = 0.3;
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
