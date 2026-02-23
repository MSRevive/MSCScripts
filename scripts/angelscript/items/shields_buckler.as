#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsBuckler : CGameScript
{
	int SHIELD_HEALTH;

	ShieldsBuckler()
	{
		const float NOPUSH_CHANCE = 0.25;
		const float PARRY_MULTI = 1.3;
		const int SHIELD_BASE_PARRY = 10;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 1;
		const int MODEL_BODY_OFS = 61;
		const int MELEE_ENERGY = 15;
		const float MELEE_ACCURACY = 0.9;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.4;
		const int BLOCK_CHANCE_DOWN = 15;
		const int SHIELD_MAXHEALTH = 500;
		const int SHIELD_IMMORTAL = 0;
		SHIELD_HEALTH = 500;
		const string SOUND_BLOCK = "debris/metal3.wav";
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
