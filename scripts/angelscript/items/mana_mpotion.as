#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaMpotion : CGameScript
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

	ManaMpotion()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 0;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 24;
		ANIM_PREFIX = "mana";
		DRINK_TYPE = "givemana";
		RESTORE_PERCENT = 0.9;
		DRINK_EFFECTAMT = 300;
		DRINK_AMOUNT = 4;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Mana Potion");
		SetDescription("Restores Magical Energies");
		SetWeight(1);
		SetSize(2);
		SetValue(500);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "bpot");
	}

}

}
