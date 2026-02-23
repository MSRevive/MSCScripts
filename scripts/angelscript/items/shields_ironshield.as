#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsIronshield : CGameScript
{
	int SHIELD_HEALTH;

	ShieldsIronshield()
	{
		const float NOPUSH_CHANCE = 0.5;
		const float PARRY_MULTI = 1.75;
		const int SHIELD_BASE_PARRY = 20;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 0;
		const int MODEL_BODY_OFS = 65;
		const int MELEE_ENERGY = 4;
		const float MELEE_ACCURACY = 0.5;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.35;
		const int BLOCK_CHANCE_DOWN = 20;
		const int SHIELD_MAXHEALTH = 1000;
		const int SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 1000;
		const string SOUND_BLOCK = "body/armour2.wav";
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
