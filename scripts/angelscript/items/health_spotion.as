#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthSpotion : CGameScript
{
	int DRINK_AMOUNT;
	string DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	float RESTORE_PERCENT;

	HealthSpotion()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 1;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 18;
		const string ANIM_PREFIX = "mhealth";
		DRINK_TYPE = "givehealth";
		RESTORE_PERCENT = 0.50;
		DRINK_EFFECTAMT = RandomInt(50, 70);
		DRINK_AMOUNT = 1;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 5;
	}

	void drink_spawn()
	{
		SetName("Strong Health Potion");
		SetDescription("A restorative potion offering miraculous regeneration of health");
		SetWeight(1);
		SetSize(2);
		SetValue(300);
		SetHUDSprite("trade", "mhealth");
	}

}

}
