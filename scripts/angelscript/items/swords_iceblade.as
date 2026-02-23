#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsIceblade : CGameScript
{
	string GAME_PVP;
	int SPEC_ATTACK;
	string SWING_ANIM;

	SwordsIceblade()
	{
		const int BASE_LEVEL_REQ = 12;
		const int FREEZE_CHANCE = 75;
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
		const int ANIM_LUNGE = 6;
		const int ATTACK_ANIMS = 4;
		const int ANIM_SHEATH = 7;
		const string MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 8;
		const string ANIM_PREFIX = "iceblade";
		const int MELEE_RANGE = 64;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.4;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 315;
		const int MELEE_DMG_RANGE = 10;
		const string MELEE_DMG_TYPE = "cold";
		const float MELEE_ACCURACY = 0.7;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
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
			string FREEZE_ROLL = RandomInt(1, 100);
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
