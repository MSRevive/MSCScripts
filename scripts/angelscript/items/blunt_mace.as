#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntMace : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string SOUND_SWIPE;

	BluntMace()
	{
		BASE_LEVEL_REQ = 6;
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 0;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 68;
		ANIM_PREFIX = "mace";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.2;
		MELEE_ENERGY = 0.6;
		MELEE_DMG = 150;
		MELEE_DMG_RANGE = 20;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "bluntarms";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Mace");
		SetDescription("A one-handed mace");
		SetWeight(30);
		SetSize(6);
		SetValue(45);
		SetHUDSprite("hand", "mace");
		SetHUDSprite("trade", "mace");
	}

}

}
