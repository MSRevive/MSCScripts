#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaBravery : CGameScript
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

	ManaBravery()
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
		DRINK_AMOUNT = 5;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Bravery Potion");
		SetDescription("This prevents XP/Gold loss on your next death");
		SetWeight(1);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		CallExternal(GetOwner(), "ext_bravery");
		SendInfoMsg("all", GetEntityName(GetOwner()) + " Has downed a Potion of Bravery");
	}

}

}
