#pragma context server

#include "items/base_effect_armor.as"
#include "items/base_miscitem.as"

namespace MS
{

class ItemRingMana : CGameScript
{
	ItemRingMana()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
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
