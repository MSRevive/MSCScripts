#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRingRyzaGem2 : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRingRyzaGem2()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Focusing Stone");
		SetDescription("Its radiance channels and focuses raw leyline energies.");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(420);
		SetHUDSprite("trade", 228);
	}

	void game_wear()
	{
		SetModel("none");
	}

	void game_removefromowner()
	{
		SetModel(MODEL_HANDS);
	}

}

}
