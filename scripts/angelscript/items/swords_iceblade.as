#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsIceblade : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_ATTACK5;
	int ANIM_IDLE1;
	int ANIM_IDLE_DELAY_HIGH;
	int ANIM_IDLE_DELAY_LOW;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LUNGE;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	int FREEZE_CHANCE;
	string GAME_PVP;
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
	int SPEC_ATTACK;
	string SWING_ANIM;

	SwordsIceblade()
	{
		BASE_LEVEL_REQ = 12;
		FREEZE_CHANCE = 75;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_IDLE_DELAY_LOW = 1;
		ANIM_IDLE_DELAY_HIGH = 3;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_ATTACK4 = 5;
		ANIM_ATTACK5 = 6;
		ANIM_LUNGE = 6;
		ATTACK_ANIMS = 4;
		ANIM_SHEATH = 7;
		MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 8;
		ANIM_PREFIX = "iceblade";
		MELEE_RANGE = 64;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.4;
		MELEE_ENERGY = 2;
		MELEE_DMG = 315;
		MELEE_DMG_RANGE = 10;
		MELEE_DMG_TYPE = "cold";
		MELEE_ACCURACY = 0.7;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		SOUND_HITWALL1 = "debris/glass1.wav";
		SOUND_HITWALL2 = "debris/glass2.wav";
	}

	void weapon_spawn()
	{
		SetName("Ice Blade");
		SetDescription("A blade of enchanted cold steel");
		SetWeight(80);
		SetSize(7);
		SetValue(1000);
		SetHUDSprite("trade", 10);
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

	void special_01_start()
	{
		PlayOwnerAnim("once", "axe_twohand_swing");
		SPEC_ATTACK = 1;
		PlayViewAnim(ANIM_LUNGE);
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		GAME_PVP = "game.pvp";
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			SPEC_ATTACK = 0;
		}
		if (!(param1)) return;
		string ENEMY_HIT = GetEntityIndex(param2);
		if ((IsValidPlayer(ENEMY_HIT)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (SPEC_ATTACK == 1)
		{
			int FREEZE_ROLL = RandomInt(1, 100);
			if (FREEZE_ROLL > FREEZE_CHANCE)
			{
				SendPlayerMessage("Freeze", "attack failed.");
				EmitSound(GetOwner(), 2, "debris/zap1.wav", "const.snd.fullvol");
			}
			if (FREEZE_ROLL <= FREEZE_CHANCE)
			{
				string NME_MAXHP = GetEntityHealth(param2);
				if (NME_MAXHP > 1000)
				{
					EmitSound(GetOwner(), 2, "debris/zap1.wav", "const.snd.fullvol");
					SendPlayerMessage(GetOwner(), "This enemy is too strong to be affected by your sword's magic!");
				}
				if (NME_MAXHP < 1000)
				{
				}
				ApplyEffect(ENEMY_HIT, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), 10, "swordsmanship");
				SendPlayerMessage(GetOwner(), "The Ice Blade's magic has frozen your enemy!");
				EmitSound(GetOwner(), 2, "debris/beamstart14.wav", "const.snd.fullvol");
			}
		}
		SPEC_ATTACK = 0;
	}

}

}
