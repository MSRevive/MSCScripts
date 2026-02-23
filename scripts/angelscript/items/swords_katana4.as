#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsKatana4 : CGameScript
{
	SwordsKatana4()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_LIFT1 = 6;
		const int ANIM_IDLE1 = 7;
		const int ANIM_ATTACK1 = 8;
		const int ANIM_ATTACK2 = 9;
		const int ANIM_ATTACK3 = 10;
		const int ANIM_ATTACK4 = 11;
		const int ANIM_ATTACK5 = 12;
		const int ANIM_SHEATH = 13;
		const int ATTACK_ANIMS = 5;
		const string MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit1.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 0;
		const string ANIM_PREFIX = "dragonsword";
		const int MELEE_RANGE = 64;
		const float MELEE_DMG_DELAY = 0.3;
		const float MELEE_ATK_DURATION = 0.7;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 160;
		const int MELEE_DMG_RANGE = 70;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.8;
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
		SetName("Torkalath blade");
		SetDescription("A blade of vicious beauty crafted by the dark elves");
		SetWeight(35);
		SetSize(5);
		SetValue(2000);
		SetHUDSprite("trade", "dragonsword");
	}

}

}
