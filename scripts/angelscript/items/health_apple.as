#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthApple : CGameScript
{
	int ANIM_DRINK;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	string DONE_PHRASE;
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	string DRINK_WORD;
	int ITEM_MODEL_VIEW_IDX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string SOUND_APPLE;

	HealthApple()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 3;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		SOUND_APPLE = "items/bite.wav";
		MODEL_BODY_OFS = 1;
		ANIM_PREFIX = "apple";
		DRINK_TYPE = "givehealth";
		DRINK_EFFECTAMT = RandomInt(1, 3);
		DRINK_AMOUNT = 4;
		DRINK_GULP_DELAY = 1;
		DRINK_TIME = 1;
		DRINK_WORD = "bite";
		DONE_PHRASE = "You devour the last bite of the juicy";
	}

	void drink_spawn()
	{
		SetName("Apple");
		SetDescription("An apple");
		SetWeight(0.3);
		SetSize(1);
		SetValue(1);
		SetHUDSprite("trade", "apple");
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		drink_deploy();
	}

	void game_fall()
	{
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 1;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
	}

	void game_start_drink()
	{
		ScheduleDelayedEvent(0.5, "do_apple_sound");
	}

	void do_apple_sound()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_APPLE, 10);
	}

}

}
