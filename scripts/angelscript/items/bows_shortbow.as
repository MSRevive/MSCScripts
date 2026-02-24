#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsShortbow : CGameScript
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

	BowsShortbow()
	{
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "orcbow";
		ANIM_PREFIX = "orcbow";
		MODEL_BODY_OFS = 40;
		RANGED_FORCE = 1000;
		RANGED_ENERGY = 3;
		RANGED_ACCURACY = "4;2";
		RANGED_POSTFIRE_DELAY = 0.1;
	}

	void bow_spawn()
	{
		SetName("Short Bow");
		SetDescription("A short and steady bow");
		SetWeight(40);
		SetSize(8);
		SetValue(15);
		SetHUDSprite("trade", 69);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		// TODO: setviewmodelprop ent_me submodel 0 2
	}

}

}
