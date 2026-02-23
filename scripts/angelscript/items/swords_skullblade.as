#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsSkullblade : CGameScript
{
	string SWING_ANIM;

	SwordsSkullblade()
	{
		const int BASE_LEVEL_REQ = 6;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_IDLE_DELAY_LOW = 1;
		const int ANIM_IDLE_DELAY_HIGH = 3;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_ATTACK4 = 5;
		const int ANIM_ATTACK5 = 6;
		const int ANIM_SHEATH = 7;
		const string MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		const int MODEL_VIEW_IDX = 0;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 32;
		const string ANIM_PREFIX = "skullblade";
		const int MELEE_RANGE = 64;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 200;
		const int MELEE_DMG_RANGE = 10;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.6;
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
		SetName("Skullblade");
		SetDescription("This sword relies more on its weight than its sharp edge.");
		SetWeight(80);
		SetSize(7);
		SetValue(200);
		SetHUDSprite("trade", "skullblade");
	}

	void melee_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SWIPE, 10);
		if (!(true)) return;
		PlayOwnerAnim("once", "sword_swing");
		check_attack_anim();
		SWING_ANIM = CUR_ATTACK_ANIM;
		// TODO: splayviewanim ent_me SWING_ANIM
	}

}

}
