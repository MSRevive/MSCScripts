#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaMpotion : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	float RESTORE_PERCENT;

	ManaMpotion()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 0;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 24;
		const string ANIM_PREFIX = "mana";
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
