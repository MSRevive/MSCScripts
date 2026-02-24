#pragma context server

#include "items/base_drink.as"

namespace MS
{

class DrinkMead : CGameScript
{
	int ALE_DRUNK;
	int ANIM_DRINK;
	int ANIM_IDLE;
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
	string SOUND_DRINK;

	DrinkMead()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 3;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 4;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 18;
		DRINK_TYPE = "getdrunk";
		DRINK_EFFECTAMT = RandomInt(10, 30);
		DRINK_AMOUNT = RandomInt(2, 3);
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Mead");
		SetDescription("A mug of mead");
		SetWeight(2);
		SetSize(2);
		SetValue(1);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "mhealth");
	}

	void game_fall()
	{
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 2;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
		ALE_DRUNK = 0;
	}

	void drink_now()
	{
		ALE_DRUNK += 1;
		if (!(ALE_DRUNK >= 2)) return;
		ClientEvent("new", GetOwner(), "effects/sfx_drunk", Random(5, 30));
	}

}

}
