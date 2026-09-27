#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsTestskin : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
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
	string MELEE_VIEWANIM_ATK;
	string MODEL_BLOCK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string SOUND_SHOUT;
	string SOUND_SWIPE;

	SwordsTestskin()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "weapons/swords/smallswords_skins_rview.mdl";
		MODEL_HANDS = "weapons/swords/p_swords.mdl";
		MODEL_WORLD = "weapons/swords/p_swords.mdl";
		MODEL_BLOCK = "armor/shields/p_shields.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "shortsword";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 140;
		MELEE_DMG_RANGE = 110;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Shortsword Skintest");
		SetDescription("A short one-handed Sword");
		SetWeight(30);
		SetSize(7);
		SetValue(15);
		SetHUDSprite("trade", "shortsword");
		SetEntityModelSkin(GetOwner(), 2);
	}

}

}
