#pragma context server

#include "items/base_item.as"

namespace MS
{

class ManaImmuneFire : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_EFFECTAMT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;
	string DRINK_TYPE;
	float RESTORE_PERCENT;

	ManaImmuneFire()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 2;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 39;
		const string ANIM_PREFIX = "mana";
		DRINK_TYPE = "givemana";
		RESTORE_PERCENT = 0.9;
		DRINK_EFFECTAMT = 300;
		DRINK_AMOUNT = 1;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Fire Immunity Potion");
		SetDescription("Brewed from the heart blood of an Efreeti");
		SetWeight(1);
		SetSize(1);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void OnSpawn() override
	{
		SetHand("any");
		SetAnimExt("holditem");
		drink_spawn();
		RegisterDrink();
	}

	void game_start_drink()
	{
		PlayViewAnim(ANIM_DRINK);
		drink_start();
	}

	void game_drink()
	{
		CallExternal(GetEntityIndex(GetOwner()), "ext_register_element", "firip", "fire", 100);
		drink_now();
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_BREATHFAST2')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void game_drink_done()
	{
		PlayViewAnim(ANIM_IDLE);
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		drink_deploy();
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

}

}
