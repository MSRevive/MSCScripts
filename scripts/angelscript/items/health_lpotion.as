#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthLpotion : CGameScript
{
	int ANIM_DRINK;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	float DRINK_GULP_DELAY;
	float DRINK_TIME;
	string DRINK_TYPE;
	int ITEM_MODEL_VIEW_IDX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	float RESTORE_PERCENT;
	string SOUND_DRINK;

	HealthLpotion()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 1;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 21;
		ANIM_PREFIX = "mhealth";
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
