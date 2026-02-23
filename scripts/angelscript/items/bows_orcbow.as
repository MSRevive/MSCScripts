#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsOrcbow : CGameScript
{
	BowsOrcbow()
	{
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "orcbow";
		const string ANIM_PREFIX = "orcbow";
		const int MODEL_BODY_OFS = 40;
		const int RANGED_FORCE = 900;
		const float RANGED_ENERGY = 0.3;
		const string RANGED_ACCURACY = "6;3";
		const float RANGED_POSTFIRE_DELAY = 0.3;
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
