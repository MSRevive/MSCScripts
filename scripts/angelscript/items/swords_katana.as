#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsKatana : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_ATTACK5;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
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
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SHOUT;
	string SOUND_SWIPE;

	SwordsKatana()
	{
		BASE_LEVEL_REQ = 6;
		ANIM_LIFT1 = 6;
		ANIM_IDLE1 = 7;
		ANIM_ATTACK1 = 8;
		ANIM_ATTACK2 = 9;
		ANIM_ATTACK3 = 10;
		ANIM_ATTACK4 = 11;
		ANIM_ATTACK5 = 12;
		ANIM_SHEATH = 13;
		ATTACK_ANIMS = 5;
		MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 0;
		ANIM_PREFIX = "dragonsword";
		MELEE_RANGE = 64;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.0;
		MELEE_ENERGY = 1;
		MELEE_DMG = 160;
		MELEE_DMG_RANGE = 10;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.65;
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
		SetName("Elven Shortsword");
		SetDescription("A smooth , balanced Elven shortsword");
		SetWeight(35);
		SetSize(5);
		SetValue(50);
		SetHUDSprite("trade", "dragonsword");
	}

}

}
