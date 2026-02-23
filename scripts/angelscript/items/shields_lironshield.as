#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsLironshield : CGameScript
{
	int SHIELD_HEALTH;

	ShieldsLironshield()
	{
		const float NOPUSH_CHANCE = 1.0;
		const float PARRY_MULTI = 2.5;
		const int SHIELD_BASE_PARRY = 40;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 0;
		const int MODEL_BODY_OFS = 65;
		const int MELEE_ENERGY = 8;
		const float MELEE_ACCURACY = 0.75;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.30;
		const int BLOCK_CHANCE_DOWN = 25;
		const int SHIELD_MAXHEALTH = 4000;
		const int SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 4000;
		const string SOUND_BLOCK = "debris/bustmetal1.wav";
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
