#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaSt : CGameScript
{
	int ANIM_DRINK;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	int ITEM_MODEL_VIEW_IDX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string SOUND_DRINK;

	ManaSt()
	{
		DRINK_TYPE = "effect";
		MODEL_BODY_OFS = 24;
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 2;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 39;
		ANIM_PREFIX = "mana";
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
