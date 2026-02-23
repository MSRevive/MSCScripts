#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsRsword : CGameScript
{
	SwordsRsword()
	{
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_IDLE_DELAY_LOW = 1;
		const int ANIM_IDLE_DELAY_HIGH = 3;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 24;
		const string ANIM_PREFIX = "shortsword";
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 90;
		const int MELEE_DMG_RANGE = 50;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.7;
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
		SetName("Rusty Short Sword");
		SetDescription("The rusted metal is light and easy to swing , but lessens the impact");
		SetWeight(10);
		SetSize(5);
		SetValue(3);
		SetHUDSprite("hand", "sword");
		SetHUDSprite("trade", 168);
	}

}

}
