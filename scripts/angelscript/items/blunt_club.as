#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntClub : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_ATTACK5;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
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

	BluntClub()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_ATTACK4 = 5;
		ANIM_ATTACK5 = 6;
		ANIM_SHEATH = 1;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 2;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 59;
		ANIM_PREFIX = "club";
		MELEE_RANGE = 90;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 1;
		MELEE_DMG = 100;
		MELEE_DMG_RANGE = 60;
		MELEE_DMG_TYPE = "blunt";
		MELEE_ACCURACY = 0.5;
		MELEE_STAT = "bluntarms";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.0;
	}

	void weapon_spawn()
	{
		SetName("Wooden Club");
		SetDescription("A big wooden club");
		SetWeight(10);
		SetSize(5);
		SetValue(10);
		SetHUDSprite("hand", "club");
		SetHUDSprite("trade", 73);
	}

}

}
