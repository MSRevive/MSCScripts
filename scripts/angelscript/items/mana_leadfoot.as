#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaLeadfoot : CGameScript
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

	ManaLeadfoot()
	{
		DRINK_TYPE = "effect";
		MODEL_BODY_OFS = 24;
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 2;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 39;
		ANIM_PREFIX = "mana";
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
