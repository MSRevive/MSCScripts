#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaFont : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaFont()
	{
		const string DRINK_TYPE = "effect";
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 2;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 39;
		const string ANIM_PREFIX = "mana";
		DRINK_AMOUNT = 1;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Mana Font Potion");
		SetDescription("This potion grants rapid mana regeneration , for a time");
		SetWeight(1);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		Effect("screenfade", GetOwner(), 2.0, 0.5, Vector3(0, 0, 255), 255, "fadeout");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 1.0, 1.0);
		CallExternal(GetOwner(), "ext_set_status_flag", "mana_pot", "mana_regen", 1, -1, "The mana font potion effect expires.");
	}

}

}
