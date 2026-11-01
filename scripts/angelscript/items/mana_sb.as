#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaSb : CGameScript
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
	float SPEED_RATIO;

	ManaSb()
	{
		DRINK_TYPE = "effect";
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
		SPEED_RATIO = 0.5;
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
