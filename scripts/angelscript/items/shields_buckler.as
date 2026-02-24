#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsBuckler : CGameScript
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

	ShieldsBuckler()
	{
		NOPUSH_CHANCE = 0.25;
		PARRY_MULTI = 1.3;
		SHIELD_BASE_PARRY = 10;
		MODEL_VIEW = "viewmodels/v_shields.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_BODY_OFS = 61;
		MELEE_ENERGY = 15;
		MELEE_ACCURACY = 0.9;
		BLOCK_CHANCE_UP = 100;
		DMG_BLOCK_UP = 0.4;
		BLOCK_CHANCE_DOWN = 15;
		SHIELD_MAXHEALTH = 500;
		SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 500;
		SOUND_BLOCK = "debris/metal3.wav";
		Precache(SOUND_BLOCK);
	}

	void shield_spawn()
	{
		SetName("Training shield");
		SetDescription("A light shield for deflecting blows");
		SetWeight(10);
		SetSize(30);
		SetValue(50);
		SetQuality(60);
		SetHUDSprite("trade", 178);
	}

	void game_wear()
	{
		SendPlayerMessage("You", "sling a training shield over your shoulder.");
	}

}

}
