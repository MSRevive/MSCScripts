#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthSpotion : CGameScript
{
	int ANIM_DRINK;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	int ITEM_MODEL_VIEW_IDX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	float RESTORE_PERCENT;
	string SOUND_DRINK;

	HealthSpotion()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 1;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 18;
		ANIM_PREFIX = "mhealth";
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
