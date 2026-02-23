#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsShortbow : CGameScript
{
	BowsShortbow()
	{
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "orcbow";
		const string ANIM_PREFIX = "orcbow";
		const int MODEL_BODY_OFS = 40;
		const int RANGED_FORCE = 1000;
		const int RANGED_ENERGY = 3;
		const string RANGED_ACCURACY = "4;2";
		const float RANGED_POSTFIRE_DELAY = 0.1;
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
