#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaSt : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaSt()
	{
		const string DRINK_TYPE = "effect";
		const int MODEL_BODY_OFS = 24;
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 2;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 39;
		const string ANIM_PREFIX = "mana";
		DRINK_AMOUNT = 1;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Stamina Potion");
		SetDescription("Provides rapid stamina regeneration");
		SetWeight(1);
		SetSize(2);
		SetValue(500);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		ApplyEffect(GetOwner(), "effects/effect_stamina_regen");
		SendPlayerMessage("You", "feel as though you have infinite energy.");
	}

}

}
