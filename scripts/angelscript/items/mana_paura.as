#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaPaura : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaPaura()
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
		DRINK_AMOUNT = 5;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Poison Aura Potion");
		SetDescription("This potion wreaths you in a poisonous mist");
		SetWeight(1);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		Effect("screenfade", GetOwner(), 2.0, 0.5, Vector3(255, 0, 0), 255, "fadeout");
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 1.0, 1.0);
		string AURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		AURA_DOT *= 0.5;
		CallExternal(GetOwner(), "ext_poison_aura_activate", AURA_DOT, 64);
		CallExternal(GetOwner(), "ext_register_element", "paurp", "poison", 50);
	}

}

}
