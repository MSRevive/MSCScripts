#pragma context server

#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsGiceblade : CGameScript
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
	int FREEZE_MP;
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

	SwordsGiceblade()
	{
		BASE_LEVEL_REQ = 15;
		FREEZE_CHANCE = 65;
		FREEZE_MP = 5;
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
		MODEL_VIEW_IDX = 3;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 52;
		ANIM_PREFIX = "skullblade";
		MELEE_RANGE = 64;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.4;
		MELEE_ENERGY = 5;
		MELEE_DMG = 320;
		MELEE_DMG_RANGE = 30;
		MELEE_DMG_TYPE = "cold";
		MELEE_ACCURACY = 0.72;
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
		SetName("Greater Ice Blade");
		SetDescription("An ancient blade of enchanted crystal");
		SetWeight(80);
		SetSize(7);
		SetValue(3500);
		SetHUDSprite("trade", 96);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		GAME_PVP = "game.pvp";
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

	void special_01_damaged_other()
	{
		if (!(GetEntityMP(GetOwner()) >= 10)) return;
		GiveMP(GetOwner());
		if (RandomInt(1, 100) > FREEZE_CHANCE)
		{
			SendPlayerMessage("Freeze", "attack failed.");
			EmitSound(GetOwner(), 2, "debris/zap1.wav", 10);
		}
		else
		{
			if ((IsValidPlayer(param1)))
			{
				if (("game.pvp"))
				{
				}
				ApplyEffect(param1, "effects/dot_cold_freeze", Random(5, 7), GetEntityIndex(GetOwner()));
			}
			else
			{
				string MON_HP = GetEntityHealth(param1);
				if (MON_HP > 1500)
				{
					SendPlayerMessage(GetEntityName(param1), "is too strong to be affected!");
				}
				if (MON_HP <= 1500)
				{
				}
				if (/* TODO: $get_takedmg */ $get_takedmg(param1, "cold") > 0)
				{
					SendPlayerMessage(GetOwner(), "Your sword's magic has encased your enemy in ice!");
					ApplyEffect(param1, "effects/dot_cold_freeze", Random(5, 7), GetEntityIndex(GetOwner()));
					EmitSound(GetOwner(), 2, "debris/beamstart14.wav", 10);
				}
				else
				{
					SendPlayerMessage(GetEntityName(param1), "is immune to ice magic!");
				}
			}
		}
	}

	void melee_damaged_other()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		int RND_FREEZE = RandomInt(1, 3);
		if (RND_FREEZE == 1)
		{
			string FREEZE_DMG = GetSkillLevel(GetOwner(), "spellcasting.ice");
			FREEZE_DMG *= 0.25;
			ApplyEffect(param1, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), FREEZE_DMG, "spellcasting.ice");
		}
	}

}

}
