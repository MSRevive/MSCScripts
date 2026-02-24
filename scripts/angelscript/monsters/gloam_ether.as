#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GloamEther : CGameScript
{
	int AM_CLOAKED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_GALLOP;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_PROJECTILE;
	string ANIM_RUN;
	string ANIM_VICTORY;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CALLED_BY_DANGER;
	int CYCLES_STARTED;
	int DMG_SPITWAD;
	int DMG_SPORE;
	int DMG_SWIPE;
	float DUR_CLOAK;
	float FREQ_CLOAK;
	float FREQ_SPITWAD;
	float FREQ_SPORES;
	string NEXT_VICTORY;
	float NPC_BOSS_REGEN_RATE;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	string PUSH_TARG;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACKHIT1;
	string SOUND_ATTACKHIT2;
	string SOUND_CLOAK;
	string SOUND_DEATH;
	string SOUND_JUMP;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SPITWAD;
	string SOUND_SPORES;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	int SPIT_WADS;
	int SPORE_POISON_DMG;
	int SWIPE_ATTACK;

	GloamEther()
	{
		SetCallback("touch", "enable");
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.05;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle_1";
		ANIM_FLINCH = "flinchb";
		ANIM_ATTACK = "bite";
		ANIM_DEATH = "die";
		ANIM_GALLOP = "gallop";
		ANIM_JUMP = "jump";
		ANIM_PROJECTILE = "turnright";
		ANIM_VICTORY = "eat";
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 34;
		NPC_GIVE_EXP = 600;
		FREQ_SPORES = 30.0;
		FREQ_SPITWAD = Random(15, 20);
		FREQ_CLOAK = Random(15, 30);
		DUR_CLOAK = 10.0;
		DMG_SWIPE = "$rand(80,150)";
		SPORE_POISON_DMG = 50;
		DMG_SPORE = 200;
		DMG_SPITWAD = 80;
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		SOUND_CLOAK = "magic/spawn.wav";
		SOUND_DEATH = "aslave/slv_die2.wav";
		SOUND_PAIN1 = "aslave/slv_pain1.wav";
		SOUND_PAIN2 = "aslave/slv_pain2.wav";
		SOUND_SPORES = "bullchicken/bc_attack3.wav";
		SOUND_SPITWAD = "headcrab/hc_attack1.wav";
		SOUND_JUMP = "aslave/slv_alert3.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((SPIT_WADS))
		{
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
				end_spitwad();
			}
			else
			{
				PlayAnim("once", "flinchs");
				SetMoveDest(m_hAttackTarget);
			}
		}
		if (!(AM_CLOAKED))
		{
			SetProp(GetOwner(), "renderamt", 255);
			SetProp(GetOwner(), "renderfx", 16);
		}
		if ((AM_CLOAKED))
		{
		}
		SetProp(GetOwner(), "renderamt", 0);
		if (PUSH_TARG != "unset")
		{
		}
		int RND_RL = RandomInt(-1, 1);
		RND_RL *= 400;
		AddVelocity(PUSH_TARG, /* TODO: $relvel */ $relvel(RND_RL, 800, 400));
		PUSH_TARG = "unset";
	}

	void OnSpawn() override
	{
		SetName("Ether Gloam");
		SetModel("monsters/hunter1.mdl");
		SetRace("demon");
		SetBloodType("green");
		SetHearingSensitivity(11);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetWidth(32);
		SetHeight(32);
		SetHealth(5000);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
		SetDamageResistance("all", 0.6);
		SetDamageResistance("poison", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("dark", 0.5);
		AM_CLOAKED = 0;
		PUSH_TARG = "unset";
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void cycle_up()
	{
		start_cycles();
	}

	void cycle_npc()
	{
		start_cycles();
	}

	void start_cycles()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_CLOAK("do_cloak");
		FREQ_SPORES("do_spores");
		FREQ_SPITWAD("do_spitwad");
	}

	void do_cloak()
	{
		if (!(CALLED_BY_DANGER))
		{
			FREQ_CLOAK("do_cloak");
		}
		CALLED_BY_DANGER = 0;
		if ((SPIT_WADS)) return;
		if (!(IsEntityAlive(m_hLastStruck))) return;
		ClearFX();
		EmitSound(GetOwner(), 0, SOUND_CLOAK, 10);
		Effect("glow", GetOwner(), Vector3(128, 255, 0), 256, 1, 1);
		SetProp(GetOwner(), "renderamt", 0);
		SetProp(GetOwner(), "renderfx", 0);
		SetMoveSpeed(5.0);
		npcatk_flee(GetEntityIndex(m_hLastStruck), 2048, DUR_CLOAK);
		AM_CLOAKED = 1;
		DUR_CLOAK("end_cloak");
	}

	void end_cloak()
	{
		EmitSound(GetOwner(), 0, SOUND_CLOAK, 10);
		AM_CLOAKED = 0;
		Effect("glow", GetOwner(), Vector3(128, 255, 0), 256, 2, 2);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
		SetMoveSpeed(1.0);
	}

	void OnDamage(int damage) override
	{
		if (!(AM_CLOAKED))
		{
			string T_BOX = /* TODO: $get_tbox */ $get_tbox("players", 256);
			if (T_BOX != "none")
			{
			}
			if (GetTokenCount(T_BOX, ";") > 2)
			{
			}
			CALLED_BY_DANGER = 1;
			do_cloak();
		}
		if (!(AM_CLOAKED)) return;
		int CAN_HIT = 0;
		if (param3 == "magic")
		{
			int CAN_HIT = 1;
		}
		if (param3 == "holy")
		{
			int CAN_HIT = 1;
		}
		if (param3 == "dark")
		{
			int CAN_HIT = 1;
		}
		if ((CAN_HIT)) return;
		SetDamage("hit");
		SetDamage("dmg");
		return;
	}

	void do_spores()
	{
		FREQ_SPORES("do_spores");
		if ((AM_CLOAKED)) return;
		if (!(false)) return;
		PlayAnim("critical", "turnright");
		EmitSound(GetOwner(), 0, SOUND_SPORES, 10);
		TossProjectile("proj_spore", /* TODO: $relpos */ $relpos(-10, 0, 32), m_hAttackTarget, 500, DMG_SPORE, 0.1, "none");
	}

	void mdl_attack()
	{
		if ((AM_CLOAKED)) return;
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, 0.9, "slash");
	}

	void game_dodamage()
	{
		if ((SWIPE_ATTACK))
		{
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 300, 110));
			if ((param1))
			{
				// PlayRandomSound from: SOUND_ATTACKHIT1, SOUND_ATTACKHIT2
				array<string> sounds = {SOUND_ATTACKHIT1, SOUND_ATTACKHIT2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
				array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			SWIPE_ATTACK = 0;
		}
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(AM_CLOAKED)) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		PUSH_TARG = param1;
	}

	void npcatk_run()
	{
		SetMoveAnim(ANIM_RUN);
		PlayAnim("once", ANIM_GALLOP);
	}

	void do_spitwad()
	{
		FREQ_SPITWAD("do_spitwad");
		if (!(false)) return;
		if ((AM_CLOAKED)) return;
		SetMoveAnim("flinchs");
		SetIdleAnim("flinchs");
		SetRoam(false);
		npcatk_suspend_ai();
		SPIT_WADS = 1;
		ScheduleDelayedEvent(4.0, "end_spitwad");
	}

	void end_spitwad()
	{
		SetRoam(true);
		SPIT_WADS = 0;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		npcatk_resume_ai();
	}

	void mdl_attack2()
	{
		EmitSound(GetOwner(), 0, SOUND_SPITWAD, 10);
		TossProjectile("proj_thorn", /* TODO: $relpos */ $relpos(20, 0, 16), m_hAttackTarget, 600, DMG_SPITWAD, 5, "none");
	}

	void mdl_jump_boost()
	{
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
		int JUMP_HEIGHT = RandomInt(150, 250);
		JUMP_HEIGHT += JUMP_HEIGHT_FACTOR;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_VICTORY)) return;
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += 10.0;
		PlayAnim("critical", ANIM_VICTORY);
	}

}

}
