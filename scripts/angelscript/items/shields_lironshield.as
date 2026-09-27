#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsLironshield : CGameScript
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

	ShieldsLironshield()
	{
		NOPUSH_CHANCE = 1.0;
		PARRY_MULTI = 2.5;
		SHIELD_BASE_PARRY = 40;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 0;
		MODEL_BODY_OFS = 65;
		MELEE_ENERGY = 8;
		MELEE_ACCURACY = 0.75;
		BLOCK_CHANCE_UP = 100;
		DMG_BLOCK_UP = 0.30;
		BLOCK_CHANCE_DOWN = 25;
		SHIELD_MAXHEALTH = 4000;
		SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 4000;
		SOUND_BLOCK = "debris/bustmetal1.wav";
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Large Iron Shield");
		SetDescription("A large Iron shield");
		SetWeight(60);
		SetSize(70);
		SetValue(2200);
		SetQuality(600);
		SetHUDSprite("hand", "ironshield");
		SetHUDSprite("trade", "ironshield");
	}

}

}
