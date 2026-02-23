#pragma context server

#include "items/base_drink.as"

namespace MS
{

class DrinkForsuth : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;

	DrinkForsuth()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 3;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 4;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 18;
		DRINK_TYPE = "getdrunk";
		DRINK_EFFECTAMT = 50;
		DRINK_AMOUNT = 1;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Forsuth s Bitter Ale");
		SetDescription("Forsuth s bitter ale, brewed for the bitter cold.");
		SetWeight(2);
		SetSize(2);
		SetValue(1000);
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
	}

	void drink_now()
	{
		ALE_DRUNK += 1;
		if (!(ALE_DRUNK >= 1)) return;
		SendPlayerMessage("You", "feel warm and tingly all over.");
		ClientEvent("new", GetOwner(), "effects/sfx_drunk", 5);
		CallExternal(GetEntityIndex(GetOwner()), "ext_register_element", "forsu", "cold", 75);
	}

}

}
