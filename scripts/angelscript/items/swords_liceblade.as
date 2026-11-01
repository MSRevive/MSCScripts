#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsLiceblade : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	int FREEZE_HITS;
	int FREEZE_HITS_NEEDED;
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
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SHOUT;
	string SOUND_SWIPE;
	string SWING_ANIM;

	SwordsLiceblade()
	{
		BASE_LEVEL_REQ = 6;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 48;
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 150;
		MELEE_DMG_RANGE = 120;
		MELEE_DMG_TYPE = "cold";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		ANIM_PREFIX = "shortsword";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.15;
		FREEZE_HITS_NEEDED = 10;
		SOUND_HITWALL1 = "debris/glass1.wav";
		SOUND_HITWALL2 = "debris/glass2.wav";
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
