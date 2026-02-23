#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesB : CGameScript
{
	AxesB()
	{
		const int BASE_LEVEL_REQ = 18;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 5;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 51;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 3;
		const int MELEE_DMG = 375;
		const int MELEE_DMG_RANGE = 150;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.65;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Axe of Balance");
		SetDescription("This ornate axe is forged to favor accuracy over damage");
		SetWeight(90);
		SetSize(25);
		SetValue(1200);
		SetHUDSprite("hand", 137);
		SetHUDSprite("trade", 137);
	}

}

}
