#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntRudolfsmace : CGameScript
{
	string ANIM_PREFIX;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string SOUND_SWIPE;

	BluntRudolfsmace()
	{
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 3;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 56;
		ANIM_PREFIX = "mace";
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 2;
		MELEE_DMG = 150;
		MELEE_DMG_RANGE = 110;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "bluntarms";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Odd Mace");
		SetDescription("An odd one-handed mace");
		SetWeight(35);
		SetSize(6);
		SetValue(30);
		SetHUDSprite("trade", 98);
	}

}

}
