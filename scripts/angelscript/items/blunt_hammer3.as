#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntHammer3 : CGameScript
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
	string SOUND_SWIPE;

	BluntHammer3()
	{
		BASE_LEVEL_REQ = 9;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 1;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 80;
		ANIM_PREFIX = "warhammer";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.3;
		MELEE_ENERGY = 1;
		MELEE_DMG = 180;
		MELEE_DMG_RANGE = 20;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.65;
		MELEE_STAT = "bluntarms";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.1;
	}

	void weapon_spawn()
	{
		SetName("Heavy War Hammer");
		SetDescription("A large heavy war hammer");
		SetWeight(50);
		SetSize(6);
		SetValue(135);
		SetHUDSprite("trade", 70);
	}

}

}
