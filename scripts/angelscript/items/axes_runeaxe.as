#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesRuneaxe : CGameScript
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

	AxesRuneaxe()
	{
		BASE_LEVEL_REQ = 20;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 9;
		ANIM_ATTACK2 = 10;
		ANIM_ATTACK3 = 11;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		Precache(MODEL_VIEW);
		MODEL_BODY_OFS = 95;
		ANIM_PREFIX = "axe";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 0.7;
		MELEE_ENERGY = 4;
		MELEE_DMG = 160;
		MELEE_DMG_RANGE = 70;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Rune Axe");
		SetDescription("An axe hastened by ancient magiks");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", "runeaxe");
		Precache(MODEL_VIEW);
	}

}

}
