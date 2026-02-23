#pragma context server

#include "items/base_drink.as"

namespace MS
{

class ManaFbrand : CGameScript
{
	int DRINK_AMOUNT;
	int DRINK_GULP_DELAY;
	int DRINK_TIME;

	ManaFbrand()
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
