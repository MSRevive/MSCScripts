#pragma context server

#include "items/base_effect_armor.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemRingPercept : CGameScript
{
	ItemRingPercept()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Bloodstone Ring");
		SetDescription("A sinister red stone is mounted in this ring");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(100);
		SetWearable(1);
		SetHUDSprite("trade", "ring");
	}

	void game_wear()
	{
		SetModel("none");
	}

	void game_removefromowner()
	{
		SetModel(MODEL_HANDS);
	}

	void barmor_effect_activate()
	{
		CallExternal(GetOwner(), "bloodstone_toggle", 1);
	}

	void barmor_effect_remove()
	{
		CallExternal(GetOwner(), "bloodstone_toggle", 0);
	}

}

}
