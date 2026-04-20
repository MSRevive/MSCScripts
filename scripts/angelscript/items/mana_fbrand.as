#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaFbrand : CGameScript
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

	ManaFbrand()
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
		DRINK_AMOUNT = 3;
		DRINK_GULP_DELAY = 3;
		DRINK_TIME = 3;
	}

	void drink_spawn()
	{
		SetName("Fire Brand Potion");
		SetDescription("This potion adds burning damage to all attacks and increases fire damage");
		SetWeight(1);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
	}

	void drink_effect()
	{
		CallExternal(GetOwner(), "ext_dmg_adjust", "fire", 2.0);
		CallExternal(GetOwner(), "ext_dmg_add_dot", "fire", 1.0);
		Effect("screenfade", GetOwner(), 2.0, 0.5, Vector3(255, 0, 0), 255, "fadeout");
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 1.0, 1.0);
		EmitSound(GetOwner(), 0, "magic/volcano_start.wav", 10);
		SendColoredMessage(GetOwner(), "Fire damage added for all attacks.");
		SendColoredMessage(GetOwner(), "Fire damage increased.");
	}

}

}
