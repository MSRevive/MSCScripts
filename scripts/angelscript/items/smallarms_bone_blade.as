#pragma context server

#include "items/smallarms_base.as"
#include "items/base_varied_attacks.as"
#include "items/base_vampire.as"

namespace MS
{

class SmallarmsBoneBlade : CGameScript
{
	string SWING_ANIM;

	SmallarmsBoneBlade()
	{
		const int BASE_LEVEL_REQ = 15;
		const int MELEE_DMG = 180;
		const int MELEE_DMG_RANGE = 70;
		const int MELEE_RANGE = 35;
		const float MELEE_ACCURACY = 0.77;
		const string MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		const int MODEL_VIEW_IDX = 7;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 0;
		const int ANIM_UNWIELD = 0;
		const int ANIM_WIELDEDIDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "khopesh";
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
