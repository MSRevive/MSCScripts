#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaSb : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaSb()
	{
		const string DRINK_TYPE = "effect";
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
		const float SPEED_RATIO = 0.5;
	}

	void drink_spawn()
	{
		SetName("Swift Blade Potion");
		SetDescription("This potion doubles your base attack speed");
		SetWeight(1);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
		SetHand("both");
	}

	void drink_effect()
	{
		Effect("screenfade", GetOwner(), 2.0, 0.5, Vector3(255, 0, 0), 255, "fadeout");
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 1.0, 1.0);
		CallExternal(GetOwner(), "ext_set_swift_blade", SPEED_RATIO);
	}

}

}
