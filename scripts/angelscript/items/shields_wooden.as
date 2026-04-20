#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsWooden : CGameScript
{
	int BLOCK_CHANCE_DOWN;
	int BLOCK_CHANCE_UP;
	float DMG_BLOCK_UP;
	float MELEE_ACCURACY;
	float MELEE_ENERGY;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	float NOPUSH_CHANCE;
	float PARRY_MULTI;
	int SHIELD_BASE_PARRY;
	string SHIELD_BREAK_SOUND;
	int SHIELD_HEALTH;
	int SHIELD_IMMORTAL;
	int SHIELD_MAXHEALTH;
	string SOUND_BLOCK;

	ShieldsWooden()
	{
		PARRY_MULTI = 1.25;
		SHIELD_BASE_PARRY = 5;
		NOPUSH_CHANCE = 0.25;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_BODY_OFS = 61;
		MELEE_ENERGY = 0.5;
		MELEE_ACCURACY = 0.3;
		BLOCK_CHANCE_UP = 90;
		DMG_BLOCK_UP = 0.6;
		BLOCK_CHANCE_DOWN = 15;
		SHIELD_MAXHEALTH = 200;
		SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 200;
		SHIELD_BREAK_SOUND = "debris/bustmetal1.wav";
		SOUND_BLOCK = "debris/wood2.wav";
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Wooden Shield");
		SetDescription("A poor defense , but still better than your forearm.");
		SetWeight(15);
		SetSize(30);
		SetValue(35);
		SetQuality(60);
		SetHUDSprite("hand", "ironshield");
		SetHUDSprite("trade", 178);
	}

	void game_wear()
	{
		SendPlayerMessage("You", "sling a wooden shield over your shoulder.");
	}

}

}
