#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsNkatana : CGameScript
{
	SwordsNkatana()
	{
		const int BASE_LEVEL_REQ = 6;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		const int MODEL_VIEW_IDX = 3;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 12;
		const string ANIM_PREFIX = "shortsword";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 130;
		const int MELEE_DMG_RANGE = 10;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.15;
	}

	void weapon_spawn()
	{
		SetName("Folded Steel Blade");
		SetDescription("This blade of folded steel provides superior balance");
		SetWeight(30);
		SetSize(5);
		SetValue(45);
		SetHUDSprite("trade", 34);
	}

}

}
