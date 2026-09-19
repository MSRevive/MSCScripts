#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesRsmallaxe : CGameScript
{
	string ANIM_PREFIX;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string SOUND_SWIPE;

	AxesRsmallaxe()
	{
		MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		MODEL_VIEW_IDX = 1;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 98;
		ANIM_PREFIX = "rustedaxe";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 100;
		MELEE_DMG_RANGE = 80;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Rusted Axe");
		SetDescription("The rusted core makes the axe lighter and easier to swing , but less damaging");
		SetWeight(10);
		SetSize(5);
		SetValue(3);
		SetHUDSprite("hand", 176);
		SetHUDSprite("trade", 176);
	}

}

}
