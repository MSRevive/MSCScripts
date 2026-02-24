#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsOrcbow : CGameScript
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
	float RANGED_ENERGY;
	int RANGED_FORCE;
	float RANGED_POSTFIRE_DELAY;
	string SOUND_SHOOT;

	BowsOrcbow()
	{
		MODEL_VIEW_IDX = 1;
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_WEAR = "weapons/p_weapons2.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "orcbow";
		ANIM_PREFIX = "orcbow";
		MODEL_BODY_OFS = 40;
		RANGED_FORCE = 900;
		RANGED_ENERGY = 0.3;
		RANGED_ACCURACY = "6;3";
		RANGED_POSTFIRE_DELAY = 0.3;
	}

	void bow_spawn()
	{
		SetName("Orcish bow");
		SetDescription("A primitive bow used by the Orc race");
		SetWeight(30);
		SetSize(6);
		SetValue(25);
		SetHUDSprite("trade", 69);
	}

}

}
