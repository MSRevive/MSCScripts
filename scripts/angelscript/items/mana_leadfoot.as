#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaLeadfoot : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaLeadfoot()
	{
		const string DRINK_TYPE = "effect";
		const int MODEL_BODY_OFS = 24;
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
		SetName("Leadfoot Potion");
		SetDescription("This potion makes you immune to being thrown by opponents.");
		SetWeight(1);
		SetSize(2);
		SetValue(500);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		SetScriptFlags(GetOwner(), "add", "pot_stability", "nopush", 1, -1, "The stability magic fades...");
		SendPlayerMessage("You", "feel unmovable.");
	}

}

}
