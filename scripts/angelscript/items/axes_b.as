#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesB : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_SWIPE;

	AxesB()
	{
		BASE_LEVEL_REQ = 18;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 5;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 51;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 3;
		MELEE_DMG = 375;
		MELEE_DMG_RANGE = 150;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.65;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
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
