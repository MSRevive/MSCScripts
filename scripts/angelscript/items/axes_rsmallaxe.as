#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesRsmallaxe : CGameScript
{
	AxesRsmallaxe()
	{
		const string MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 98;
		const string ANIM_PREFIX = "rustedaxe";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 100;
		const int MELEE_DMG_RANGE = 80;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
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
