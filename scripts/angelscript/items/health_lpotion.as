#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthLpotion : CGameScript
{
	int DRINK_AMOUNT;
	string DRINK_EFFECTAMT;
	float DRINK_GULP_DELAY;
	float DRINK_TIME;
	string DRINK_TYPE;
	float RESTORE_PERCENT;

	HealthLpotion()
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
		RESTORE_PERCENT = 0.25;
		DRINK_EFFECTAMT = RandomInt(22, 25);
		DRINK_AMOUNT = 4;
		DRINK_GULP_DELAY = 3.2;
		DRINK_TIME = 3.2;
	}

	void drink_spawn()
	{
		SetName("Medium Health Potion");
		SetDescription("A restorative potion offering high regeneration of health");
		SetWeight(1);
		SetSize(2);
		SetValue(150);
		SetHUDSprite("trade", "mhealth");
	}

}

}
