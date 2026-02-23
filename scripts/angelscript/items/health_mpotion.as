#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthMpotion : CGameScript
{
	int DRINK_AMOUNT;
	string DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	float RESTORE_PERCENT;

	HealthMpotion()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 1;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 21;
		const string ANIM_PREFIX = "mhealth";
		DRINK_TYPE = "givehealth";
		RESTORE_PERCENT = 0.15;
		DRINK_EFFECTAMT = RandomInt(13, 16);
		DRINK_AMOUNT = 10;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Weak Health Potion");
		SetDescription("A restorative potion offering a some amount of health regeneration");
		SetWeight(1);
		SetSize(1);
		SetValue(30);
		SetHUDSprite("trade", "mhealth");
	}

}

}
