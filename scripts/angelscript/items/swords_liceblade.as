#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsLiceblade : CGameScript
{
	int FREEZE_HITS;
	string SWING_ANIM;

	SwordsLiceblade()
	{
		const int BASE_LEVEL_REQ = 6;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 48;
		const int MELEE_RANGE = 60;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 150;
		const int MELEE_DMG_RANGE = 120;
		const string MELEE_DMG_TYPE = "cold";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string ANIM_PREFIX = "shortsword";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.15;
		const int FREEZE_HITS_NEEDED = 10;
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
	}

	void weapon_spawn()
	{
		SetName("Lesser Ice Blade");
		SetDescription("A shortsword variant of the Ice Blade used by elite Marogar");
		SetWeight(30);
		SetSize(7);
		SetValue(400);
		SetHUDSprite("trade", 95);
		FREEZE_HITS = 1;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		FREEZE_HITS += 1;
		if (!(FREEZE_HITS == 10)) return;
		string ENEMY_HIT = GetEntityIndex(param2);
		string NME_MAXHP = GetEntityHealth(param2);
		if (NME_MAXHP > 500)
		{
			SendPlayerMessage("This", "enemy is too strong to be affected by your swords magic!");
		}
		if (!(NME_MAXHP < 500)) return;
		ApplyEffect(ENEMY_HIT, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), 10, "swordsmanship");
		SendPlayerMessage(GetOwner(), "The Ice Blade's magic has frozen your enemy!");
		EmitSound(GetOwner(), 0, "debris/beamstart14.wav", 10);
		FREEZE_HITS = 1;
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
