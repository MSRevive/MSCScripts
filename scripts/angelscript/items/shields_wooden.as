#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsWooden : CGameScript
{
	int SHIELD_HEALTH;

	ShieldsWooden()
	{
		const float PARRY_MULTI = 1.25;
		const int SHIELD_BASE_PARRY = 5;
		const float NOPUSH_CHANCE = 0.25;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 1;
		const int MODEL_BODY_OFS = 61;
		const float MELEE_ENERGY = 0.5;
		const float MELEE_ACCURACY = 0.3;
		const int BLOCK_CHANCE_UP = 90;
		const float DMG_BLOCK_UP = 0.6;
		const int BLOCK_CHANCE_DOWN = 15;
		const int SHIELD_MAXHEALTH = 200;
		const int SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 200;
		const string SHIELD_BREAK_SOUND = "debris/bustmetal1.wav";
		const string SOUND_BLOCK = "debris/wood2.wav";
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
