#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntMs3 : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
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
	string MODEL_WORLD;
	string SOUND_SWIPE;

	BluntMs3()
	{
		BASE_LEVEL_REQ = 20;
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 7;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 87;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 8;
		MELEE_DMG = 250;
		MELEE_DMG_RANGE = 140;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.8;
		MELEE_STAT = "bluntarms";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Fine Morning Star");
		SetDescription("A masterfully crafted morning star");
		SetWeight(35);
		SetSize(6);
		SetValue(1500);
		SetHUDSprite("hand", "mace");
		SetHUDSprite("trade", 187);
	}

}

}
