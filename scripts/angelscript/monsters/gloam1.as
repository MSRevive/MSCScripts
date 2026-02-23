#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Gloam1 : CGameScript
{
	int AM_CLOAKED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CYCLES_STARTED;
	float FLEE_TIME;
	string JUMP_HEIGHT_FACTOR;
	string NEXT_JUMP;
	string NEXT_VICTORY;
	int NPC_GIVE_EXP;
	string PUSH_TARG;
	int SPIT_WADS;
	int SPORE_POISON_DMG;
	int SWIPE_ATTACK;

	Gloam1()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle_1";
		ANIM_FLINCH = "flinchb";
		ANIM_ATTACK = "bite";
		ANIM_DEATH = "die";
		const string ANIM_GALLOP = "gallop";
		const string ANIM_JUMP = "jump";
		const string ANIM_PROJECTILE = "turnright";
		const string ANIM_VICTORY = "eat";
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 34;
		NPC_GIVE_EXP = 250;
		const int FLEE_HEALTH = 500;
		const int FLEE_CHANCE = 25;
		FLEE_TIME = 5.0;
		const string FREQ_SPITWAD = Random(10, 20);
		const float DUR_CLOAK = 10.0;
		const string DMG_SWIPE = "$rand(20,40)";
		SPORE_POISON_DMG = 5;
		const int DMG_SPoRE = 50;
		const int DMG_SPITWAD = 20;
		const int JUMP_THRESHOLD = 80;
		const int JUMP_RANGE = 512;
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		const string SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		const string SOUND_DEATH = "aslave/slv_die2.wav";
		const string SOUND_PAIN1 = "aslave/slv_pain1.wav";
		const string SOUND_PAIN2 = "aslave/slv_pain2.wav";
		const string SOUND_SPITWAD = "headcrab/hc_attack1.wav";
		const string SOUND_JUMP = "aslave/slv_alert3.wav";
	}

	void OnSpawn() override
	{
		SetName("Gloam");
		SetModel("monsters/hunter1.mdl");
		SetRace("demon");
		SetBloodType("green");
		SetHearingSensitivity(11);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetWidth(32);
		SetHeight(32);
		SetHealth(1000);
		SetDamageResistance("poison", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("holy", 0.0);
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
		FREQ_SPITWAD("do_spitwad");
	}

	void mdl_attack()
	{
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

	void spitwad_loop()
	{
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
				ScheduleDelayedEvent(0.1, "spitwad_loop");
			}
		}
	}

	void do_spitwad()
	{
		FREQ_SPITWAD("do_spitwad");
		if (!(false)) return;
		if ((IS_FLEEING)) return;
		SetMoveAnim("flinchs");
		SetIdleAnim("flinchs");
		SetRoam(false);
		npcatk_suspend_ai();
		SPIT_WADS = 1;
		ScheduleDelayedEvent(4.0, "end_spitwad");
		ScheduleDelayedEvent(0.1, "spitwad_loop");
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

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_JUMP)) return;
		if (!(GetEntityRange(m_hAttackTarget) < JUMP_RANGE)) return;
		string MY_Z = GetMonsterProperty("origin.z");
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		if (RandomInt(1, 50) == 1)
		{
			int Z_DIFF = 81;
		}
		if (Z_DIFF > JUMP_THRESHOLD)
		{
			JUMP_HEIGHT_FACTOR = Z_DIFF;
			JUMP_HEIGHT_FACTOR *= 2;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			PlayAnim("critical", ANIM_JUMP);
			NEXT_JUMP = GetGameTime();
			NEXT_JUMP += 2.0;
		}
	}

	void mdl_jump_boost()
	{
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
		string JUMP_HEIGHT = RandomInt(250, 350);
		JUMP_HEIGHT += JUMP_HEIGHT_FACTOR;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void OnFlee()
	{
		ScheduleDelayedEvent(0.1, "flee_boost");
	}

	void flee_boost()
	{
		JUMP_HEIGHT_FACTOR = JUMP_THRESHOLD;
		PlayAnim("critical", ANIM_JUMP);
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
