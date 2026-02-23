#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsTestskin : CGameScript
{
	SwordsTestskin()
	{
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "weapons/swords/smallswords_skins_rview.mdl";
		const string MODEL_HANDS = "weapons/swords/p_swords.mdl";
		const string MODEL_WORLD = "weapons/swords/p_swords.mdl";
		const string MODEL_BLOCK = "armor/shields/p_shields.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "shortsword";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 140;
		const int MELEE_DMG_RANGE = 110;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Shortsword Skintest");
		SetDescription("A short one-handed Sword");
		SetWeight(30);
		SetSize(7);
		SetValue(15);
		SetHUDSprite("trade", "shortsword");
		// TODO: UNCONVERTED: setmodelskin 2
	}

}

}
