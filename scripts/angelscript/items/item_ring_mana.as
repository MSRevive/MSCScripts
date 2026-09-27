#pragma context server

#include "items/base_effect_armor.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemRingMana : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;

	ItemRingMana()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Felewyn's Grace");
		SetDescription("Other-worldly powers resonate and empower your mystical energies.");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(100);
		SetWearable(1);
		SetHUDSprite("trade", 230);
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
		CallExternal(GetOwner(), "manaring_toggle", 1);
	}

	void barmor_effect_remove()
	{
		CallExternal(GetOwner(), "manaring_toggle", 0);
	}

}

}
