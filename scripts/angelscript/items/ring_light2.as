#pragma context server

#include "items/base_miscitem.as"
#include "items/base_effect_armor.as"

namespace MS
{

class RingLight2 : CGameScript
{
	int LIGHT_ON;

	RingLight2()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Felewyn's Light");
		SetDescription("This sigil of Felewyn shall bring light on your path forever.");
		SetWeight(0);
		SetSize(3);
		SetValue(1000);
		SetWearable(1);
		SetHUDSprite("trade", "ring");
	}

	void game_wear()
	{
		SetModel("none");
	}

	void game_newowner()
	{
		string L_BODY = "game.item.hand_index";
		L_BODY += 1;
	}

	void OnDeploy() override
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if ((LIGHT_ON)) return;
		light_on();
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if ((LIGHT_ON)) return;
		light_on();
	}

	void barmor_effect_activate()
	{
		if ((LIGHT_ON)) return;
		light_on();
	}

	void barmor_effect_remove()
	{
		if (!(LIGHT_ON)) return;
		light_off();
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		SetModelBody(0, MODEL_BODY_OFS);
		if (!(LIGHT_ON)) return;
		light_off();
	}

	void light_on()
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar"))) return;
		LIGHT_ON = 1;
		CallExternal(GAME_MASTER, "gm_light_update", "new", GetEntityIndex(GetOwner()), Vector3(255, 255, 128), 192);
	}

	void light_off()
	{
		if ((GetEntityProperty(GetOwner(), "scriptvar"))) return;
		CallExternal(GAME_MASTER, "gm_light_update", "remove", GetEntityIndex(GetOwner()), Vector3(255, 255, 128), 192);
		LIGHT_ON = 0;
	}

	void ext_restore_item_lights()
	{
		light_on();
	}

}

}
