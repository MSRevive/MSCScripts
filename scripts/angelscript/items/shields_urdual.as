#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsUrdual : CGameScript
{
	int BLOCK_CHANCE_DOWN;
	int BLOCK_CHANCE_UP;
	float DMG_BLOCK_UP;
	int EFFECT_RANGE;
	float MELEE_ACCURACY;
	int MELEE_ENERGY;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	float NOPUSH_CHANCE;
	float PARRY_MULTI;
	int SHIELD_BASE_PARRY;
	string SHIELD_HEALTH;
	int SHIELD_IMMORTAL;
	string SHIELD_MAXHEALTH;
	string SOUND_BLOCK;

	ShieldsUrdual()
	{
		NOPUSH_CHANCE = 0.75;
		PARRY_MULTI = 3.0;
		SHIELD_BASE_PARRY = 40;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 3;
		MODEL_BODY_OFS = 73;
		MELEE_ENERGY = 1;
		MELEE_ACCURACY = 1.5;
		BLOCK_CHANCE_UP = 100;
		DMG_BLOCK_UP = 0.05;
		BLOCK_CHANCE_DOWN = 50;
		SHIELD_MAXHEALTH = "infinite";
		SHIELD_IMMORTAL = 1;
		SHIELD_HEALTH = "infinite";
		SOUND_BLOCK = "doors/doorstop5.wav";
		EFFECT_RANGE = 150;
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
