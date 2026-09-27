#pragma context server

#include "items/mana_flesheater1.as"

namespace MS
{

class ManaFlesheater2 : CGameScript
{
	int ABORT_USE;
	int AFFLIC_REQ;
	int ANIM_DRINK;
	int ANIM_IDLE;
	string ANIM_PREFIX;
	int DRINK_TIME;
	int ITEM_MODEL_VIEW_IDX;
	string ITEM_TO_GIVE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	int SKILL_REQ;
	string SOUND_DRINK;

	ManaFlesheater2()
	{
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 2;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 39;
		ANIM_PREFIX = "mana";
		DRINK_TIME = 3;
		ABORT_USE = 0;
		SKILL_REQ = 20;
		AFFLIC_REQ = 20;
		ITEM_TO_GIVE = "blunt_gauntlets_fe2";
	}

	void item_spawn()
	{
		SetName("Greater Venom Claw Potion");
		SetDescription("This potion infuses you with power of a Flesheater.");
		SetWeight(1);
		SetSize(2);
		SetValue(3000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

}

}
