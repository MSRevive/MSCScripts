#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsUrdual : CGameScript
{
	string SHIELD_HEALTH;

	ShieldsUrdual()
	{
		const float NOPUSH_CHANCE = 0.75;
		const float PARRY_MULTI = 3.0;
		const int SHIELD_BASE_PARRY = 40;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 3;
		const int MODEL_BODY_OFS = 73;
		const int MELEE_ENERGY = 1;
		const float MELEE_ACCURACY = 1.5;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.05;
		const int BLOCK_CHANCE_DOWN = 50;
		const string SHIELD_MAXHEALTH = "infinite";
		const int SHIELD_IMMORTAL = 1;
		SHIELD_HEALTH = "infinite";
		const string SOUND_BLOCK = "doors/doorstop5.wav";
		const int EFFECT_RANGE = 150;
	}

	void game_precache()
	{
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Urdulian Shield");
		SetDescription("A massive shield forged from the seal of a fallen temple of Urdual");
		SetWeight(200);
		SetSize(45);
		SetValue(5000);
		SetQuality(2000);
		SetHUDSprite("hand", 165);
		SetHUDSprite("trade", 165);
	}

	void game_wear()
	{
		SendPlayerMessage("You", "heft an Urdulian Shield onto your back.");
	}

	void bweapon_effect_activate()
	{
		if (!("game.item.wielded")) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		string L_SCRIPTFLAG = GetEntityProperty(GetOwner(), "itemname");
		CallExternal(GetOwner(), "plr_change_speed", -1, 0.75, L_SCRIPTFLAG);
	}

	void bweapon_effect_remove()
	{
		string L_SCRIPTFLAG = GetEntityProperty(GetOwner(), "itemname");
		CallExternal(GetOwner(), "plr_update_speed_effects", "remove", L_SCRIPTFLAG);
	}

}

}
