#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaFaura : CGameScript
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

	ManaFaura()
	{
		DRINK_TYPE = "effect";
		ANIM_IDLE = 0;
		ANIM_DRINK = 1;
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "viewmodels/v_misc.mdl";
		ITEM_MODEL_VIEW_IDX = 2;
		SOUND_DRINK = "items/drink.wav";
		MODEL_BODY_OFS = 39;
		ANIM_PREFIX = "mana";
		DRINK_AMOUNT = 5;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Fire Aura Potion");
		SetDescription("This potion wreaths you in a protective aura of fire");
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
		string AURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		AURA_DOT *= 0.5;
		CallExternal(GetOwner(), "ext_fire_aura_activate", AURA_DOT, 48);
		CallExternal(GetOwner(), "ext_register_element", "faurp", "cold", 50);
	}

}

}
