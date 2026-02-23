#pragma context server

#include "items/mana_flesheater1.as"

namespace MS
{

class ManaFlesheater2 : CGameScript
{
	int ABORT_USE;

	ManaFlesheater2()
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
		const int DRINK_TIME = 3;
		ABORT_USE = 0;
		const int SKILL_REQ = 20;
		const int AFFLIC_REQ = 20;
		const string ITEM_TO_GIVE = "blunt_gauntlets_fe2";
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
