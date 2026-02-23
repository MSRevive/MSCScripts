#pragma context server

#include "items/base_drink.as"

namespace MS
{

class HealthApple : CGameScript
{
	int DRINK_AMOUNT;
	string DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;

	HealthApple()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 3;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string SOUND_APPLE = "items/bite.wav";
		const int MODEL_BODY_OFS = 1;
		const string ANIM_PREFIX = "apple";
		DRINK_TYPE = "givehealth";
		DRINK_EFFECTAMT = RandomInt(1, 3);
		DRINK_AMOUNT = 4;
		DRINK_GULP_DELAY = 1;
		DRINK_TIME = 1;
		const string DRINK_WORD = "bite";
		const string DONE_PHRASE = "You devour the last bite of the juicy";
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
