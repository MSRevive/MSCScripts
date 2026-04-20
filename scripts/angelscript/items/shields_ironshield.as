#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsIronshield : CGameScript
{
	int BLOCK_CHANCE_DOWN;
	int BLOCK_CHANCE_UP;
	float DMG_BLOCK_UP;
	float MELEE_ACCURACY;
	int MELEE_ENERGY;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	float NOPUSH_CHANCE;
	float PARRY_MULTI;
	int SHIELD_BASE_PARRY;
	int SHIELD_HEALTH;
	int SHIELD_IMMORTAL;
	int SHIELD_MAXHEALTH;
	string SOUND_BLOCK;

	ShieldsIronshield()
	{
		NOPUSH_CHANCE = 0.5;
		PARRY_MULTI = 1.75;
		SHIELD_BASE_PARRY = 20;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 0;
		MODEL_BODY_OFS = 65;
		MELEE_ENERGY = 4;
		MELEE_ACCURACY = 0.5;
		BLOCK_CHANCE_UP = 100;
		DMG_BLOCK_UP = 0.35;
		BLOCK_CHANCE_DOWN = 20;
		SHIELD_MAXHEALTH = 1000;
		SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 1000;
		SOUND_BLOCK = "body/armour2.wav";
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Iron Shield");
		SetDescription("An Iron shield");
		SetWeight(40);
		SetSize(45);
		SetValue(600);
		SetQuality(150);
		SetHUDSprite("hand", "ironshield");
		SetHUDSprite("trade", "ironshield");
	}

	void game_wear()
	{
		SendPlayerMessage("You", "sling an iron shield over your shoulder.");
	}

}

}
