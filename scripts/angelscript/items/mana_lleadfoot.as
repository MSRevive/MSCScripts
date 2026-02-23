#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaLleadfoot : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaLleadfoot()
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
		SetName("Lesser Leadfoot Potion");
		SetDescription("This potion reduces your opponents ability to fling you about");
		SetWeight(1);
		SetSize(2);
		SetValue(100);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		SendPlayerMessage("You", "feel your center of gravity increase.");
		CallExternal(GetOwner(), "ext_lesser_leadfoot", 0.25);
	}

}

}
