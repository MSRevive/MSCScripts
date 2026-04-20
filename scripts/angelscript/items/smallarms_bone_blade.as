#pragma context server

#include "items/smallarms_base.as"
#include "items/base_varied_attacks.as"
#include "items/base_vampire.as"

namespace MS
{

class SmallarmsBoneBlade : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_UNWIELD;
	int ANIM_WIELD;
	int ANIM_WIELDEDIDLE1;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SWING_ANIM;

	SmallarmsBoneBlade()
	{
		BASE_LEVEL_REQ = 15;
		MELEE_DMG = 180;
		MELEE_DMG_RANGE = 70;
		MELEE_RANGE = 35;
		MELEE_ACCURACY = 0.77;
		MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		MODEL_VIEW_IDX = 7;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_WIELD = 0;
		ANIM_UNWIELD = 0;
		ANIM_WIELDEDIDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_PARRY_CHANCE = 0.3;
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "khopesh";
	}

	void weapon_spawn()
	{
		SetName("Bone Blade");
		SetDescription("A wicked blade of cursed bone");
		SetWeight(3);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("hand", 106);
		SetHUDSprite("trade", 106);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string HEAL_AMT = GetEntityProperty(m_hLastStruckByMe, "scriptvar");
		HEAL_AMT /= 5;
		if (HEAL_AMT > 20)
		{
			int HEAL_AMT = 20;
		}
		Effect("glow", GetOwner(), Vector3(0, 100, 0), 60, 1, 1);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param2), HEAL_AMT);
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
