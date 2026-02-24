#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Cavetroll : CGameScript
{
	string ALT_MODEL;
	int AM_GERIC;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FULLRUN;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SLASH;
	string ANIM_SMASH;
	string ANIM_THROW;
	string ANIM_WALK;
	string ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	string CAN_FLINCH;
	string DELAY_NEXT_THROW;
	int I_AM_TURNABLE;
	string MAIN_MODEL;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	string NPC_EXP_MULTI;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	int ROAM_ON;
	string SET_GREEK;
	int SLASH_HITRANGE;
	int SLASH_RANGE;
	int SMASH_HITRANGE;
	int SMASH_RANGE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_FALL;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_PUSH;
	string SOUND_SPAWN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	int STUN_ATTACK;
	int THROW_COUNT;
	string THROW_DELAY;
	float THROW_FREQ;
	int THROW_RANGE;
	string THROW_TARGET;
	string THROW_TIME;

	Cavetroll()
	{
		if (StringToLower(GetMapName()) == "calruin2")
		{
			NPC_IS_BOSS = 1;
		}
		if (StringToLower(GetMapName()) == "calruin")
		{
			NPC_IS_BOSS = 1;
		}
		if (StringToLower(GetMapName()) == "ww3d")
		{
			NPC_IS_BOSS = 1;
		}
		if (!(NPC_IS_BOSS))
		{
			NPC_EXP_MULTI = 0.25;
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 1.0;
		ANIM_DEATH = "diesimple";
		SOUND_STRUCK1 = "controller/con_pain2.wav";
		SOUND_STRUCK2 = "controller/con_pain3.wav";
		SOUND_ATTACK1 = "zombie/claw_strike1.wav";
		SOUND_ATTACK2 = "zombie/claw_strike2.wav";
		SOUND_ATTACK3 = "zombie/claw_strike3.wav";
		SOUND_DEATH = "garg/gar_die2.wav";
		SOUND_SPAWN = "garg/gar_alert2.wav";
		SOUND_FLINCH1 = "garg/gar_pain3.wav";
		SOUND_FLINCH2 = "garg/gar_pain2.wav";
		SOUND_PUSH = "garg/gar_attack3.wav";
		SOUND_FALL = "weapons/mortarhit.wav";
		ANIM_RUN = "walk";
		ANIM_FULLRUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_SMASH = "attack2";
		ANIM_SLASH = "attack1";
		ANIM_ATTACK = ANIM_SLASH;
		SLASH_RANGE = 150;
		SMASH_RANGE = 100;
		SLASH_HITRANGE = 200;
		SMASH_HITRANGE = 125;
		THROW_RANGE = 250;
		ATTACK_RANGE = SMASH_RANGE;
		ATTACK_MOVERANGE = 50;
		ATTACK_HITRANGE = SLASH_HITRANGE;
		THROW_FREQ = 10.0;
		NPC_MUST_SEE_TARGET = 0;
		MAIN_MODEL = "monsters/skeleton_hood.mdl";
		ALT_MODEL = "monsters/skeleton_boss2.mdl";
		Precache(ALT_MODEL);
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		I_AM_TURNABLE = 0;
		if (L_MAP_NAME == "ww3d")
		{
			geric_mode();
		}
		if ((FORCE_GERIC))
		{
			geric_mode();
		}
		if (!(AM_GERIC))
		{
			SetName("Garonhroth the Blacksmith");
			SetModel(MAIN_MODEL);
			ANIM_THROW = "throw_scientist";
			THROW_TIME = 15;
			THROW_DELAY = 2.0;
			THROW_FREQ = 20.0;
			if ((NPC_IS_BOSS))
			{
				NPC_GIVE_EXP = 2000;
			}
			if (!(NPC_IS_BOSS))
			{
				NPC_GIVE_EXP = 1000;
			}
		}
		SetHealth(6000);
		SetGold(RandomInt(100, 300));
		SetWidth(40);
		SetHeight(120);
		SetRace("undead");
		SetSolid("box");
		SetRoam(false);
		SetHearingSensitivity(12);
		string CURRENT_MAP = GetMapName();
		if (CURRENT_MAP == "calruin2")
		{
			SetModelBody(0, 1);
		}
		if (CURRENT_MAP == "calruin2_1")
		{
			SetModelBody(0, 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
		SetDamageResistance("all", 0.6);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("poison", 0.0);
		THROW_COUNT = 0;
		EmitSound(GetOwner(), 0, SOUND_SPAWN, 10);
	}

	void npcatk_get_postspawn_properties()
	{
		if (!(AM_GERIC)) return;
		ANIM_RUN = ANIM_FULLRUN;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((ROAM_ON)) return;
		ROAM_ON = 1;
		SetRoam(true);
	}

	void attack_1()
	{
		if (GetEntityRange(m_hAttackTarget) < SLASH_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", Random(40.0, 55.0), 0.75, GetEntityIndex(GetOwner()), "slash");
		}
		if (!(RandomInt(1, 10) == 1)) return;
		ANIM_ATTACK = ANIM_SMASH;
		ATTACK_RANGE = SMASH_RANGE;
		ATTACK_HITRANGE = SMASH_HITRANGE;
	}

	void attack_2()
	{
		if (GetEntityRange(m_hAttackTarget) < SMASH_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", Random(30.0, 40.0), 1.0, GetEntityIndex(GetOwner()), "blunt");
		}
		STUN_ATTACK = 1;
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		ANIM_ATTACK = ANIM_SLASH;
		ATTACK_RANGE = SLASH_RANGE;
		ATTACK_HITRANGE = SLASH_HITRANGE;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_CURRENT_HP = GetEntityHealth(GetOwner());
		if (MY_CURRENT_HP < 2000)
		{
			CAN_FLINCH = 1;
		}
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnFlinch()
	{
		if (!(CAN_FLINCH)) return;
		PlayAnim("critical", ANIM_FLINCH);
		// PlayRandomSound from: SOUND_FLINCH1, SOUND_FLINCH2
		array<string> sounds = {SOUND_FLINCH1, SOUND_FLINCH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (StringToLower(GetMapName()) == "ww3d")
		{
			CallExternal("players", "ext_clear_valid_gauntlets");
		}
		kaboom_bs();
	}

	void kaboom_bs()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 10, 2, 1024);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_FALL, 10);
	}

	void give_clubs()
	{
		SetModelBody(0, 1);
	}

	void invincible_on()
	{
		SetInvincible(true);
	}

	void vulnerable()
	{
		SetInvincible(false);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(ANIM_ATTACK == "attack1")) return;
		THROW_COUNT += 1;
		if (THROW_COUNT > THROW_TIME)
		{
			THROW_COUNT = 0;
			if (!(DELAY_NEXT_THROW))
			{
			}
			DELAY_NEXT_THROW = 1;
			THROW_FREQ("reset_throw");
			PlayAnim("once", "break");
			PlayAnim("critical", ANIM_THROW);
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_PUSH, 10);
			THROW_TARGET = param2;
			npcatk_suspend_ai(2.0);
			THROW_DELAY("throw_chummer");
		}
	}

	void reset_throw()
	{
		DELAY_NEXT_THROW = 0;
	}

	void throw_chummer()
	{
		if (!(GetEntityRange(THROW_TARGET) < THROW_RANGE)) return;
		ApplyEffect(THROW_TARGET, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 800, 800), 0);
	}

	void geric_mode()
	{
		AM_GERIC = 1;
		THROW_TIME = 10;
		ANIM_THROW = "bigflinch";
		THROW_DELAY = 0.5;
		THROW_FREQ = 8.0;
		SetMoveSpeed(2.0);
		SetName("The Dread Knight Sir Geric");
		SetDamageResistance("fire", 0.1);
		SetModel(ALT_MODEL);
		SetModelBody(0, 9);
		SetModelBody(1, 4);
		ANIM_RUN = ANIM_FULLRUN;
		SetStat("parry", 100);
		if ((NPC_IS_BOSS))
		{
			NPC_GIVE_EXP = 5000;
		}
		if (!(NPC_IS_BOSS))
		{
			NPC_GIVE_EXP = 800;
		}
		SetRoam(true);
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(STUN_ATTACK)) return;
		STUN_ATTACK = 0;
		ApplyEffect(param1, "effects/effect_push", 1, /* TODO: $relvel */ $relvel(0, 200, 30), 0);
	}

	void go_greek()
	{
		SetModelBody(0, 10);
		SET_GREEK = 1;
	}

}

}
